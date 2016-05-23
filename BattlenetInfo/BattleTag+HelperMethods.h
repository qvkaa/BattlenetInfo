//
//  BattleTag+HelperMethods.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "BattleTag.h"
#import "SynchronizableManagedObjectProtocol.h"
#import "CoreDataManager.h"

@interface BattleTag (HelperMethods) <SynchronizableManagedObject>

- (instancetype)updateObjectWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)insertObjectWithDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context;
+ (NSPredicate *)predicateForAccountTag:(NSString *)accountTag region:(NSString *)region;
- (NSDate *)lastSynchronizedDate;

@end
