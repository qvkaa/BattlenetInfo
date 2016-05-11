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

- (void)fetchProfileWithBattleTag:(NSString *)battletag region:(NSString *)region withCompletionBlock:(void (^)(BOOL))completionBlock {
    [[WebServiceManager manager] fetchProfileWithBattleTag:battletag region:region withCompletionBlock:^(NSDictionary *dictionary) {
        if (dictionary) {
            NSMutableDictionary *mutableDictionary = [dictionary mutableCopy];
            [mutableDictionary setValue:region forKey:@"region"];
            NSDictionary *newDictionary = [[NSDictionary alloc] initWithDictionary:mutableDictionary];
            CoreDataBridge *sharedCoreDataBridge = [CoreDataBridge sharedCoreDataBridge];
            [sharedCoreDataBridge insertBattleTagWithDictionary:newDictionary];
            completionBlock(YES);
            //[self.navigationController popViewControllerAnimated:YES];
            //[sharedCoreDataBridge fetchAllBattleTags];
        }else {
            completionBlock(NO);
            //[self alertWithTitle:@"Invalid Battle Tag" message:@"Please insert a valid tag e.g. noob-1234."];
        }
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

- (void)insertItemsWithDictionary:(NSDictionary *)dictionary forHero:(Hero *)hero {
    NSDictionary *items = [dictionary valueForKey:@"items"];
    //NSArray *items = [dictionary valueForKey:@"items"];
    for (NSString *type in items) {
        NSDictionary *itemDictionary = [items valueForKey:type];
        [[CoreDataBridge sharedCoreDataBridge] insertEquipmentWithDictionary:itemDictionary type:type forHero:hero];
    }
}
@end
