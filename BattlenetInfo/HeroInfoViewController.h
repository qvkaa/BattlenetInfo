//
//  HeroInfoViewController.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/21/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hero+CoreDataProperties.h"
#import "WebServiceManager.h"
@interface HeroInfoViewController : UIViewController

@property (strong,nonatomic) Hero *hero;
@property (nonatomic) NSString *battleTag;
@property (nonatomic) NSString *region;

@end
