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
typedef NS_ENUM(NSUInteger, ManagedObjectSubclass) {
    ManagedObjectSubclassBattleTag = 0,
    ManagedObjectSubclassHero = 1,
    ManagedObjectSubclassItem = 2,
    ManagedObjectSubclassSkill = 3
};
@interface WebServiceManager : AFHTTPSessionManager

+ (NSString *)stringFromBattlenetRegion:(BattlenetRegion)region;
+ (void)fetchObjectWithDictionary:(NSDictionary *)fetechDictionary withCompletionBlock:(void (^)(NSDictionary *responseDictonary))completionBlock;
+ (NSString *)imageURLWithType:(NSString *)type icon:(NSString *)icon;

+ (NSMutableDictionary *)dictionaryForFetchRequestWithAccountTag:(NSString *)accountTag region:(NSString *)region;
+ (NSMutableDictionary *)dictionaryForBattleTagFetchRequestWithAccountTag:(NSString *)accountTag region:(NSString *)region;
+ (NSMutableDictionary *)dictionaryForHeroProfileFetchRequestWithAccountTag:(NSString *)accountTag region:(NSString *)region heroID:(NSString *)heroID;

+ (NSString *)changeBattletagFormat:(NSString *)battleTag;

@end

