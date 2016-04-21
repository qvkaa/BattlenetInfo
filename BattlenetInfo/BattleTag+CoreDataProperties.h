//
//  BattleTag+CoreDataProperties.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/21/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BattleTag.h"

NS_ASSUME_NONNULL_BEGIN

@interface BattleTag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *accountTag;
@property (nullable, nonatomic, retain) NSNumber *elites;
@property (nullable, nonatomic, retain) NSString *guildName;
@property (nullable, nonatomic, retain) NSNumber *hardcoreMonsters;
@property (nullable, nonatomic, retain) NSNumber *monsters;
@property (nullable, nonatomic, retain) NSNumber *paragonLevel;
@property (nullable, nonatomic, retain) NSNumber *paragonLevelHardcore;
@property (nullable, nonatomic, retain) NSNumber *paragonLevelSeason;
@property (nullable, nonatomic, retain) NSNumber *paragonLevelSeasonHardcore;
@property (nullable, nonatomic, retain) NSString *region;
@property (nullable, nonatomic, retain) NSSet<Hero *> *characters;

@end

@interface BattleTag (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(Hero *)value;
- (void)removeCharactersObject:(Hero *)value;
- (void)addCharacters:(NSSet<Hero *> *)values;
- (void)removeCharacters:(NSSet<Hero *> *)values;

@end

NS_ASSUME_NONNULL_END
