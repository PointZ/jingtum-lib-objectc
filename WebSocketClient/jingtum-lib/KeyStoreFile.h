//
//  KeyStoreFile.h
//  WebSocketClient
//
//  Created by ZDC on 2019/8/5.
//  Copyright © 2019 tongmuxu. All rights reserved.
//

#ifndef KeyStoreFile_h
#define KeyStoreFile_h

#import <Foundation/Foundation.h>

//227-262
@interface CipherParams : NSObject
{
    NSString *iv;
}
-(NSString *)getIv;
-(void)setIv:(NSString *)_iv;
-(BOOL)isEqual:(id)object;
-(NSUInteger)hash;
@end

//264-268
@protocol KdfParams <NSObject>
@required
-(NSUInteger)getDklen;
-(NSString *)getSalt;
@end

//270-346
@interface Aes128CtrKdfParams: NSObject<KdfParams>
{
    int dklen;
    int c;
    NSString *prf;
    NSString *salt;
}
-(int)getDklen;
-(void)setDklen:(int)_dklen;
-(int)getC;
-(void)setC:(int)_c;
-(NSString *)getPrf;
-(void)setPrf:(NSString *)_prf;
-(NSString *)getSalt;
-(void)setSalt:(NSString *)_salt;
-(BOOL)isEqual:(id)object;
-(NSUInteger)hash;

@end

//348-435
@interface ScryptKdfParams: NSObject<KdfParams>
{
    int dklen;
    int n;
    int p;
    int r;
    NSString *salt;
}
-(int)getDklen;
-(void)setDklen:(int)_dklen;
-(int)getN;
-(void)setN:(int)_n;
-(int)getP;
-(void)setP:(int)_p;
-(int)getR;
-(void)setR:(int)_r;
-(NSString *)getSalt;
-(void)setSalt:(NSString *)_salt;
-(BOOL)isEqual:(id)object;
-(NSUInteger)hash;

@end

//439-461
//json about


//102-225
@interface Crypto : NSObject
{
    NSString *cipher;
    NSString *ciphertext;
    CipherParams *cipherparams;
    NSString *kdf;
    id<KdfParams> kdfparams;
    NSString *mac;
}
-(NSString *)getCipher;
-(void)setCipher:(NSString *)_cipher;
-(NSString *)getCiphertext;
-(void)setCiphertext:(NSString *)_ciphertext;
-(CipherParams *)getCipherparams;
-(void)setCipherparams:(CipherParams *)_cipherparams;
-(NSString *)getKdf;
-(void)setKdf:(NSString *)_kdf;
-(id<KdfParams>)getKdfparams;
-(void)setKdfparam:(id<KdfParams>)_kdfparams;
-(NSString *)getMac;
-(void)setMac:(NSString *)_mac;

@end


//16 - 100 & 463 - 473
@interface KeyStoreFile : NSObject
{
    NSString *address;
    Crypto *crypto;
    NSString *ID;//id is key word , so use ID
    int version;
}
-(NSString *)getAddress;
-(void)setAddress:(NSString *)_address;
-(Crypto *)getCrypto;
-(void)setCrypto:(Crypto *)_crypto;
-(NSString *)getId;
-(void)setId:(NSString *)_ID;
-(int)getVersion;
-(void)setVersion:(int)_version;
-(KeyStoreFile *) parse:(NSString *)keystore;
//toString use description
@end

#endif /* KeyStoreFile_h */

