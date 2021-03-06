//
//  HeroesTableViewController.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Hero+CoreDataProperties.h"
#import "BattleTag+CoreDataProperties.h"
#import "MBProgressHUD.h"
@interface HeroesTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSManagedObject *managedObject;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSString *battleTag;
@property (nonatomic) NSString *region;

@end
