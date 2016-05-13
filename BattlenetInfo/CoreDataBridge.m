//
//  CoreDataBridge.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/15/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//
/// http://media.blizzard.com/d3/icons/items/large/unique_helm_010_x1_demonhunter_male.png
/*
 Icons: When any of the d3 APIs reference an icon you can use the following url to reference it: "http://media.blizzard.com/d3/icons/<type>/<size>/<icon>.png".
 The type can be "items" or "skills" based on the type of icon. For items size can be "small" or "large" and for skills size can be 21, 42 or 64.
 */
#import "CoreDataBridge.h"
#import "CoreDataManager.h"

@interface CoreDataBridge ()


@end

@implementation CoreDataBridge

#pragma mark - lifecycle

+ (instancetype)sharedCoreDataBridge {
    static dispatch_once_t once;
    static id sharedCoreDataBridge;
    dispatch_once(&once, ^{
        sharedCoreDataBridge = [[self alloc] init];
    });
    return sharedCoreDataBridge;
}

#pragma mark - insert or update
+ (instancetype)findOrCreateObjectWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context isExisting:(BOOL *)isExisting andCreationBlock:(id (^)(void)) creationBlock {
    NSParameterAssert(predicate);
    Class managedObjectSubclass = [self class];
    NSArray *existing = [managedObjectSubclass allInstancesWithPredicate:predicate inManagedObjectContext:context];
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hero "];
//    [request setReturnsObjectsAsFaults:NO];
//    [request setPredicate:predicate];
//    NSError *error = nil;
//    NSArray *battleTags = [self.manager.managedObjectContext executeFetchRequest:request error:&error];
//
    
    if (existing.count > 0) {
        NSAssert(existing.count == 1, @"There must be only one object with a certain ID");
        if (isExisting) {
            *isExisting = YES;
        }
        return existing.firstObject;
    } else {
        NSParameterAssert(creationBlock);
        if (isExisting) {
            *isExisting = NO;
        }
        return creationBlock();
    }
    
    return nil;
}
//
//- (BattleTag *)insertBattleTagWithDictionary:(NSDictionary *)dictionary {
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
//    BattleTag *newBattleTag = [self fetchBattletagWithAccountTag:accountTag region:region];
//    
//    if (!newBattleTag) {
//        newBattleTag =[self insertBattleTagWithAccountTag:accountTag
//                                                guildName:guildName
//                                             paragonLevel:paragonLevel
//                                       paragonLevelSeason:paragonLevelSeason
//                                     paragonLevelHardcore:paragonLevelHardcore
//                               paragonLevelSeasonHardcore:paragonLevelSeasonHardcore
//                                         hardcoreMonsters:hardcoreMonsters
//                                                   elites:elites
//                                                 monsters:monsters
//                                                   region:region];
//    } else {
//        [self updateBattleTag:newBattleTag WithAccountTag:accountTag guildName:guildName paragonLevel:paragonLevel paragonLevelSeason:paragonLevelSeason paragonLevelHardcore:paragonLevelHardcore paragonLevelSeasonHardcore:paragonLevelSeasonHardcore hardcoreMonsters:hardcoreMonsters elites:elites monsters:monsters region:region];
//    }
//    return newBattleTag;
//}



- (Hero *)insertHeroWithDictionary:(NSDictionary *)dictionary forBattleTag:(BattleTag *)battletag {
    NSNumber *eliteKills = [[dictionary valueForKey:@"kills"] valueForKey:@"elites"];
    NSNumber *hardcore = [dictionary valueForKey:@"hardcore"];
    NSString *heroClass = [dictionary valueForKey:@"class"];
    NSNumber *heroID = [dictionary valueForKey:@"id"];
    NSNumber *heroLevel = [dictionary valueForKey:@"level"];
    NSString *heroName = [dictionary valueForKey:@"name"];
    NSNumber *seasonal = [dictionary valueForKey:@"seasonal"];
    
    Hero* newHero = [NSEntityDescription insertNewObjectForEntityForName:@"Hero" inManagedObjectContext:self.manager.managedObjectContext];
    
    
    newHero.eliteKills = eliteKills;
    newHero.hardcore = hardcore;
    newHero.heroClass = heroClass;
    newHero.heroID = heroID;
    newHero.heroLevel = heroLevel;
    newHero.heroName = heroName;
    newHero.seasonal = seasonal;
    newHero.lastSynched = [NSDate date];
    
    [battletag addCharactersObject:newHero];
    [self.manager saveContext];
    return newHero;
}

- (Skill *)insertSkillWithDictionary:(NSDictionary *)dictionary forHero:(Hero *)hero {
    NSString *skillName = [[dictionary valueForKey:@"skill"] valueForKey:@"name"];
    NSString *runeName = [[dictionary valueForKey:@"rune"] valueForKey:@"name"];
    NSString *icon = [[dictionary valueForKey:@"skill"] valueForKey:@"icon"];
    
    Skill *newSkill = [NSEntityDescription insertNewObjectForEntityForName:@"Skill" inManagedObjectContext:self.manager.managedObjectContext];
    newSkill.skillName = skillName;
    newSkill.runeName = runeName;
    newSkill.icon = icon;
    newSkill.lastSynched = [NSDate date];
    [hero addSkillsObject:newSkill];
    [self.manager saveContext];
    return newSkill;
}

- (Passive *)insertPassiveSkillWithDictionary:(NSDictionary *)dictionary forHero:(Hero *)hero{
    NSString *passiveName = [[dictionary valueForKey:@"skill"] valueForKey:@"name"];
    NSString *icon = [[dictionary valueForKey:@"skill"] valueForKey:@"icon"];
    
    Passive *newPassiveSkill = [NSEntityDescription insertNewObjectForEntityForName:@"Passive" inManagedObjectContext:self.manager.managedObjectContext];
    newPassiveSkill.passiveName = passiveName;
    newPassiveSkill.icon = icon;
    newPassiveSkill.lastSynched = [NSDate date];
    [hero addPassiveSkillsObject:newPassiveSkill];
    [self.manager saveContext];
    return newPassiveSkill;
}

- (Item *)insertEquipmentWithDictionary:(NSDictionary *)dictionary type:(NSString *)type forHero:(Hero *)hero{
    NSString *icon = [dictionary valueForKey:@"icon"];
    NSString *itemID = [dictionary valueForKey:@"id"];
    NSString *itemName = [dictionary valueForKey:@"name"];
    NSString *toolTipParam = [dictionary valueForKey:@"tooltipParams"];
    NSString *displayColor = [dictionary valueForKey:@"displayColor"];
   
    Item *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.manager.managedObjectContext];
    newItem.icon = icon;
    newItem.itemID = itemID;
    newItem.itemName = itemName;
    newItem.toolTipParam = toolTipParam;
    newItem.type = type;
    newItem.displayColor = displayColor;
    
    [hero addEquipsObject:newItem];
    [self.manager saveContext];
    
    return newItem;
}
#pragma mark - fetch

- (NSArray *)fetchAllBattleTags {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BattleTag"];
    [request setReturnsObjectsAsFaults:NO];
    NSError *error = nil;
    NSArray *battleTags = [self.manager.managedObjectContext executeFetchRequest:request error:&error];
    [self.manager  saveContext];
//    NSLog(@"Fetching battleTags Completed.");
//    NSLog(@"battleTags: %@", battleTags);
//    NSLog(@"battleTags #: %lu", (unsigned long)[battleTags count]);
    self.manager.battleTags = [NSArray arrayWithArray:battleTags];
    return battleTags;
}

- (BattleTag *)fetchBattletagWithAccountTag:(NSString *)accountTag region:(NSString *)region {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BattleTag"];
    [request setReturnsObjectsAsFaults:NO];
    
    
    NSPredicate *predicateAccountTag = [NSPredicate predicateWithFormat:@"accountTag == %@", accountTag];
    NSPredicate *predicateRegion = [NSPredicate predicateWithFormat:@"region == %@", region];
    NSCompoundPredicate *finalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
                                                                                               predicateAccountTag,predicateRegion]];
    [request setPredicate:finalPredicate];
    NSError *error = nil;
    NSArray *battleTags = [self.manager.managedObjectContext executeFetchRequest:request error:&error];
    [self.manager  saveContext];
    NSLog(@"Fetching battleTags Completed.");
    NSLog(@"battleTags: %@", battleTags);
    NSLog(@"battleTags #: %lu", (unsigned long)[battleTags count]);
    self.manager.battleTags = [NSArray arrayWithArray:battleTags];
    if ([battleTags count] > 0) {
        return [battleTags firstObject];
    }
    return nil;
    
}

- (BattleTag *)fetchHeroWithID:(NSString *)heroID forBattletag:(BattleTag *)battletag {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hero "];
    [request setReturnsObjectsAsFaults:NO];
    
    
    NSPredicate *predicateAccountTag = [NSPredicate predicateWithFormat:@"accountTag == %@", [battletag valueForKey:@"accountTag"]];
    NSPredicate *predicateRegion = [NSPredicate predicateWithFormat:@"region == %@", [battletag valueForKey:@"region"]];
    NSPredicate *predicateHeroID = [NSPredicate predicateWithFormat:@"heroID == %@", heroID];
    NSCompoundPredicate *finalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
                                                                                               predicateAccountTag,predicateRegion,predicateHeroID]];
    [request setPredicate:finalPredicate];
    NSError *error = nil;
    NSArray *battleTags = [self.manager.managedObjectContext executeFetchRequest:request error:&error];
    [self.manager  saveContext];
    NSLog(@"Fetching battleTags Completed.");
    NSLog(@"battleTags: %@", battleTags);
    NSLog(@"battleTags #: %lu", (unsigned long)[battleTags count]);
    self.manager.battleTags = [NSArray arrayWithArray:battleTags];
    if ([battleTags count] > 0) {
        return [battleTags firstObject];
    }
    return nil;
    
}

#pragma mark - accessor

-(CoreDataManager *)manager {
     return [CoreDataManager sharedCoreDataManager];
}

//#pragma mark - private helper methods
//
//- (BattleTag *)insertBattleTagWithAccountTag:(NSString *)tag
//                                   guildName:(NSString *)guild
//                                paragonLevel:(NSNumber *)paragonLevel
//                          paragonLevelSeason:(NSNumber *)paragonLevelSeason
//                        paragonLevelHardcore:(NSNumber *)paragonLevelHardcore
//                  paragonLevelSeasonHardcore:(NSNumber *)paragonLevelSeasonHardcore
//                            hardcoreMonsters:(NSNumber *)hardcoreMonsters
//                                      elites:(NSNumber *)elites
//                                    monsters:(NSNumber *)monsters
//                                      region:(NSString *)region
//{
//    BattleTag* newBattleTag = [NSEntityDescription insertNewObjectForEntityForName:@"BattleTag" inManagedObjectContext:self.manager.managedObjectContext];
//    newBattleTag.accountTag = tag;
//    newBattleTag.guildName = guild;
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
//    [self.manager saveContext];
//
//    return newBattleTag;
//}
//
//- (BattleTag *)updateBattleTag:(BattleTag *)newBattleTag
//                WithAccountTag:(NSString *)tag
//                     guildName:(NSString *)guild
//                  paragonLevel:(NSNumber *)paragonLevel
//            paragonLevelSeason:(NSNumber *)paragonLevelSeason
//          paragonLevelHardcore:(NSNumber *)paragonLevelHardcore
//    paragonLevelSeasonHardcore:(NSNumber *)paragonLevelSeasonHardcore
//              hardcoreMonsters:(NSNumber *)hardcoreMonsters
//                        elites:(NSNumber *)elites
//                      monsters:(NSNumber *)monsters
//                        region:(NSString *)region
//{
//    newBattleTag.accountTag = tag;
//    newBattleTag.guildName = guild;
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
//    [self.manager saveContext];
//
//    return newBattleTag;
//}

@end
