//
//  Hero+HelperMethods.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/17/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "Hero.h"
#import "CoreDataBridge.h"
@interface Hero (HelperMethods)
+ (NSPredicate *)predicateForHeroID:(NSString *)heroID;
+ (Hero *)insertHeroWithDictionary:(NSDictionary *)dictionary forBattletag:(BattleTag *)battleTag managedObjectContext:(NSManagedObjectContext *)context;
+ (Hero *)updateHero:(Hero *)hero WithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context;

@end
