//
//  Equipment+CoreDataProperties.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/26/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Equipment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Equipment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bracers;
@property (nullable, nonatomic, retain) NSString *feet;
@property (nullable, nonatomic, retain) NSString *hands;
@property (nullable, nonatomic, retain) NSString *head;
@property (nullable, nonatomic, retain) NSString *leftFinger;
@property (nullable, nonatomic, retain) NSString *legs;
@property (nullable, nonatomic, retain) NSString *mainHand;
@property (nullable, nonatomic, retain) NSString *neck;
@property (nullable, nonatomic, retain) NSString *offHand;
@property (nullable, nonatomic, retain) NSString *rightFinger;
@property (nullable, nonatomic, retain) NSString *shoulders;
@property (nullable, nonatomic, retain) NSString *torso;
@property (nullable, nonatomic, retain) NSString *waist;
@property (nullable, nonatomic, retain) Hero *hero;

@end

NS_ASSUME_NONNULL_END
