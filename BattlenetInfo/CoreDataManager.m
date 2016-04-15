//
//  CoreDataManager.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager ()
//@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;


@end

@implementation CoreDataManager
#pragma mark - class methods
+ (id)sharedCoreDataManager {
    static CoreDataManager *sharedCoreDataManager = nil;
    @synchronized (self) {
        if (!sharedCoreDataManager) {
            sharedCoreDataManager = [[self alloc] init];
        }
    }
    return sharedCoreDataManager;
}

#pragma mark - lifecycle

//- (void)initializeFetchedResultsController
//{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
//    
//    NSSortDescriptor *lastNameSort = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
//    
//    [request setSortDescriptors:@[lastNameSort]];
//    
//    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType]; //Retrieve the main queue NSManagedObjectContext
//    
//    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]];
//    [[self fetchedResultsController] setDelegate:self];
//    
//    NSError *error = nil;
//    if (![[self fetchedResultsController] performFetch:&error]) {
//        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
//        abort();
//    }
//}

//- (void)initializeCoreDataStack {
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PPRecipes" withExtension:@"momd"];
//    ZAssert(modelURL, @"Failed to find model URL");
//
//    NSManagedObjectModel *mom = nil;
//    mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL]; ZAssert(mom, @"Failed to initialize model");
//}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.yavor.BattlenetInfo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BattlenetInfo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BattlenetInfo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
