//
//  WebServiceManager.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/2/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFOAuth2Manager.h>

typedef NS_ENUM(NSUInteger, BattlenetRegion) {
    BattlenetRegionEU       = 0 ,
    BattlenetRegionUS    = 1 ,
    BattlenetRegionKR   = 2 ,
    BattlenetRegionTW = 3 ,
    BattlenetRegionCN = 4
};

@interface WebServiceManager : NSObject

+ (id)sharedWebServiceManager;
- (NSURLRequest *)urlRequestForLoginForRegion:(BattlenetRegion)region;
- (void)fetchImageInfoForManufacturer:(NSString *)manufacturer model:(NSString *)model color:(NSString *)color withCompletionBlock:(void (^)(NSArray *array))completionBlock;
@end
