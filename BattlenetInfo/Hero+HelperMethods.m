//
//  Hero+HelperMethods.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/17/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "Hero+HelperMethods.h"

@implementation Hero (HelperMethods)

+ (NSPredicate *)predicateForHeroID:(NSString *)heroID {
    return [NSPredicate predicateWithFormat:@"heroID == %@", heroID];
}

+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)context {
    return nil;
}
+ (Hero *)insertHeroWithDictionary:(NSDictionary *)dictionary forBattletag:(BattleTag *)battleTag managedObjectContext:(NSManagedObjectContext *)context {
    NSNumber *eliteKills = [[dictionary valueForKey:@"kills"] valueForKey:@"elites"];
    NSNumber *hardcore = [dictionary valueForKey:@"hardcore"];
    NSString *heroClass = [dictionary valueForKey:@"class"];
    NSNumber *heroID = [dictionary valueForKey:@"id"];
    NSNumber *heroLevel = [dictionary valueForKey:@"level"];
    NSString *heroName = [dictionary valueForKey:@"name"];
    NSNumber *seasonal = [dictionary valueForKey:@"seasonal"];
    
    Hero* newHero = [NSEntityDescription insertNewObjectForEntityForName:@"Hero" inManagedObjectContext:context];
    
    
    newHero.eliteKills = eliteKills;
    newHero.hardcore = hardcore;
    newHero.heroClass = heroClass;
    newHero.heroID = heroID;
    newHero.heroLevel = heroLevel;
    newHero.heroName = heroName;
    newHero.seasonal = seasonal;
    newHero.lastSynched = [NSDate date];
    
    [battleTag addCharactersObject:newHero];
    [[CoreDataBridge sharedCoreDataBridge].manager saveContext];
    return newHero;

}

+(Hero *)updateHero:(Hero *)hero WithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context {
    NSNumber *eliteKills = [[dictionary valueForKey:@"kills"] valueForKey:@"elites"];
    NSNumber *hardcore = [dictionary valueForKey:@"hardcore"];
    NSString *heroClass = [dictionary valueForKey:@"class"];
    NSNumber *heroID = [dictionary valueForKey:@"id"];
    NSNumber *heroLevel = [dictionary valueForKey:@"level"];
    NSString *heroName = [dictionary valueForKey:@"name"];
    NSNumber *seasonal = [dictionary valueForKey:@"seasonal"];
    
    hero.eliteKills = eliteKills;
    hero.hardcore = hardcore;
    hero.heroClass = heroClass;
    hero.heroID = heroID;
    hero.heroLevel = heroLevel;
    hero.heroName = heroName;
    hero.seasonal = seasonal;
    hero.lastSynched = [NSDate date];
    
    [[CoreDataBridge sharedCoreDataBridge].manager saveContext];
    return hero;

}
@end
