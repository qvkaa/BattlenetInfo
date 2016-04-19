//
//  BattleTagSelectionViewController.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceManager.h"
#import <CoreData/CoreData.h>
@interface BattleTagSelectionViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (void)initializeFetchedResultsController;

@end
