//
//  SkillsViewController.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/22/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hero+CoreDataProperties.h"
#import "WebServiceManager.h"
#import "CoreDataBridge.h"
@interface SkillsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) Hero* hero;
@property (nonatomic) NSString *heroID;
@property (nonatomic) NSString *battleTag;
@property (nonatomic) NSString *region;

@end
