//
//  CoreDataBridge.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/15/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"
#import "BattleTag+CoreDataProperties.h"
#import "BattleTag+HelperMethods.h"
#import "Hero+CoreDataProperties.h"
#import "Skill+CoreDataProperties.h"
#import "Passive+CoreDataProperties.h"
#import "NSManagedObject+HelperMethods.h"
#import "Item+CoreDataProperties.h"
@interface CoreDataBridge : NSObject

@property (strong,nonatomic) CoreDataManager* manager;


+ (instancetype)sharedCoreDataBridge;
//- (BattleTag *)insertBattleTagWithDictionary:(NSDictionary *)dictionary;
- (Hero *)insertHeroWithDictionary:(NSDictionary *)dictionary forBattleTag:(BattleTag *)battletag;
- (Skill *)insertSkillWithDictionary:(NSDictionary *)dictionary forHero:(Hero *)hero;
- (Passive *)insertPassiveSkillWithDictionary:(NSDictionary *)dictionary forHero:(Hero *)hero;
- (Item *)insertEquipmentWithDictionary:(NSDictionary *)dictionary type:(NSString *)type forHero:(Hero *)hero;
- (NSArray *)fetchAllBattleTags;
@end
