//
//  WebServiceManager.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/2/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

typedef NS_ENUM(NSUInteger, BattlenetRegion) {
    BattlenetRegionEU       = 0 ,
    BattlenetRegionUS    = 1 ,
    BattlenetRegionKR   = 2 ,
    BattlenetRegionTW = 3 ,
    BattlenetRegionCN = 4
};

@interface WebServiceManager : AFHTTPSessionManager

+ (NSString *)stringFromBattlenetRegion:(BattlenetRegion)region;

- (void)fetchProfileWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(NSDictionary *dictonary))completionBlock;
- (void)fetchObjectWithDictionary:(NSString *)dictionary withCompletionBlock:(void (^)(NSDictionary *dictonary))completionBlock;
- (void)fetchCharacterInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID withCompletionBlock:(void (^)(NSDictionary *dictonary))completionBlock;
+ (NSString *)imageURLWithType:(NSString *)type icon:(NSString *)icon;
@end
