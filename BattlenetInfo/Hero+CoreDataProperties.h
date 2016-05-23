//
//  Hero+CoreDataProperties.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/23/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Hero.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hero (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *eliteKills;
@property (nullable, nonatomic, retain) NSNumber *hardcore;
@property (nullable, nonatomic, retain) NSString *heroClass;
@property (nullable, nonatomic, retain) NSNumber *heroID;
@property (nullable, nonatomic, retain) NSNumber *heroLevel;
@property (nullable, nonatomic, retain) NSString *heroName;
@property (nullable, nonatomic, retain) NSDate *lastSynced;
@property (nullable, nonatomic, retain) NSNumber *seasonal;
@property (nullable, nonatomic, retain) BattleTag *battleTag;
@property (nullable, nonatomic, retain) NSSet<Item *> *equips;
@property (nullable, nonatomic, retain) NSSet<Passive *> *passiveSkills;
@property (nullable, nonatomic, retain) NSSet<Skill *> *skills;

@end

@interface Hero (CoreDataGeneratedAccessors)

- (void)addEquipsObject:(Item *)value;
- (void)removeEquipsObject:(Item *)value;
- (void)addEquips:(NSSet<Item *> *)values;
- (void)removeEquips:(NSSet<Item *> *)values;

- (void)addPassiveSkillsObject:(Passive *)value;
- (void)removePassiveSkillsObject:(Passive *)value;
- (void)addPassiveSkills:(NSSet<Passive *> *)values;
- (void)removePassiveSkills:(NSSet<Passive *> *)values;

- (void)addSkillsObject:(Skill *)value;
- (void)removeSkillsObject:(Skill *)value;
- (void)addSkills:(NSSet<Skill *> *)values;
- (void)removeSkills:(NSSet<Skill *> *)values;

@end

NS_ASSUME_NONNULL_END
