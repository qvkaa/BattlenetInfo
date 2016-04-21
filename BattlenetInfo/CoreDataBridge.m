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

@property (strong,nonatomic) CoreDataManager* manager;

@end

@implementation CoreDataBridge

+ (instancetype)sharedCoreDataBridge {
    static dispatch_once_t once;
    static id sharedCoreDataBridge;
    dispatch_once(&once, ^{
        sharedCoreDataBridge = [[self alloc] init];
    });
    return sharedCoreDataBridge;
}
#pragma mark - insert
-(BattleTag *)insertBattleTagWithDictionary:(NSDictionary *)dictionary {
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
    NSArray *heroes = [dictionary valueForKey:@"heroes"];
    
    BattleTag *newBattleTag =[self insertBattleTagWithAccountTag:accountTag
                                                       guildName:guildName
                                                    paragonLevel:paragonLevel
                                              paragonLevelSeason:paragonLevelSeason
                                            paragonLevelHardcore:paragonLevelHardcore
                                      paragonLevelSeasonHardcore:paragonLevelSeasonHardcore
                                                hardcoreMonsters:hardcoreMonsters
                                                          elites:elites
                                                        monsters:monsters
                                                          heroes:heroes
                                                          region:region];
   
    return newBattleTag;
}
- (BattleTag *)insertBattleTagWithAccountTag:(NSString *)tag
                                   guildName:(NSString *)guild
                                paragonLevel:(NSNumber *)paragonLevel
                          paragonLevelSeason:(NSNumber *)paragonLevelSeason
                        paragonLevelHardcore:(NSNumber *)paragonLevelHardcore
                  paragonLevelSeasonHardcore:(NSNumber *)paragonLevelSeasonHardcore
                            hardcoreMonsters:(NSNumber *)hardcoreMonsters
                                      elites:(NSNumber *)elites
                                    monsters:(NSNumber *)monsters
                                      heroes:(NSArray *)heroes
                                      region:(NSString *)region
{
   
    BattleTag* newBattleTag = [NSEntityDescription insertNewObjectForEntityForName:@"BattleTag" inManagedObjectContext:self.manager.managedObjectContext];
    newBattleTag.accountTag = tag;
    newBattleTag.guildName = guild;
    newBattleTag.paragonLevel = paragonLevel;
    newBattleTag.paragonLevelSeason = paragonLevelSeason;
    newBattleTag.paragonLevelHardcore = paragonLevelHardcore;
    newBattleTag.paragonLevelSeasonHardcore = paragonLevelSeasonHardcore;
    newBattleTag.elites = elites;
    newBattleTag.monsters = monsters;
    newBattleTag.hardcoreMonsters = hardcoreMonsters;
    newBattleTag.region = region;

    for (NSDictionary *hero in heroes) {
       
        [newBattleTag addCharactersObject:[self insertHeroWithDictionary:hero]];
        
    }
    [self.manager saveContext];
    
    NSLog(@"Saving User to Core Data completed.");
    return newBattleTag;
}

-(Hero *)insertHeroWithDictionary:(NSDictionary *)dictionary {
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
    return newHero;
}

#pragma mark - fetch

- (NSArray *)fetchAllBattleTags {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BattleTag"];
    [request setReturnsObjectsAsFaults:NO];
    NSError *error = nil;
    NSArray *battleTags = [self.manager.managedObjectContext executeFetchRequest:request error:&error];
    [self.manager  saveContext];
    NSLog(@"Fetching battleTags Completed.");
    NSLog(@"battleTags: %@", battleTags);
    NSLog(@"battleTags #: %lu", (unsigned long)[battleTags count]);
    self.manager.battleTags = [NSArray arrayWithArray:battleTags];
    return battleTags;
    
}

#pragma mark - accessor
-(CoreDataManager *)manager {
     return [CoreDataManager sharedCoreDataManager];
}
@end
