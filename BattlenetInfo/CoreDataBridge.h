//
//  CoreDataBridge.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/15/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"
#import "BattleTag+CoreDataProperties.h"
#import "Hero+CoreDataProperties.h"
#import "Skill+CoreDataProperties.h"
#import "Passive+CoreDataProperties.h"
@interface CoreDataBridge : NSObject

+ (instancetype)sharedCoreDataBridge;
- (BattleTag *)insertBattleTagWithDictionary:(NSDictionary *)dictionary;
- (Hero *)insertHeroWithDictionary:(NSDictionary *)dictionary;
- (Skill *)insertSkillWithDictionary:(NSDictionary *)dictionary;
- (Passive *)insertPassiveSkillWithDictionary:(NSDictionary *)dictionary
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
                                      region:(NSString *)region;
- (NSArray *)fetchAllBattleTags;
@end
