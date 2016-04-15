//
//  CoreDataBridge.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/15/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "CoreDataBridge.h"
#import "CoreDataManager.h"

@interface CoreDataBridge ()

@property (strong,nonatomic) CoreDataManager* manager;

@end

@implementation CoreDataBridge

+ (instancetype)sharedCoreDataBridge {
    static dispatch_once_t once;
    static id sharedCoreDataBridge;
    dispatch_once(&once, ^{
        sharedCoreDataBridge = [[self alloc] init];
    });
    return sharedCoreDataBridge;
}
#pragma mark - insert
- (BattleTag *)insertBattleTag {
    BattleTag* battleTag = [NSEntityDescription insertNewObjectForEntityForName:@"BattleTag" inManagedObjectContext:self.manager.managedObjectContext];
    battleTag.accountTag = @"tazza#2997";
    battleTag.guildName = @"Yamato";
    
    [self.manager saveContext];
    
    NSLog(@"Saving User to Core Data completed.");
    return battleTag;
}
- (NSArray *)fetchAllBattleTags {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BattleTag"];
    [request setReturnsObjectsAsFaults:NO];
    NSError *error = nil;
    NSArray *battleTags = [self.manager.managedObjectContext executeFetchRequest:request error:&error];
    [self.manager  saveContext];
    NSLog(@"Fetching battleTags Completed.");
    NSLog(@"battleTags: %@", battleTags);
    NSLog(@"battleTags #: %lu", (unsigned long)[battleTags count]);
    self.manager.battleTags = [NSArray arrayWithArray:battleTags];
    return battleTags;
    
}

@end
