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

+ (NSPredicate *)predicateForAccountTag:(NSString *)accountTag region:(NSString *)region;
+ (BattleTag *)insertBattleTagWithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context coreDataManager:(CoreDataManager *)manager;
+ (BattleTag *)updateBattleTag:(BattleTag *)battletag WithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context coreDataManager:(CoreDataManager *)manager;
- (NSDate *)lastSynchronizedDate;
@end
