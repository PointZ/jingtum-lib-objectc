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
int main(int argc, char * argv[]) {
    NAChlorideInit();
    NSString *secret = @"shExMjiMqza4DdMaSg3ra9vxWPZsQ";
    Seed * seed = [Seed alloc];
    Keypairs *keypairs = [seed deriveKeyPair:secret];
    Wallet *wallet = [[Wallet alloc]initWithKeypairs:keypairs private:secret];
    
    
    
    NSLog(@"git test");
    NSData *key = [@"Key123456" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *salt = [NARandom randomData:32];
    NSError *error = nil;
    NSData *derivedKey = [NAScrypt scrypt:key salt:salt N:1<<12 r:8 p:6 length:32 error:&error];
    
    NSLog(@"%@",derivedKey);
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
