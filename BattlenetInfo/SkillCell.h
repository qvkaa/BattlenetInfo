//
//  SkillCell.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/26/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *skillNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *runeNameLabel;

@end
