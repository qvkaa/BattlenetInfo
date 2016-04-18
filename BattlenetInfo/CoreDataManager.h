//
//  CoreDataManager.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic) NSArray * battleTags;
+ (id)sharedCoreDataManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



@end
