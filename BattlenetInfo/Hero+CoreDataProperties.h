//
//  Hero+CoreDataProperties.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/26/16.
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
@property (nullable, nonatomic, retain) NSNumber *seasonal;
@property (nullable, nonatomic, retain) BattleTag *battleTag;
@property (nullable, nonatomic, retain) Equipment *items;
@property (nullable, nonatomic, retain) NSSet<Skill *> *skills;
@property (nullable, nonatomic, retain) NSSet<Passive *> *passiveSkills;

@end

@interface Hero (CoreDataGeneratedAccessors)

- (void)addSkillsObject:(Skill *)value;
- (void)removeSkillsObject:(Skill *)value;
- (void)addSkills:(NSSet<Skill *> *)values;
- (void)removeSkills:(NSSet<Skill *> *)values;

- (void)addPassiveSkillsObject:(Passive *)value;
- (void)removePassiveSkillsObject:(Passive *)value;
- (void)addPassiveSkills:(NSSet<Passive *> *)values;
- (void)removePassiveSkills:(NSSet<Passive *> *)values;

@end

NS_ASSUME_NONNULL_END
