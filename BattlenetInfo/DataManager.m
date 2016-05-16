//
//  DataManager.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/11/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "DataManager.h"

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

#pragma mark - fetch
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
                                               context:[CoreDataBridge sharedCoreDataBridge].manager.managedObjectContext
                                            isExisting:&isExisting
                                      andCreationBlock:^id(void) {
                 return [BattleTag insertBattleTagWithDictionary:newDictionary
                                            managedObjectContext:[CoreDataBridge sharedCoreDataBridge].manager.managedObjectContext];
             }];
            
            if (newBattleTag) {
                if (isExisting) {
                    completionBlock(NO,YES); //already exists
                } else {
                    completionBlock(YES,NO); //newly added
                }
                //[BattleTag updateBattleTag:newBattleTag WithDictionary:newDictionary managedObjectContext:[CoreDataBridge sharedCoreDataBridge].manager.managedObjectContext];
              
            } else {
                completionBlock(NO,NO);  //no valid battle tag
            }
            
        } else {
            completionBlock(NO,NO);
        }
        
    }];
}
- (void)addOrUpdateHeroWithBattleTag:(NSString *)battletag region:(NSString *)region heroID:(NSString *)heroID withCompletionBlock:(void (^)(BOOL success,BOOL isExisting))completionBlock {
    // fetch snippet
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"<#Entity name#>" inManagedObjectContext:<#context#>];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [<#context#> executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        <#Error handling code#>
    }
//    [[WebServiceManager manager] fet:battletag region:region withCompletionBlock:^(NSDictionary *dictonary) {
//        
//    }];
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
@end
