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
@interface CoreDataBridge : NSObject

+ (instancetype)sharedCoreDataBridge;
- (BattleTag *)insertBattleTag;
- (NSArray *)fetchAllBattleTags;
@end
