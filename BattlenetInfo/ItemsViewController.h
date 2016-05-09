//
//  ItemsViewController.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/22/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hero+CoreDataProperties.h"
@interface ItemsViewController : UIViewController

@property (strong,nonatomic) Hero *hero;
@property (nonatomic) NSString *battleTag;
@property (nonatomic) NSString *region;

@end
