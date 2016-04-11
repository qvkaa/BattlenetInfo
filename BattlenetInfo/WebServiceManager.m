//
//  WebServiceManager.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/2/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "WebServiceManager.h"
#import <AFHTTPRequestSerializer+OAuth2.h>
static NSString * const CLIENT_ID = @"r6f5spyft2eneundahqtrtap2pkmctx5";
static NSString * const CLIENT_SECRET = @"f4bcRfYnwMmX4rgyYXeRuRqbC3SH8gPd";
static NSString * const TEST_USERNAME = @"qvkaacc@abv.bg";
static NSString * const TEST_PASSWORD = @"qwerty123";
//iOSBattlenetInfo
//com.yavorAleksiev.battlenetInfo
@implementation WebServiceManager

#pragma mark - lifecycle

+ (id)sharedWebServiceManager {
    static WebServiceManager *sharedWebServiceManager = nil;
    @synchronized (self) {
        if (sharedWebServiceManager == nil)
            sharedWebServiceManager = [[self alloc] init];
        [AFHTTPRequestOperationManager manager].securityPolicy.allowInvalidCertificates = YES;
    }
    return sharedWebServiceManager;
}

#pragma mark - authentication process

- (void)authenticateWithUsername:(NSString *)userName password:(NSString *)password region:(NSString*)region {
   
    //NSURL *baseURL = [NSURL URLWithString:@"https://eu.battle.net"];
    NSString *baseURLString = @"https://eu.battle.net/oauth/authorize";

    NSURL *baseURL = [NSURL URLWithString:baseURLString];
       AFOAuth2Manager *OAuth2Manager = [AFOAuth2Manager clientWithBaseURL:baseURL clientID:TEST_USERNAME secret:CLIENT_SECRET];
//    AFOAuth2Manager *OAuth2Manager =
//    [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
//                                    clientID:CLIENT_ID
//                                      secret:CLIENT_SECRET];
    OAuth2Manager.securityPolicy.allowInvalidCertificates = YES;
    __block AFOAuthCredential *credentials;
    [OAuth2Manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                CLIENT_ID, @"client_id",
                                @"wow.profile", @"scope",
                                @"test", @"state",
                                @"https://localhost", @"redirect_uri",
                                @"code", @"response_type",
                                nil];
    [OAuth2Manager GET:baseURLString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        int a = 5;
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        int a = 5;
    }];
//    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/oauth/authorize"
//                                              username:TEST_USERNAME
//                                              password:TEST_PASSWORD
//                                                 scope:@"wow.profile"
//                                               success:^(AFOAuthCredential *credential) {
//                                                   NSLog(@"Token: %@", credential.accessToken);
//                                                   credentials = credential;
//                                               }
//                                               failure:^(NSError *error) {
//                                                   NSLog(@"Error: %@", error);
//                                               }];
//    
//    AFHTTPRequestOperationManager *manager =
//    [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
//    
//    [manager.requestSerializer setAuthorizationHeaderFieldWithCredential:credentials];
//    
//    [manager GET:@"/path/to/protected/resource"
//      parameters:nil
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             NSLog(@"Success: %@", responseObject);
//         }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             NSLog(@"Failure: %@", error);
//         }];
}
@end
