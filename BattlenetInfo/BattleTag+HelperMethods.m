//
//  BattleTag+HelperMethods.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "BattleTag+HelperMethods.h"

@implementation BattleTag (HelperMethods)

+(NSPredicate *)predicateForAccountTag:(NSString *)accountTag region:(NSString *)region {
    NSPredicate *predicateAccountTag = [NSPredicate predicateWithFormat:@"accountTag == %@", accountTag];
    NSPredicate *predicateRegion = [NSPredicate predicateWithFormat:@"region == %@", region];
    return [NSCompoundPredicate andPredicateWithSubpredicates:@[predicateAccountTag,predicateRegion]];
}

+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BattleTag"];
    [request setReturnsObjectsAsFaults:NO];
    [request setPredicate:predicate];
    NSError *error = nil;
    return [context executeFetchRequest:request error:&error];
}

+ (BattleTag *)insertBattleTagWithDictionary:(NSDictionary *)dictionary {
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
    BattleTag *newBattleTag = [self fetchBattletagWithAccountTag:accountTag region:region];
    
    if (!newBattleTag) {
        newBattleTag =[self insertBattleTagWithAccountTag:accountTag
                                                guildName:guildName
                                             paragonLevel:paragonLevel
                                       paragonLevelSeason:paragonLevelSeason
                                     paragonLevelHardcore:paragonLevelHardcore
                               paragonLevelSeasonHardcore:paragonLevelSeasonHardcore
                                         hardcoreMonsters:hardcoreMonsters
                                                   elites:elites
                                                 monsters:monsters
                                                   region:region];
    } else {
        [self updateBattleTag:newBattleTag WithAccountTag:accountTag guildName:guildName paragonLevel:paragonLevel paragonLevelSeason:paragonLevelSeason paragonLevelHardcore:paragonLevelHardcore paragonLevelSeasonHardcore:paragonLevelSeasonHardcore hardcoreMonsters:hardcoreMonsters elites:elites monsters:monsters region:region];
    }
    return newBattleTag;
}
#pragma mark - private helper methods

+ (BattleTag *)insertBattleTagWithAccountTag:(NSString *)tag
                                   guildName:(NSString *)guild
                                paragonLevel:(NSNumber *)paragonLevel
                          paragonLevelSeason:(NSNumber *)paragonLevelSeason
                        paragonLevelHardcore:(NSNumber *)paragonLevelHardcore
                  paragonLevelSeasonHardcore:(NSNumber *)paragonLevelSeasonHardcore
                            hardcoreMonsters:(NSNumber *)hardcoreMonsters
                                      elites:(NSNumber *)elites
                                    monsters:(NSNumber *)monsters
                                      region:(NSString *)region
                                     context:(NSManagedObjectContext *)context
{
    BattleTag* newBattleTag = [NSEntityDescription insertNewObjectForEntityForName:@"BattleTag" inManagedObjectContext:context];
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
    newBattleTag.lastSynched = [NSDate date];
    
//    [self.manager saveContext];
    
    return newBattleTag;
}

+ (BattleTag *)updateBattleTag:(BattleTag *)newBattleTag
                WithAccountTag:(NSString *)tag
                     guildName:(NSString *)guild
                  paragonLevel:(NSNumber *)paragonLevel
            paragonLevelSeason:(NSNumber *)paragonLevelSeason
          paragonLevelHardcore:(NSNumber *)paragonLevelHardcore
    paragonLevelSeasonHardcore:(NSNumber *)paragonLevelSeasonHardcore
              hardcoreMonsters:(NSNumber *)hardcoreMonsters
                        elites:(NSNumber *)elites
                      monsters:(NSNumber *)monsters
                        region:(NSString *)region
{
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
    newBattleTag.lastSynched = [NSDate date];
    
//    [self.manager saveContext];
    
    return newBattleTag;
}


@end
