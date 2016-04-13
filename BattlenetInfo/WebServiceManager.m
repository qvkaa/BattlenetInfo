//
//  WebServiceManager.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/2/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "WebServiceManager.h"
#import <AFHTTPRequestSerializer+OAuth2.h>
static NSString * const CALLBACK_URL = @"https://localhost:12345/code";
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
#pragma mark - request
- (void)fetchImageInfoForManufacturer:(NSString *)manufacturer model:(NSString *)model color:(NSString *)color withCompletionBlock:(void (^)(NSArray *array))completionBlock {
    
}
#pragma mark - authentication process
- (NSURLRequest *)urlRequestForLoginForRegion:(BattlenetRegion)region {
    NSString *urlString = [self authorizeURIForRegion:region];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = @"GET";
    [urlRequest setAllHTTPHeaderFields:[self authorizeHeaderDictionary]];
    
    return urlRequest;
}
//- (void)authenticateWithUsername:(NSString *)userName password:(NSString *)password region:(NSString*)region {
//
//    //NSURL *baseURL = [NSURL URLWithString:@"https://eu.battle.net"];
//    NSString *baseURLString = @"https://eu.battle.net/oauth/authorize";
//
//    NSURL *baseURL = [NSURL URLWithString:baseURLString];
//       AFOAuth2Manager *OAuth2Manager = [AFOAuth2Manager clientWithBaseURL:baseURL clientID:TEST_USERNAME secret:CLIENT_SECRET];
////    AFOAuth2Manager *OAuth2Manager =
////    [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
////                                    clientID:CLIENT_ID
////                                      secret:CLIENT_SECRET];
//    OAuth2Manager.securityPolicy.allowInvalidCertificates = YES;
//    __block AFOAuthCredential *credentials;
//    [OAuth2Manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
//
//
//    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                CLIENT_ID, @"client_id",
//                                @"wow.profile", @"scope",
//                                @"test", @"state",
//                                @"https://localhost", @"redirect_uri",
//                                @"code", @"response_type",
//                                nil];
//    [OAuth2Manager GET:baseURLString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//
//    }];
//
//}


#pragma mark - private helper methods
- (NSDictionary *)authorizeHeaderDictionary {
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                CLIENT_ID, @"client_id",
                                @"wow.profile", @"scope",
                                @"test", @"state",
                                @"https://localhost", @"redirect_uri",
                                @"code", @"response_type",
                                nil];
    return parameters;
}
- (NSString *)authorizeURIForRegion:(BattlenetRegion)region {
    NSString *uriParameter;
    switch (region) {
        case BattlenetRegionEU: {
            uriParameter = @"eu";
        } break;
            
        case BattlenetRegionUS: {
            uriParameter = @"us";
        } break;
            
        case BattlenetRegionKR: {
            uriParameter = @"kr";
        } break;
            
        case BattlenetRegionTW: {
            uriParameter = @"tw";
        } break;
            
        case BattlenetRegionCN: {
            return @"https://www.battlenet.com.cn/oauth/authorize";
        }break;
            
        default:{
            return nil;
        } break;
    }
    return [NSString stringWithFormat:@"https://%@.battle.net/oauth/authorize",uriParameter];
}
- (NSString *)tokenURIForRegion:(BattlenetRegion)region {
    NSString *uriParameter;
    switch (region) {
        case BattlenetRegionEU: {
            uriParameter = @"eu";
        } break;
            
        case BattlenetRegionUS: {
            uriParameter = @"us";
        } break;
            
        case BattlenetRegionKR: {
            uriParameter = @"kr";
        } break;
            
        case BattlenetRegionTW: {
            uriParameter = @"tw";
        } break;
            
        case BattlenetRegionCN: {
            return @"https://www.battlenet.com.cn/oauth/token";
        }break;
            
        default:{
            return nil;
        } break;
    }
    return [NSString stringWithFormat:@"https://%@.battle.net/oauth/token",uriParameter];
}
@end
