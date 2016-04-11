//
//  WebServiceManager.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/2/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFOAuth2Manager.h>

@interface WebServiceManager : NSObject

+ (id)sharedWebServiceManager;

- (void)authenticateWithUsername:(NSString *)userName password:(NSString *)password region:(NSString*)region;
- (void)authorizeRequest;
- (void)storeCredentials;
- (void)retrievieCredentials;
@end
