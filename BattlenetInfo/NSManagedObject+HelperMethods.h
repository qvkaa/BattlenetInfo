//
//  NSManagedObject+HelperMethods.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BattleTag+HelperMethods.h"
#import <UIKit/UIKit.h>
@interface NSManagedObject (HelperMethods)

+ (instancetype)findOrCreateObjectWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName context:(NSManagedObjectContext *)context isExisting:(BOOL *)isExisting andCreationBlock:(id (^)(void))creationBlock;
+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)context;
+ (BOOL)shouldSynchronizeObject:(NSManagedObject *)object;
@end
