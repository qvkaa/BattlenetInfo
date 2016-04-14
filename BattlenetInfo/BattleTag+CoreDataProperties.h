//
//  BattleTag+CoreDataProperties.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/14/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BattleTag.h"

NS_ASSUME_NONNULL_BEGIN

@interface BattleTag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *battleTag;
@property (nullable, nonatomic, retain) NSString *region;
@property (nullable, nonatomic, retain) NSManagedObject *child;
@property (nullable, nonatomic, retain) NSManagedObject *parent;

@end

NS_ASSUME_NONNULL_END
