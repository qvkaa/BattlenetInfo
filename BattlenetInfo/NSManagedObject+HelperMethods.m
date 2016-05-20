//
//  NSManagedObject+HelperMethods.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "NSManagedObject+HelperMethods.h"
#import "SynchronizableManagedObjectProtocol.h"
@implementation NSManagedObject (HelperMethods)

+ (instancetype)findOrCreateObjectWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName context:(NSManagedObjectContext *)context isExisting:(BOOL *)isExisting andCreationBlock:(id (^)(void)) creationBlock {
    NSParameterAssert(predicate);
    
    //Class managedObjectSubclass = [self class];
    
    NSArray *existing = [NSManagedObject allInstancesWithPredicate:predicate entityName:entityName inManagedObjectContext:context];
    
    if (existing.count > 0) {
        NSAssert(existing.count == 1, @"There must be only one object with a certain ID");
        if (isExisting) {
            *isExisting = YES;
        }
        return existing.firstObject;
    } else {
        NSParameterAssert(creationBlock);
        if (isExisting) {
            *isExisting = NO;
        }
        return creationBlock();
    }
    
    return nil;
}

//+ (NSManagedObject *)updateObject:(NSManagedObject *)object
//                WithDictionary:(NSDictionary *)dictionary
//          managedObjectContext:(NSManagedObjectContext *)context
//               coreDataManager:(CoreDataManager *)manager {
//    Class managedObjectSubclass = [object class];
//    
//  return [managedObjectSubclass updateObject:object WithDictionary:dictionary managedObjectContext:context coreDataManager:manager];
//}

+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    [request setReturnsObjectsAsFaults:NO];
    [request setPredicate:predicate];
    NSError *error = nil;
    return [context executeFetchRequest:request error:&error];
}
+ (BOOL)shouldSynchronizeObject:(NSManagedObject<SynchronizableManagedObject> *)object {
    BOOL shouldSync;
    if (!object) {
        shouldSync = YES;
    } else {
        NSDate *previousDate = [object lastSynchronizedDate];
        if (!previousDate) {
            shouldSync = YES;
        } else {
            NSDate *currentDate = [NSDate date];
            CGFloat secondsSinceLastSync = [currentDate timeIntervalSinceDate:previousDate];
            if (secondsSinceLastSync < 3600.0f) {
                shouldSync = NO;
            } else {
                shouldSync = YES;
            }
        }
    }
        return shouldSync;
}
//+ (void)updateObject:(NSManagedObject *)object {
//    if (object respondsToSelector:@"update")
//}
@end
