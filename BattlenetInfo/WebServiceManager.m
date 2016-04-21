//
//  WebServiceManager.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/2/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "WebServiceManager.h"


static NSString * const CALLBACK_URL = @"https://localhost:12345/code";
static NSString * const CLIENT_ID = @"r6f5spyft2eneundahqtrtap2pkmctx5";
static NSString * const CLIENT_SECRET = @"f4bcRfYnwMmX4rgyYXeRuRqbC3SH8gPd";
static NSString * const TEST_USERNAME = @"qvkaacc@abv.bg";
static NSString * const TEST_PASSWORD = @"qwerty123";
//iOSBattlenetInfo
//com.yavorAleksiev.battlenetInfo
@implementation WebServiceManager

#pragma mark - lifecycle


#pragma mark - request
//- (void)fetchProfileWithBattleTag:(NSString *)battletag region:(BattlenetRegion)region withCompletionBlock:(void (^)(NSDictionary *dictonary))completionBlock {
//  
//    NSString *urlString =[self URIStringWithBattleTag:battletag region:region];
//    
//    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@","];
//    
//    NSURL *URL = [NSURL URLWithString:urlString];
//    
//    [[AFHTTPSessionManager manager] GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        
//        
//        NSDictionary *photos = [responseObject objectForKey:@"photos"];
//        NSArray *array = [photos objectForKey:@"photo"];
//        
//        if ([array count] > 0) {
//            completionBlock(responseObject);
//        } else {
//            completionBlock(nil);
//        }
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        completionBlock(nil);
//    }];
//}
- (void)fetchProfileWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(NSDictionary *dictonary))completionBlock {
    
    NSString *newBattleTag = [self changeBattletagFormat:battletag];
    
    NSString *urlString =[self URIStringWithBattleTag:newBattleTag region:region];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    
    [[AFHTTPSessionManager manager] GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* code = [responseObject objectForKey:@"code"];
            if ([code isEqualToString:@"NOTFOUND"]) {
                NSLog(@"%@",[responseObject objectForKey:@"reason"]);
                completionBlock(nil);
            } else {
                completionBlock(responseObject);
            }
        } else {
            completionBlock(nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completionBlock(nil);
    }];
}
- (void)fetchCharacterInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID withCompletionBlock:(void (^)(NSDictionary *dictonary))completionBlock {
    
    NSString *newBattleTag = [self changeBattletagFormat:battletag];
    
    NSString *urlString =[self URIStringWithBattleTag:newBattleTag region:region];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    
    [[AFHTTPSessionManager manager] GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* code = [responseObject objectForKey:@"code"];
            if ([code isEqualToString:@"NOTFOUND"]) {
                NSLog(@"%@",[responseObject objectForKey:@"reason"]);
                completionBlock(nil);
            } else {
                completionBlock(responseObject);
            }
        } else {
            completionBlock(nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completionBlock(nil);
    }];
}


#pragma mark - private helper methods
- (NSString *)changeBattletagFormat:(NSString *)battleTag {
    if ([battleTag length] < 6) {
        return nil;
    }
    NSMutableString *newBattleTag = [battleTag mutableCopy];
    NSUInteger index = [newBattleTag length] - 5;
    NSRange range = NSMakeRange(index, 1);
    [newBattleTag replaceCharactersInRange:range withString:@"-"];
    
    return newBattleTag;
}
- (NSString *)URIcharacterStringWithBattleTag:(NSString *)battletag region:(NSString *)region characterID:(NSString *)characterID {
   
    NSString *newBattleTag = [self changeBattletagFormat:battletag];
    return [NSString stringWithFormat:@"https://%@.api.battle.net/d3/profile/%@/hero/%@?locale=en_GB&apikey=%@",region,newBattleTag,characterID,CLIENT_ID];
}
- (NSString *)URIStringWithBattleTag:(NSString *)battletag region:(NSString *)region {
    return [NSString stringWithFormat:@"https://%@.api.battle.net/d3/profile/%@/?locale=en_GB&apikey=%@",region,battletag,CLIENT_ID];
}
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

#pragma mark - class methods
+ (NSString *)stringFromBattlenetRegion:(BattlenetRegion)region {
    NSString *stringRegion;
    switch (region) {
        case BattlenetRegionEU: {
            stringRegion = @"eu";
        } break;
            
        case BattlenetRegionUS: {
            stringRegion = @"us";
        } break;
            
        case BattlenetRegionKR: {
            stringRegion = @"kr";
        } break;
            
        case BattlenetRegionTW: {
            stringRegion = @"tw";
        } break;
            
        case BattlenetRegionCN: {
            stringRegion = @"cn";
        }break;
            
        default:{
            return nil;
        } break;
    }
    return stringRegion;
}

@end
