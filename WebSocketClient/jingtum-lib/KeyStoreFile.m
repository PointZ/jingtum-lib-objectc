//
//  KeyStoreFile.m
//  WebSocketClient
//
//  Created by ZDC on 2019/8/5.
//  Copyright © 2019 tongmuxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyStoreFile.h"

//227-262
@implementation CipherParams

-(NSString *)getIv
{
    return iv;
}

-(void)setIv:(NSString *)_iv;
{
    iv = _iv;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    
    if (![object isKindOfClass:[CipherParams class]])
    {
        return NO;
    }
    
    CipherParams* obj = (CipherParams*)object;
    
    return [[self getIv]isEqual:[obj getIv]];
}
- (NSUInteger)hash
{
    NSUInteger result = iv != nil ? [iv hash] : 0;
    return result;
}

@end

/**********************************************/

//270-346
@implementation Aes128CtrKdfParams

-(id)init
{
    self = [super init];
    return self;
}
-(int)getDklen
{
    return dklen;
}
-(void)setDklen:(int)_dklen
{
    dklen = _dklen;
}
-(int)getC
{
    return c;
}
-(void)setC:(int)_c
{
    c = _c;
}
-(NSString *)getPrf
{
    return prf;
}
-(void)setPrf:(NSString *)_prf
{
    prf = _prf;
}
-(NSString *)getSalt
{
    return salt;
}
-(void)setSalt:(NSString *)_salt
{
    salt = _salt;
}
-(BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    
    if (![object isKindOfClass:[Aes128CtrKdfParams class]])
    {
        return NO;
    }
    
    Aes128CtrKdfParams* obj = (Aes128CtrKdfParams*)object;
    if(dklen != [obj getDklen])
    {
        return NO;
    }
    if(c != [obj getC])
    {
        return NO;
    }
    if(prf != nil ? ![prf isEqual:[obj getPrf]] : [obj getPrf] != nil)
    {
        return NO;
    }
    return salt != nil ? [salt isEqual:[obj getSalt]] : [obj getSalt] == nil;
}
-(NSUInteger)hash
{
    NSUInteger result = dklen;
    result = 31*result+c;
    result = 31*result+(prf != nil ? [prf hash]:0);
    result = 31*result+(salt != nil ? [salt hash]:0);
    return result;
}

@end

/**********************************************/

//348-435
@implementation ScryptKdfParams

-(id)init
{
    self = [super init];
    return self;
}
-(int)getDklen
{
    return dklen;
}
-(void)setDklen:(int)_dklen
{
    dklen = _dklen;
}
-(int)getN
{
    return n;
}
-(void)setN:(int)_n
{
    n = _n;
}
-(int)getP
{
    return p;
}
-(void)setP:(int)_p
{
    p = _p;
}
-(int)getR
{
    return r;
}
-(void)setR:(int)_r
{
    r = _r;
}

-(NSString *)getSalt
{
    return salt;
}
-(void)setSalt:(NSString *)_salt
{
    salt = _salt;
}

-(BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    
    if (![object isKindOfClass:[ScryptKdfParams class]])
    {
        return NO;
    }
    
    ScryptKdfParams* obj = (ScryptKdfParams*)object;
    if(dklen != [obj getDklen])
    {
        return NO;
    }
    if(n != [obj getN])
    {
        return NO;
    }
    if(p != [obj getP])
    {
        return NO;
    }
    if(r != [obj getR])
    {
        return NO;
    }

    return salt != nil ? [salt isEqual:[obj getSalt]] : [obj getSalt] == nil;
}
-(NSUInteger)hash
{
    NSUInteger result = dklen;
    result = 31*result+n;
    result = 31*result+p;
    result = 31*result+r;
    result = 31*result+(salt != nil ? [salt hash]:0);
    return result;
}

@end

/**********************************************/

//102-225
@implementation Crypto
-(id)init
{
    self = [super init];
    return self;
}

-(NSString *)getCipher
{
    return cipher;
}
-(void)setCipher:(NSString *)_cipher
{
    cipher = _cipher;
}
-(NSString *)getCiphertext
{
    return ciphertext;
}
-(void)setCiphertext:(NSString *)_ciphertext
{
    ciphertext = _ciphertext;
}
-(CipherParams *)getCipherparams
{
    return cipherparams;
}
-(void)setCipherparams:(CipherParams *)_cipherparams
{
    cipherparams =_cipherparams;
}
-(NSString *)getKdf
{
    return kdf;
}
-(void)setKdf:(NSString *)_kdf
{
    kdf = _kdf;
}
-(id<KdfParams>)getKdfparams
{
    return kdfparams;
}
-(void)setKdfparam:(id<KdfParams>)_kdfparams
{
    kdfparams =_kdfparams;
}
-(NSString *)getMac
{
    return mac;
}
-(void)setMac:(NSString *)_mac
{
    mac = _mac;
}

//json


-(BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    
    if (![object isKindOfClass:[Crypto class]])
    {
        return NO;
    }
    
    Crypto* obj = (Crypto*)object;

    if(cipher != nil ? ![cipher isEqual:[obj getCipher]] : [obj getCipher] != nil)
    {
        return NO;
    }
    if(ciphertext != nil ? ![ciphertext isEqual:[obj getCiphertext]] : [obj getCiphertext] != nil)
    {
        return NO;
    }
    if(cipherparams != nil ? ![cipherparams isEqual:[obj getCipherparams]] : [obj getCipherparams] != nil)
    {
        return NO;
    }
    if(kdf != nil ? ![kdf isEqual:[obj getKdf]] : [obj getKdf] != nil)
    {
        return NO;
    }
    if(kdfparams != nil ? ![kdfparams isEqual:[obj getKdfparams]] : [obj getKdfparams] != nil)
    {
        return NO;
    }

    return mac != nil ? [mac isEqual:[obj getMac]] : [obj getMac] == nil;
}
-(NSUInteger)hash
{
    NSUInteger result = (cipher != nil ? [cipher hash] : 0);
    result = 31 * result+(ciphertext != nil ? [ciphertext hash] : 0);
    result = 31 * result+(cipherparams != nil ? [cipherparams hash] : 0);
    result = 31 * result+(kdf != nil ? [kdf hash] : 0);
    result = 31 * result+(kdfparams != nil ? [kdfparams hash] : 0);
    result = 31 * result+(mac != nil ? [mac hash] : 0);
    return result;
}

@end

/**********************************************/
//16 - 100 & 463 - 473
@implementation KeyStoreFile

-(id)init
{
    self = [super init];
    return self;
}
-(NSString *)getAddress
{
    return address;
}
-(void)setAddress:(NSString *)_address
{
    address = _address;
}
-(Crypto *)getCrypto
{
    return crypto;
}
-(void)setCrypto:(Crypto *)_crypto
{
    crypto = _crypto;
}
-(NSString *)getId
{
    return ID;
}
-(void)setId:(NSString *)_ID
{
    ID = _ID;
}
-(int)getVersion
{
    return version;
}
-(void)setVersion:(int)_version
{
    version = _version;
}

-(BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    
    if (![object isKindOfClass:[KeyStoreFile class]])
    {
        return NO;
    }
    
    KeyStoreFile * obj = (KeyStoreFile *)object;
    
    if(address != nil ? ![address isEqual:[obj getAddress]] : [obj getAddress] != nil)
    {
        return NO;
    }
    if(crypto != nil ? ![crypto isEqual:[obj getCrypto]] : [obj getCrypto] != nil)
    {
        return NO;
    }
    if(ID != nil ? ![ID isEqual:[obj getId]] : [obj getId] != nil)
    {
        return NO;
    }
    return version == [obj getVersion];
}
-(NSUInteger)hash
{
    NSUInteger result = (address != nil ? [address hash] : 0);
    result = 31 * result+(crypto != nil ? [crypto hash] : 0);
    result = 31 * result+(ID != nil ? [ID hash] : 0);
    result = 31 * result+version;
    return result;
}

//temp
-(KeyStoreFile *) parse:(NSString *)keystore
{
    KeyStoreFile *result = [[KeyStoreFile alloc] init];
    return result;
}

//temp
-(NSString *)description
{
    return [NSString stringWithFormat:@"temp"];
}

@end
