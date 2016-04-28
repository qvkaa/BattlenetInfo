//
//  AccountInfoViewController.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/19/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AccountInfoViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSManagedObject *managedObject;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
