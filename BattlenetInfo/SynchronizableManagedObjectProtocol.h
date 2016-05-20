//
//  SynchronizableManagedObjectProtocol.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/18/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoreDataManager;
@protocol SynchronizableManagedObject <NSObject>

@required
- (NSDate *)lastSynchronizedDate;

- (NSManagedObject *)updateObjectWithDictionary:(NSDictionary *)dictionary
                     managedObjectContext:(NSManagedObjectContext *)context
                          coreDataManager:(CoreDataManager *)manager;
+ (instancetype)insertObjectWithDictionary:(NSDictionary *)dictionary
                      managedObjectContext:(NSManagedObjectContext *)context
                           coreDataManager:(CoreDataManager *)manager;


@end

@interface SynchronizableManagedObjectProtocol : NSObject

@end
