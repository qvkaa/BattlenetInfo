//
//  BattleTag+HelperMethods.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "BattleTag.h"

@interface BattleTag (HelperMethods)
//+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSPredicate *)predicateForAccountTag:(NSString *)accountTag region:(NSString *)region;
+ (BattleTag *)insertBattleTagWithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context;
+ (BattleTag *)updateBattleTag:(BattleTag *)battletag WithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context;

@end
