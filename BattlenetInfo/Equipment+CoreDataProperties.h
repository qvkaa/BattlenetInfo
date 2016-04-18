//
//  Equipment+CoreDataProperties.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/18/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Equipment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Equipment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *xds;
@property (nullable, nonatomic, retain) Hero *hero;

@end

NS_ASSUME_NONNULL_END
