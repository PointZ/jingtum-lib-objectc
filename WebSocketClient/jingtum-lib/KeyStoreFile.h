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


@interface CipherParams : NSObject
{
    NSString *iv;
}
-(NSString *)getIv;
-(void)setIv:(NSString *)_iv;
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

