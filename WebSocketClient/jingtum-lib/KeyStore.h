//
//  KeyStore.h
//  WebSocketClient
//
//  Created by jch01 on 2019/8/12.
//  Copyright © 2019 tongmuxu. All rights reserved.
//

#ifndef KeyStore_h
#define KeyStore_h

#import "KeyStoreFile.h"
#import "Wallet.h"

@interface KeyStore : NSObject

+(KeyStoreFileModel*)createStandard:(NSString*)password wallet:(Wallet*)wallet;
+(KeyStoreFileModel*)createLight:(NSString*)password wallet:(Wallet*)wallet;
+(KeyStoreFileModel*)create:(NSString*)password wallet:(Wallet*)wallet n:(int)n p:(int)p;

@end

#endif /* KeyStore_h */
