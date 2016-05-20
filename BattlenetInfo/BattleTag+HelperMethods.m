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

- (BattleTag *)updateObjectWithDictionary:(NSDictionary *)dictionary
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
    
    self.accountTag = accountTag;
    self.guildName = guildName;
    self.paragonLevel = paragonLevel;
    self.paragonLevelSeason = paragonLevelSeason;
    self.paragonLevelHardcore = paragonLevelHardcore;
    self.paragonLevelSeasonHardcore = paragonLevelSeasonHardcore;
    self.elites = elites;
    self.monsters = monsters;
    self.hardcoreMonsters = hardcoreMonsters;
    self.region = region;
    self.lastSynched = [NSDate date];
    
    
    [manager saveContext];
    
    return self;
    
}

+ (instancetype)insertObjectWithDictionary:(NSDictionary *)dictionary
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
//+ (BattleTag *)insertBattleTagWithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context coreDataManager:(CoreDataManager *)manager {
//    NSString *accountTag = [dictionary valueForKey:@"battleTag"];
//    NSNumber *paragonLevel = [dictionary valueForKey:@"paragonLevel"];
//    NSNumber *paragonLevelHardcore = [dictionary valueForKey:@"paragonLevelHardcore"];
//    NSNumber *paragonLevelSeason = [dictionary valueForKey:@"paragonLevelSeason"];
//    NSNumber *paragonLevelSeasonHardcore = [dictionary valueForKey:@"paragonLevelSeasonHardcore"];
//    NSString *guildName = [dictionary valueForKey:@"guildName"];
//    
//    
//    NSDictionary *kills = [dictionary valueForKey:@"kills"];
//    NSNumber *hardcoreMonsters = [kills valueForKey:@"hardcoreMonsters"];
//    NSNumber *elites = [kills valueForKey:@"elites"];
//    NSNumber *monsters = [kills valueForKey:@"monsters"];
//    NSString *region = [dictionary valueForKey:@"region"];
//    BattleTag* newBattleTag = [NSEntityDescription insertNewObjectForEntityForName:@"BattleTag" inManagedObjectContext:context];
//    
//    newBattleTag.accountTag = accountTag;
//    newBattleTag.guildName = guildName;
//    newBattleTag.paragonLevel = paragonLevel;
//    newBattleTag.paragonLevelSeason = paragonLevelSeason;
//    newBattleTag.paragonLevelHardcore = paragonLevelHardcore;
//    newBattleTag.paragonLevelSeasonHardcore = paragonLevelSeasonHardcore;
//    newBattleTag.elites = elites;
//    newBattleTag.monsters = monsters;
//    newBattleTag.hardcoreMonsters = hardcoreMonsters;
//    newBattleTag.region = region;
//    newBattleTag.lastSynched = [NSDate date];
//    
//    [manager saveContext];
//
//
//    return newBattleTag;
//}




//+ (BattleTag *)updateObject:(NSManagedObject *)newBattleTag
//                   WithDictionary:(NSDictionary *)dictionary
//             managedObjectContext:(NSManagedObjectContext *)context
//                  coreDataManager:(CoreDataManager *)manager {
//    
//    NSString *accountTag = [dictionary valueForKey:@"battleTag"];
//    NSNumber *paragonLevel = [dictionary valueForKey:@"paragonLevel"];
//    NSNumber *paragonLevelHardcore = [dictionary valueForKey:@"paragonLevelHardcore"];
//    NSNumber *paragonLevelSeason = [dictionary valueForKey:@"paragonLevelSeason"];
//    NSNumber *paragonLevelSeasonHardcore = [dictionary valueForKey:@"paragonLevelSeasonHardcore"];
//    NSString *guildName = [dictionary valueForKey:@"guildName"];
//    
//    
//    NSDictionary *kills = [dictionary valueForKey:@"kills"];
//    NSNumber *hardcoreMonsters = [kills valueForKey:@"hardcoreMonsters"];
//    NSNumber *elites = [kills valueForKey:@"elites"];
//    NSNumber *monsters = [kills valueForKey:@"monsters"];
//    NSString *region = [dictionary valueForKey:@"region"];
//    
//    newBattleTag.accountTag = accountTag;
//    newBattleTag.guildName = guildName;
//    newBattleTag.paragonLevel = paragonLevel;
//    newBattleTag.paragonLevelSeason = paragonLevelSeason;
//    newBattleTag.paragonLevelHardcore = paragonLevelHardcore;
//    newBattleTag.paragonLevelSeasonHardcore = paragonLevelSeasonHardcore;
//    newBattleTag.elites = elites;
//    newBattleTag.monsters = monsters;
//    newBattleTag.hardcoreMonsters = hardcoreMonsters;
//    newBattleTag.region = region;
//    newBattleTag.lastSynched = [NSDate date];
//    
//    
//    [manager saveContext];
//    
//    return newBattleTag;
//
//}
//+ (BattleTag *)updateBattleTag:(BattleTag *)newBattleTag
//                WithDictionary:(NSDictionary *)dictionary
//          managedObjectContext:(NSManagedObjectContext *)context
//               coreDataManager:(CoreDataManager *)manager {
//    
//    NSString *accountTag = [dictionary valueForKey:@"battleTag"];
//    NSNumber *paragonLevel = [dictionary valueForKey:@"paragonLevel"];
//    NSNumber *paragonLevelHardcore = [dictionary valueForKey:@"paragonLevelHardcore"];
//    NSNumber *paragonLevelSeason = [dictionary valueForKey:@"paragonLevelSeason"];
//    NSNumber *paragonLevelSeasonHardcore = [dictionary valueForKey:@"paragonLevelSeasonHardcore"];
//    NSString *guildName = [dictionary valueForKey:@"guildName"];
//    
//    
//    NSDictionary *kills = [dictionary valueForKey:@"kills"];
//    NSNumber *hardcoreMonsters = [kills valueForKey:@"hardcoreMonsters"];
//    NSNumber *elites = [kills valueForKey:@"elites"];
//    NSNumber *monsters = [kills valueForKey:@"monsters"];
//    NSString *region = [dictionary valueForKey:@"region"];
//    
//    newBattleTag.accountTag = accountTag;
//    newBattleTag.guildName = guildName;
//    newBattleTag.paragonLevel = paragonLevel;
//    newBattleTag.paragonLevelSeason = paragonLevelSeason;
//    newBattleTag.paragonLevelHardcore = paragonLevelHardcore;
//    newBattleTag.paragonLevelSeasonHardcore = paragonLevelSeasonHardcore;
//    newBattleTag.elites = elites;
//    newBattleTag.monsters = monsters;
//    newBattleTag.hardcoreMonsters = hardcoreMonsters;
//    newBattleTag.region = region;
//    newBattleTag.lastSynched = [NSDate date];
//    
//    
//    [manager saveContext];
//    return newBattleTag;
//}

#pragma mark - helper methods
+ (NSDictionary *)dictionaryForFetchRequestWithDictionary:(NSDictionary *)dictionary {
    NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
    [newDictionary setObject:@"BattleTag" forKey:@"type"];
    [newDictionary setObject:[BattleTag class] forKey:@"objectClass"];
    return newDictionary;
}

+ (NSDictionary *)dictionaryForFetchRequestWithAccountTag:(NSString *)accountTag region:(NSString *)region {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dictionary setObject:accountTag forKey:@"accountTag"];
    [dictionary setObject:region forKey:@"region"];
    [dictionary setObject:@"BattleTag" forKey:@"type"];
    //[dictionary setObject:[BattleTag class] forKey:@"objectClass"];
    return dictionary;
}

@end
