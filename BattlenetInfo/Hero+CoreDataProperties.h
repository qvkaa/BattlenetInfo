//
//  Hero+CoreDataProperties.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/15/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Hero.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hero (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *heroClass;
@property (nullable, nonatomic, retain) NSString *heroName;
@property (nullable, nonatomic, retain) NSNumber *heroLevel;
@property (nullable, nonatomic, retain) NSNumber *hardcore;
@property (nullable, nonatomic, retain) NSNumber *heroID;
@property (nullable, nonatomic, retain) NSNumber *eliteKills;
@property (nullable, nonatomic, retain) NSNumber *seasonal;
@property (nullable, nonatomic, retain) BattleTag *battleTag;

@end

NS_ASSUME_NONNULL_END
