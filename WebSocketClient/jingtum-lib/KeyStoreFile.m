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
    
    return [[self getIv]isEqualToString:[obj getIv]];
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
    if(prf != nil ? ![prf isEqualToString:[obj getPrf]] : [obj getPrf] != nil)
    {
        return NO;
    }
    return salt != nil ? [salt isEqualToString:[obj getSalt]] : [obj getSalt] == nil;
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

    return salt != nil ? [salt isEqualToString:[obj getSalt]] : [obj getSalt] == nil;
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



@implementation Crypto


@end

@implementation KeyStoreFile


@end
