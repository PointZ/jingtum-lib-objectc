//
//  main.m
//  WebSocketClient
//
//  Created by tongmuxu on 2018/5/15.
//  Copyright © 2018年 tongmuxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "NAChloride.h"
#import "Wallet.h"
#import "Seed.h"

#import "NADigest.h"
#import "NAKeccak.h"
//#import "NASHA3.h"

#import "KeyStoreFile.h"
#import "KeyStore.h"

int main(int argc, char * argv[]) {
    /*

    
    
    NSLog(@"address:%@",[keystore address]);
    NSLog(@"id:%@",[keystore id]);
    NSLog(@"version:%d",[keystore version]);
    NSLog(@"crypto:%@",[[keystore crypto]cipher]);
    NSLog(@"c:%d",[[[keystore crypto]kdfparams]c]);
    NSLog(@"json:%@",[keystore toJSONString]);
    
    

    NAChlorideInit();
    NSString *secret = @"shExMjiMqza4DdMaSg3ra9vxWPZsQ";
    Seed * seed = [Seed alloc];
    Keypairs *keypairs = [seed deriveKeyPair:secret];
    Wallet *wallet = [[Wallet alloc]initWithKeypairs:keypairs private:secret];
    NSData *data =[@"Key123456" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *sha = [NAKeccak SHA3ForData:data digestBitLength:512];
    
    
    NSLog(@"git test");
    
    NSData *key = [@"Key123456" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *salt = [NARandom randomData:32];
    NSError *error = nil;
    NSData *derivedKey = [NAScrypt scrypt:key salt:salt N:1<<12 r:8 p:6 length:32 error:&error];
    NSData *encryoptKey =[derivedKey subdataWithRange:NSMakeRange(0, 16)];
    NSData *iv = [NARandom randomData:16];
    NSData *privateKeyBytes = [[wallet secret] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"salt:%@",salt);
    NSLog(@"derivedKey:%@",derivedKey);
    NSLog(@"encryoptKey:%@",encryoptKey);
    NSLog(@"iv:%@",iv);
    NSLog(@"privateKeyBytes:%@",privateKeyBytes);
    */
    //NSLog(@"%@",derivedKey);
    
    NAChlorideInit();
    NSString *secret = @"shExMjiMqza4DdMaSg3ra9vxWPZsQ";
    Seed * seed = [Seed alloc];
    Keypairs *keypairs = [seed deriveKeyPair:secret];
    Wallet *wallet = [[Wallet alloc]initWithKeypairs:keypairs private:secret];
    KeyStoreFileModel *keyStoreFile = [KeyStore createLight:@"Key123456" wallet:wallet];
    NSLog(@"json:%@",[keyStoreFile toJSONString]);
    Wallet *decryptEthECKeyPair = [KeyStore decrypt:@"Key123456" wallerFile:keyStoreFile];
    //NSLog(@"address:%@",[decryptEthECKeyPair toJSONString]);
    
    Keypairs *temp = [decryptEthECKeyPair keypairs] ;
    
    NSData *bytes = [[temp pub] BTCHash160];
    BTCAddress *btcAddress = [BTCPublicKeyAddress addressWithData:bytes];
    NSString *address = btcAddress.base58String;
    NSLog(@"address: %@", address);
    
    NSLog(@"PrivateKey:%@",[decryptEthECKeyPair secret]);
    
    
    NSString* jsondata = @"{\"address\":\"jHY6aRcs7J6KnfgqD4FVwTQ247boj9nbDZ\",\"id\":\"1c1bf720-82fd-4ed3-bddf-72ebbc7b4262\",\"version\":3,\"crypto\":{\"cipher\":\"aes-128-ctr\",\"ciphertext\":\"0bc63928ace81eb82869d5008372830191bad7706ef2101665d009a9e6\",\"cipherparams\":{\"iv\":\"2ae846f498bbb6ff6a7d572d51cdd74b\"},\"kdf\":\"scrypt\",\"kdfparams\":{\"dklen\":32,\"n\":4096,\"p\":6,\"r\":8,\"salt\":\"944611340b628e66850eff427ec0df006788d2aa7e3809b383dbe05282edd723\"},\"mac\":\"ad1343750c048c96b019dc09dd6a5b93d5664cfd5147dd052ec040546d53617f\"}}";
    NSError* err = nil;
    KeyStoreFileModel* keystore = [[KeyStoreFileModel alloc] initWithString:jsondata error:&err];
    
    Wallet *wallet2 = [KeyStore decrypt:secret wallerFile:keystore];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
