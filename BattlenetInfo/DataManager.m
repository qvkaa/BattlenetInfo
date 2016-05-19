//
//  DataManager.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/11/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "DataManager.h"
#import "CoreDataBridge.h"
@interface DataManager ()

@property (strong,nonatomic) CoreDataManager* manager;

@end

@implementation DataManager

#pragma mark - lifecycle

+ (instancetype)sharedDataManager {
    static dispatch_once_t once;
    static id sharedDataManager;
    dispatch_once(&once, ^{
        sharedDataManager = [[self alloc] init];
    });
    return sharedDataManager;
}

#pragma mark - accessors

-(CoreDataManager *)manager {
    return [CoreDataManager sharedCoreDataManager];
}

#pragma mark - fetch

- (void)fetchProfileWithBattletag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(void))completionBlock {
    [[WebServiceManager manager] fetchProfileWithBattleTag:battletag region:region withCompletionBlock:^(NSDictionary *dictonary) {
        
    }];
}

- (void)fetchCharacterInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock {
    [[WebServiceManager manager] fetchCharacterInfoWithBattleTag:battletag region:region heroID:heroID withCompletionBlock:^(NSDictionary *dictonary) {
        if (dictonary) {
            [self insertItemsWithDictionary:dictonary forHero:hero];
            
            completionBlock(YES);
        } else {
            
        }
    }];
}
- (void)fetchItemsInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock {
    [[WebServiceManager manager] fetchCharacterInfoWithBattleTag:battletag region:region heroID:heroID withCompletionBlock:^(NSDictionary *dictonary) {
        if (dictonary) {
            [self insertItemsWithDictionary:dictonary forHero:hero];
            
            completionBlock(YES);
        } else {
            
        }
    }];
}

- (void)fetchSkillsInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock {
    [[WebServiceManager manager] fetchCharacterInfoWithBattleTag:battletag region:region heroID:heroID withCompletionBlock:^(NSDictionary *dictonary) {
        if (dictonary) {
            [self insertSkillsWithDictionary:dictonary forHero:hero];
            completionBlock(YES);
        } else {
            
        }
    }];
}

- (void)fetchStatsInfoWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID forHero:(Hero *)hero withCompletionBlock:(void (^)(BOOL))completionBlock {
    [[WebServiceManager manager] fetchCharacterInfoWithBattleTag:battletag region:region heroID:heroID withCompletionBlock:^(NSDictionary *dictonary) {
        if (dictonary) {
            [self insertItemsWithDictionary:dictonary forHero:hero];
            completionBlock(YES);
        } else {
            
        }
    }];
}

#pragma mark - insert core data

- (void)insertHeroesForBattletag:(BattleTag *)battletag withDictionary:(NSDictionary *)dictionary {
    NSString *accountTag = [battletag valueForKey:@"accountTag"];
    NSString *region = [battletag valueForKey:@"region"];
    [[WebServiceManager manager] fetchProfileWithBattleTag:accountTag region:region withCompletionBlock:^(NSDictionary *dictonary) {
        
    }];
}

- (void)addProfileWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(BOOL success,BOOL isExisting))completionBlock {
    
    [[WebServiceManager manager] fetchProfileWithBattleTag:battletag region:region withCompletionBlock:^(NSDictionary *dictionary) {
        BOOL isExisting;
        if (dictionary) {
            NSMutableDictionary *mutableDictionary = [dictionary mutableCopy];
            [mutableDictionary setValue:region forKey:@"region"];
            NSDictionary *newDictionary = [[NSDictionary alloc] initWithDictionary:mutableDictionary];
            NSString *accountTag = [dictionary valueForKey:@"battleTag"];
            
            BattleTag *newBattleTag =
            [BattleTag findOrCreateObjectWithPredicate:[BattleTag predicateForAccountTag:accountTag region:region]
                                            entityName:@"BattleTag"
                                               context:self.manager.managedObjectContext
                                            isExisting:&isExisting
                                      andCreationBlock:^id(void) {
                                          return [BattleTag insertBattleTagWithDictionary:newDictionary
                                                                     managedObjectContext:self.manager.managedObjectContext
                                                                          coreDataManager:self.manager];
                                      }];
            if (newBattleTag) {
                if (isExisting) {
                    completionBlock(NO,YES); //already exists
                } else {
                    completionBlock(YES,NO); //newly added
                }
            } else {
                completionBlock(NO,NO);  //no valid battle tag
            }
            
        } else {
            completionBlock(NO,NO);
        }
        
    }];
}
- (void)updateBattleTag:(BattleTag *)battleTag WithAccountTag:(NSString *)accountTag region:(NSString *)region {
    [[WebServiceManager manager] fetchProfileWithBattleTag:accountTag region:region withCompletionBlock:^(NSDictionary *dictonary) {
        [BattleTag updateBattleTag:battleTag
                    WithDictionary:dictonary
              managedObjectContext:self.manager.managedObjectContext
                   coreDataManager:self.manager];
    }];
}

///
- (void)insertItemsWithDictionary:(NSDictionary *)dictionary forHero:(Hero *)hero {
    NSDictionary *items = [dictionary valueForKey:@"items"];
    for (NSString *type in items) {
        NSDictionary *itemDictionary = [items valueForKey:type];
        [[CoreDataBridge sharedCoreDataBridge] insertEquipmentWithDictionary:itemDictionary type:type forHero:hero];
    }
}
- (void)insertSkillsWithDictionary:(NSDictionary *)dictionary forHero:(Hero *)hero {
    NSArray *activeSkills = [[dictionary valueForKey:@"skills"] valueForKey:@"active"];
    for (NSDictionary *skillDictionary in activeSkills) {
        [[CoreDataBridge sharedCoreDataBridge] insertSkillWithDictionary:skillDictionary forHero:hero];
    }
    
    NSArray *passiveSkills = [[dictionary valueForKey:@"skills"] valueForKey:@"passive"];
    for (NSDictionary *skillDictionary in passiveSkills) {
        [[CoreDataBridge sharedCoreDataBridge] insertPassiveSkillWithDictionary:skillDictionary forHero:hero];
    }
}

-(void)updateObject:(NSManagedObject *)object withDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context {
//    [[WebServiceManager manager] fetchObjectOfKind:(NSManagedObject *)object
}

#pragma mark - sync 

- (void)syncManagedObjectIfNeeded:(NSManagedObject<SynchronizableManagedObject> *)object
                   withDictionary:(NSDictionary *)dictionary
           inManagedObjectContext:(NSManagedObjectContext *)context {
    
    if ([NSManagedObject shouldSynchronizeObject:object]) {
        if ([object isKindOfClass:[BattleTag class]]) {
            [self updateObject:object withDictionary:dictionary managedObjectContext:context];
        }
    }
    
}

@end
