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
- (void)updateObject:(NSManagedObject *)object;
- (void)addProfileWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(BOOL success, BOOL isExisting))completionBlock;
- (void)addOrUpdateHeroWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(BOOL success,BOOL isExisting))completionBlock;


- (void)fetchItemsInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock;
- (void)fetchSkillsInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock;
- (void)fetchStatsInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock;
- (void)fetchCharacterInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock;


- (BOOL)souldSyncManagedObject:(NSManagedObject *)object managedObjectContext:(NSManagedObjectContext *)context;
- (BOOL)updateManagedObject:(NSManagedObject *)object managedObjectContext:(NSManagedObjectContext *)context;
@end
