//
//  SynchronizableManagedObjectProtocol.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/18/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;
@class NSManagedObject;
@protocol SynchronizableManagedObject <NSObject>

@required

- (NSDate *)lastSynchronizedDate;
- (NSManagedObject *)updateObjectWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)insertObjectWithDictionary:(NSDictionary *)dictionary  inContext:(NSManagedObjectContext *)context;

@end

@interface SynchronizableManagedObjectProtocol : NSObject

@end
