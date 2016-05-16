//
//  AddBattletagViewController.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "AlertManager.h"
@interface AddBattletagViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>


@property (strong, nonatomic) NSArray *regions;

@end
