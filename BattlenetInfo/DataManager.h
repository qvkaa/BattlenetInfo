//
//  DataManager.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/11/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceManager.h"
#import "BattleTag+CoreDataProperties.h"
#import "BattleTag+HelperMethods.h"
#import "Hero+CoreDataProperties.h"
#import "Skill+CoreDataProperties.h"
#import "Passive+CoreDataProperties.h"
#import "NSManagedObject+HelperMethods.h"
#import "Item+CoreDataProperties.h"
#import "CoreDataManager.h"
#import "SynchronizableManagedObjectProtocol.h"

@interface DataManager : NSObject

+ (instancetype)sharedDataManager;
- (void)updateObject:(NSManagedObject *)object withDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context;

- (void)addObjectWithDictionary:(NSDictionary *)dictionary
           managedObjectContext:(NSManagedObjectContext *)context
            withCompletionBlock:(void (^)(BOOL success, BOOL isExisting))completionBlock;
- (void)addProfileWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(BOOL success, BOOL isExisting))completionBlock;
//- (void)addOrUpdateHeroWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(BOOL success,BOOL isExisting))completionBlock;


- (void)fetchItemsInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock;
- (void)fetchSkillsInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock;
- (void)fetchStatsInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock;
- (void)fetchCharacterInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock;


- (BOOL)souldSyncManagedObject:(NSManagedObject *)object
                withDictionary:(NSDictionary *)dictionary
        inManagedObjectContext:(NSManagedObjectContext *)context;
//- (BOOL)updateManagedObject:(NSManagedObject *)object managedObjectContext:(NSManagedObjectContext *)context;

@end
