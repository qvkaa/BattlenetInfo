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

- (void)fetchProfileWithBattleTag:(NSString *)battletag region:(BattlenetRegion)region withCompletionBlock:(void (^)(NSDictionary *dictonary))completionBlock;
    

@end
