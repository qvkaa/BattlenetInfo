//
//  Skill+CoreDataProperties.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/23/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Skill.h"

NS_ASSUME_NONNULL_BEGIN

@interface Skill (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *runeName;
@property (nullable, nonatomic, retain) NSDate *lastSynced;
@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) NSString *skillName;
@property (nullable, nonatomic, retain) Hero *hero;

@end

NS_ASSUME_NONNULL_END
