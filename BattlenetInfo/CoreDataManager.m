//
//  CoreDataManager.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager ()


@end

@implementation CoreDataManager
+ (id)sharedCoreDataManager {
    static CoreDataManager *sharedCoreDataManager = nil;
    @synchronized (self) {
        if (sharedCoreDataManager == nil)
            sharedCoreDataManager = [[self alloc] init];
        
    }
    return sharedCoreDataManager;
}
@end
