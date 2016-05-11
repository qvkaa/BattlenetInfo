//
//  DataManager.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/11/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceManager.h"
#import "CoreDataBridge.h"

@interface DataManager : NSObject

+ (instancetype)sharedDataManager;

- (void)fetchProfileWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(BOOL success))completionBlock;
- (void)fetchCharacterInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL success))completionBlock;

@end
