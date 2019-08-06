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


@interface Crypto : NSObject
{
    NSString *cipher;
    NSString *ciphertext;
    
    
}

@end

@interface KeyStoreFile : NSObject
{
    NSString *address;
    
}

@end

#endif /* KeyStoreFile_h */

