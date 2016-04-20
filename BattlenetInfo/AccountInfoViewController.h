//
//  AccountInfoViewController.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/19/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AccountInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong,nonatomic) NSManagedObject *managedObject;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSString *textString;
- (void)prepareTextLabel;
@end
