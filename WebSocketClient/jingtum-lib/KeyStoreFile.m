//
//  KeyStore.m
//  WebSocketClient
//
//  Created by jch01 on 2019/8/12.
//  Copyright © 2019 tongmuxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyStoreFile.h"

@implementation CipherparamsModel
@end


@implementation KdfparamsModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"c"])
        return YES;
    if ([propertyName isEqualToString:@"n"])
        return YES;
    if ([propertyName isEqualToString:@"p"])
        return YES;
    if ([propertyName isEqualToString:@"r"])
        return YES;
    return NO;
}

@end


@implementation CryptoModel
@end


@implementation KeyStoreFileModel
@end
