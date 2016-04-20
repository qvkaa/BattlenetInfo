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
@interface HeroesTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSArray *characters; // of Hero+CoreDataProperties

@end
