//
//  BattleTag+HelperMethods.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "BattleTag+HelperMethods.h"

@implementation BattleTag (HelperMethods)

#pragma mark - helper methods

+ (NSPredicate *)predicateForAccountTag:(NSString *)accountTag region:(NSString *)region {
    NSPredicate *predicateAccountTag = [NSPredicate predicateWithFormat:@"accountTag == %@", accountTag];
    NSPredicate *predicateRegion = [NSPredicate predicateWithFormat:@"region == %@", region];
    return [NSCompoundPredicate andPredicateWithSubpredicates:@[predicateAccountTag,predicateRegion]];
}

#pragma mark - insert update methods

- (NSDate *)lastSynchronizedDate {
    return [self valueForKey:@"lastSynched"];
}
+ (BattleTag *)insertBattleTagWithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context coreDataManager:(CoreDataManager *)manager {
    NSString *accountTag = [dictionary valueForKey:@"battleTag"];
    NSNumber *paragonLevel = [dictionary valueForKey:@"paragonLevel"];
    NSNumber *paragonLevelHardcore = [dictionary valueForKey:@"paragonLevelHardcore"];
    NSNumber *paragonLevelSeason = [dictionary valueForKey:@"paragonLevelSeason"];
    NSNumber *paragonLevelSeasonHardcore = [dictionary valueForKey:@"paragonLevelSeasonHardcore"];
    NSString *guildName = [dictionary valueForKey:@"guildName"];
    
    
    NSDictionary *kills = [dictionary valueForKey:@"kills"];
    NSNumber *hardcoreMonsters = [kills valueForKey:@"hardcoreMonsters"];
    NSNumber *elites = [kills valueForKey:@"elites"];
    NSNumber *monsters = [kills valueForKey:@"monsters"];
    NSString *region = [dictionary valueForKey:@"region"];
    BattleTag* newBattleTag = [NSEntityDescription insertNewObjectForEntityForName:@"BattleTag" inManagedObjectContext:context];
    
    newBattleTag.accountTag = accountTag;
    newBattleTag.guildName = guildName;
    newBattleTag.paragonLevel = paragonLevel;
    newBattleTag.paragonLevelSeason = paragonLevelSeason;
    newBattleTag.paragonLevelHardcore = paragonLevelHardcore;
    newBattleTag.paragonLevelSeasonHardcore = paragonLevelSeasonHardcore;
    newBattleTag.elites = elites;
    newBattleTag.monsters = monsters;
    newBattleTag.hardcoreMonsters = hardcoreMonsters;
    newBattleTag.region = region;
    newBattleTag.lastSynched = [NSDate date];
    
    [manager saveContext];


    return newBattleTag;
}

+ (BattleTag *)updateBattleTag:(BattleTag *)newBattleTag
                WithDictionary:(NSDictionary *)dictionary
          managedObjectContext:(NSManagedObjectContext *)context
               coreDataManager:(CoreDataManager *)manager {
    
    NSString *accountTag = [dictionary valueForKey:@"battleTag"];
    NSNumber *paragonLevel = [dictionary valueForKey:@"paragonLevel"];
    NSNumber *paragonLevelHardcore = [dictionary valueForKey:@"paragonLevelHardcore"];
    NSNumber *paragonLevelSeason = [dictionary valueForKey:@"paragonLevelSeason"];
    NSNumber *paragonLevelSeasonHardcore = [dictionary valueForKey:@"paragonLevelSeasonHardcore"];
    NSString *guildName = [dictionary valueForKey:@"guildName"];
    
    
    NSDictionary *kills = [dictionary valueForKey:@"kills"];
    NSNumber *hardcoreMonsters = [kills valueForKey:@"hardcoreMonsters"];
    NSNumber *elites = [kills valueForKey:@"elites"];
    NSNumber *monsters = [kills valueForKey:@"monsters"];
    NSString *region = [dictionary valueForKey:@"region"];
    
    newBattleTag.accountTag = accountTag;
    newBattleTag.guildName = guildName;
    newBattleTag.paragonLevel = paragonLevel;
    newBattleTag.paragonLevelSeason = paragonLevelSeason;
    newBattleTag.paragonLevelHardcore = paragonLevelHardcore;
    newBattleTag.paragonLevelSeasonHardcore = paragonLevelSeasonHardcore;
    newBattleTag.elites = elites;
    newBattleTag.monsters = monsters;
    newBattleTag.hardcoreMonsters = hardcoreMonsters;
    newBattleTag.region = region;
    newBattleTag.lastSynched = [NSDate date];
    
    
    [manager saveContext];
    return newBattleTag;
}


@end
