//
//  KeyStore.m
//  WebSocketClient
//
//  Created by jch01 on 2019/8/12.
//  Copyright © 2019 tongmuxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyStore.h"
#import "NAChloride.h"
#import "Wallet.h"
#import "Seed.h"

#import "NSString+Base58.h"

#include <CommonCrypto/CommonCryptor.h>


#import "NADigest.h"
#import "NAKeccak.h"
#import "NASHA3.h"

static int N_LIGHT = 1<<12;
static int P_LIGHT = 6;
static int N_STANDARD = 1<<18;
static int P_STANDARD = 1;
static int R = 18;
static int DKLEN = 32;
static int CURRTENT_VERSION = 3;

static NSString* CIPHER = @"aes-128-ctr";
static NSString* AES_128_CTR = @"pbkdf2";
static NSString* SCRYPT = @"scrypt";


@implementation KeyStore

+(KeyStoreFileModel*)createStandard:(NSString*)password wallet:(Wallet*)wallet
{
    return [self create:password wallet:wallet n:N_STANDARD p:P_STANDARD];
}
+(KeyStoreFileModel*)createLight:(NSString*)password wallet:(Wallet*)wallet
{
    return [self create:password wallet:wallet n:N_LIGHT p:P_LIGHT];
}
+(KeyStoreFileModel*)create:(NSString*)password wallet:(Wallet*)wallet n:(int)n p:(int)p
{
    NAChlorideInit();
    
    NSData *salt = [NARandom randomData:32];
    NSData *passwordByte = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSData *derivedKey = [NAScrypt scrypt:passwordByte salt:salt N:n r:R p:p length:DKLEN error:&error];
    NSData *encryoptKey =[derivedKey subdataWithRange:NSMakeRange(0, 16)];
    NSData *iv = [NARandom randomData:16];
    NSData *privateKeyBytes = [[wallet secret] dataUsingEncoding:NSUTF8StringEncoding];
    NSData *cipherText = [self aesEncryptData:privateKeyBytes key:encryoptKey iv:iv];
    NSData *mac = [self generateMac:derivedKey cipherText:cipherText];
    
    return [self createWalletFile:wallet cipherText:cipherText iv:iv salt:salt mac:mac n:n p:p];
    
}

+(KeyStoreFileModel*)createWalletFile:(Wallet*)wallet cipherText:(NSData*)cipherText iv:(NSData*)iv salt:(NSData*)salt mac:(NSData*)mac n:(int)n p:(int)p
{
    KeyStoreFileModel* keyStoreFile = [[KeyStoreFileModel alloc]init];
    NSData *bytes = [[[wallet keypairs] getPublicKey] BTCHash160];
    BTCAddress *btcAddress = [BTCPublicKeyAddress addressWithData:bytes];
    NSString *address = btcAddress.base58String;
    
    [keyStoreFile setAddress:address];
    
    CryptoModel *crypto = [[CryptoModel alloc]init];
    [crypto setCipher:CIPHER];
    [crypto setCiphertext:[self convertDataToHexStr:cipherText]];
    
    CipherparamsModel *cipherParams = [[CipherparamsModel alloc]init];
    [cipherParams setIv:[self convertDataToHexStr:iv]];
    [crypto setCipherparams:cipherParams];
    [crypto setKdf:SCRYPT];
    
    KdfparamsModel *kdfParams = [[KdfparamsModel alloc]init];
    [kdfParams setN:n];
    [kdfParams setP:p];
    [kdfParams setR:R];
    [kdfParams setDklen:DKLEN];
    [kdfParams setSalt:[self convertDataToHexStr:salt]];
    [crypto setKdfparams:kdfParams];
    
    [crypto setMac:[self convertDataToHexStr:mac]];
    
    [keyStoreFile setCrypto:crypto];
    [keyStoreFile setId:[self getUUID]];
    
    [keyStoreFile setVersion:CURRTENT_VERSION];

    return keyStoreFile;
}

+(Wallet*) decrypt:(NSString*)password wallerFile:(KeyStoreFileModel*) walletFile
{
    //yanzheng
    
    CryptoModel *crypto = [walletFile crypto];
    
    NSData* mac = [self convertBytesStringToData:[crypto mac]];
    NSData* iv = [self convertBytesStringToData:[[crypto cipherparams]iv]];
    NSData* cipherText = [self convertBytesStringToData:[crypto ciphertext]];
    
    NSData* derivedKey;
    KdfparamsModel *kdfparams = [crypto kdfparams];
    if([kdfparams prf] == nil)
    {
        int dklen = [kdfparams dklen];
        int n = [kdfparams n];
        int p = [kdfparams p];
        int r = [kdfparams r];
        NSData *salt = [self convertBytesStringToData:[kdfparams salt]];
        NSError *error = nil;
        NSData *passwordByte = [password dataUsingEncoding:NSUTF8StringEncoding];
        derivedKey = [NAScrypt scrypt:passwordByte salt:salt N:n r:r p:p length:dklen error:&error];
    }
    else if([kdfparams prf] != nil && [kdfparams c]!=0)
    {
        
    }
    
    NSData *derivedMac = [self generateMac:derivedKey cipherText:cipherText];
    if(![derivedMac isEqual:mac])
    {
        NSLog(@"Invaild password provided");
        return nil;
    }
    NSData *encryoptKey = [derivedKey subdataWithRange:NSMakeRange(0, 16)];
    NSData *privateKey = [self aesDecryptData:cipherText key:encryoptKey iv:iv];
    NSString *privateKeyUTF8 = [[NSString alloc] initWithData:privateKey encoding:NSUTF8StringEncoding];

    Seed *seed = [[Seed alloc] init];
    Keypairs *keypairs = [seed deriveKeyPair:privateKeyUTF8];
    Wallet *wallet = [[Wallet alloc] initWithKeypairs:keypairs private:privateKeyUTF8];
    return wallet;
}

+(NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

+(NSData*) convertBytesStringToData:(NSString *)str
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= [str length]; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

+(NSString *)getUUID
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return result;
}

+(NSData*) cipherOperation:(NSData*)contentData key:(NSData*)keyData iv:(NSData*)initVector operation:(CCOperation)operation
{
    NSUInteger dataLength = contentData.length;
    
    void const *initVectorBytes = initVector.bytes;
    void const *contentBytes = contentData.bytes;
    void const *keyBytes = keyData.bytes;
    
    size_t operationSize = dataLength + kCCBlockSizeAES128;
    void *operationBytes = malloc(operationSize);
    if (operationBytes == NULL) {
        return nil;
    }
    size_t actualOutSize = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyBytes,
                                          kCCKeySizeAES128,
                                          initVectorBytes,
                                          contentBytes,
                                          dataLength,
                                          operationBytes,
                                          operationSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:operationBytes length:actualOutSize];
    }
    free(operationBytes);
    operationBytes = NULL;
    return nil;
}

+(NSData*) aesEncryptData:(NSData*)contentData key:(NSData*)keyData iv:(NSData*)iv
{
    return [self cipherOperation:contentData key:keyData iv:iv operation:kCCEncrypt];
}

+(NSData*) aesDecryptData:(NSData*)contentData key:(NSData*)keyData iv:(NSData*)iv
{
    return [self cipherOperation:contentData key:keyData iv:iv operation:kCCDecrypt];
}

+(NSData*) generateMac:(NSData*)derivedKey cipherText:(NSData*)cipherText
{
    NSMutableData *mData = [[NSMutableData alloc] init];
    [mData appendData:derivedKey];
    [mData appendData:cipherText];
    return [NAKeccak SHA3ForData:mData digestBitLength:512];
}
@end

