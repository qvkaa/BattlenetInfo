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
+ (NSString *)imageURLWithType:(NSString *)type icon:(NSString *)icon {
   // "http://media.blizzard.com/d3/icons/<type>/<size>/<icon>.png"
    NSString *size;
    if ([type isEqualToString:@"items"]) {
        size = @"large";
    } else {
        size = @"64";
    }
    return [NSString stringWithFormat:@"http://media.blizzard.com/d3/icons/%@/%@/%@.png",
                           type,
                           size,
                           icon];
    
}

+ (void)fetchObjectWithDictionary:(NSDictionary *)fetchDictionary withCompletionBlock:(void (^)(NSDictionary *))completionBlock {
    
    NSString *urlString =[WebServiceManager URIStringWithDictionary:fetchDictionary];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    
    [[WebServiceManager manager] GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* code = [responseObject objectForKey:@"code"];
            if ([code isEqualToString:@"NOTFOUND"]) {
                NSLog(@"%@",[responseObject objectForKey:@"reason"]);
                completionBlock(nil);
            } else {
                NSMutableDictionary *newResponseObject = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
                [newResponseObject setObject:[fetchDictionary valueForKey:@"type"] forKey:@"type"];
                completionBlock(newResponseObject);
            }
        } else {
            completionBlock(nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completionBlock(nil);
    }];

//    NSUInteger type = [[dictionary valueForKey:@"type"] integerValue];
//    NSString *region = [dictionary valueForKey:@"region"];
//    NSString *accountTag = [dictionary valueForKey:@"accountTag"];
////    NSMutableDictionary *fetchDictionary = [self dictionaryForFetchRequestWithAccountTag:accountTag region:region type:type];
//    switch (type) {
//        case ManagedObjectSubclassBattleTag: {
//            
////            [self fetch
////            [self fetchProfileWithBattleTag:accountTag region:region withCompletionBlock:^(NSDictionary *responseObject) {
////                completionBlock(responseObject);
////            }];
//        } break;
//        case ManagedObjectSubclassHero: {
////            [self fetchCharacterInfoWithBattleTag:accountTag region:region heroID:heroID withCompletionBlock:^(NSDictionary *responseObject) {
////                completionBlock(responseObject);
////            }];
//        }
//        default:
//            break;
//    }
////    if ([type isEqualToString:@"BattleTag"]) {
////        [self fetchProfileWithBattleTag:accountTag region:region withCompletionBlock:^(NSDictionary *responseObject) {
////            completionBlock(responseObject);
////        }];
////    } else if ([type isEqualToString:@"Hero"] || [type isEqualToString:@"Skill"] || [type isEqualToString:@"Item"]) {
////        NSString *heroID = [dictionary valueForKey:@"heroID"];
////        [self fetchCharacterInfoWithBattleTag:accountTag region:region heroID:heroID withCompletionBlock:^(NSDictionary *responseObject) {
////            completionBlock(responseObject);
////        }];
////    }
}

//- (void)fetchProfileWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(NSDictionary *dictonary))completionBlock {
//    
//    NSString *newBattleTag = [self changeBattletagFormat:battletag];
//    
//    NSString *urlString =[self URIStringWithBattleTag:newBattleTag region:region];
//    
//    NSURL *URL = [NSURL URLWithString:urlString];
//    
//    [[AFHTTPSessionManager manager] GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSString* code = [responseObject objectForKey:@"code"];
//            if ([code isEqualToString:@"NOTFOUND"]) {
//                NSLog(@"%@",[responseObject objectForKey:@"reason"]);
//                completionBlock(nil);
//            } else {
//                completionBlock(responseObject);
//            }
//        } else {
//            completionBlock(nil);
//        }
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        completionBlock(nil);
//    }];
//}

#pragma mark - private helper methods


//+ (NSMutableDictionary *)dictionaryForFetchRequestWithAccountTag:(NSString *)accountTag region:(NSString *)region type:(ManagedObjectSubclass)type {
//    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
//    [dictionary setObject:accountTag forKey:@"accountTag"];
//    [dictionary setObject:region forKey:@"region"];
//    [dictionary setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
//    return dictionary;
//}
//
//
//+ (NSMutableDictionary *)dictionaryForHeroProfileFetchRequestWithAccountTag:(NSString *)accountTag region:(NSString *)region type:(ManagedObjectSubclass)type heroID:(NSString *)heroID {
//    NSMutableDictionary *fetchDictionary = [WebServiceManager dictionaryForFetchRequestWithAccountTag:accountTag region:region type:type];
//    [fetchDictionary setObject:heroID forKey:@"heroID"];
//    return fetchDictionary;
//}

- (NSString *)changeBattletagFormat:(NSString *)battleTag {
    if ([battleTag length] < 6) {
        return nil;
    }
    NSMutableString *newBattleTag = [[battleTag lowercaseString] mutableCopy];
    NSUInteger index = [newBattleTag length] - 5;
    NSRange range = NSMakeRange(index, 1);
    [newBattleTag replaceCharactersInRange:range withString:@"-"];
    
    return newBattleTag;
}

+ (NSString *)URIStringWithDictionary:(NSDictionary *)dictionary {
    NSMutableString *URIString = [[NSMutableString alloc] initWithString:@"https://"];
    
    NSUInteger type = [[dictionary valueForKey:@"type"] integerValue];
    
    [URIString appendString:[dictionary valueForKey:@"region"]];
    [URIString appendString:@".api.battle.net/d3/profile/"];
    [URIString appendString:[dictionary valueForKey:@"accountTag"]];
    [URIString appendString:@"/"];
    
  
    switch (type) {
        case ManagedObjectSubclassHero:{
            [URIString appendString:@"hero/"];
            [URIString appendString:[dictionary valueForKey:@"heroID"]];
        } break;
    //TODO: add more cases
        default:
            break;
    }

    [URIString appendString:@"?locale=en_GB&apikey="];
    [URIString appendString:CLIENT_ID];
    
    return URIString;
}

//- (NSString *)URIcharacterStringWithBattleTag:(NSString *)battletag region:(NSString *)region characterID:(NSString *)characterID {
//   
//    NSString *newBattleTag = [self changeBattletagFormat:battletag];
//    return [NSString stringWithFormat:@"https://%@.api.battle.net/d3/profile/%@/hero/%@?locale=en_GB&apikey=%@",region,newBattleTag,characterID,CLIENT_ID];
//}
//
//- (NSString *)URIStringWithBattleTag:(NSString *)battletag region:(NSString *)region {
//    return [NSString stringWithFormat:@"https://%@.api.battle.net/d3/profile/%@/?locale=en_GB&apikey=%@",region,battletag,CLIENT_ID];
//}

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

+ (NSString *)stringFromManagedObjectSubclass:(ManagedObjectSubclass)managedObject {
    NSString *stringFromObject;
    switch (managedObject) {
        case ManagedObjectSubclassBattleTag: {
            stringFromObject = @"BattleTag";
        } break;
            
        case ManagedObjectSubclassHero: {
            stringFromObject = @"Hero";
        } break;
            
        case ManagedObjectSubclassItem: {
            stringFromObject = @"Item";
        } break;
            
        case ManagedObjectSubclassSkill: {
            stringFromObject = @"Skill";
        }break;
            
        default:{
            return nil;
        } break;
    }
    return stringFromObject;
}

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
