//
//  KeyStoreFile.m
//  WebSocketClient
//
//  Created by ZDC on 2019/8/5.
//  Copyright © 2019 tongmuxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyStoreFile.h"

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

@implementation Crypto


@end

@implementation KeyStoreFile


@end
