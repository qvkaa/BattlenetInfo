//
//  NSManagedObject+HelperMethods.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "NSManagedObject+HelperMethods.h"

@implementation NSManagedObject (HelperMethods)

+ (instancetype)findOrCreateObjectWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context isExisting:(BOOL *)isExisting andCreationBlock:(id (^)(void)) creationBlock {
    NSParameterAssert(predicate);
    
    Class managedObjectSubclass = [self class];
    
    NSArray *existing = [managedObjectSubclass allInstancesWithPredicate:predicate inManagedObjectContext:context];
    
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

@end
