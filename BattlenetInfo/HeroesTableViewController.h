//
//  HeroesTableViewController.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface HeroesTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>


@property (strong,nonatomic) NSManagedObject *managedObject;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)initializeFetchedResultsController;



@end
