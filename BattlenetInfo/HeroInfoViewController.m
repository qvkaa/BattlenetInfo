//
//  HeroInfoViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/21/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "HeroInfoViewController.h"

@interface HeroInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *heroInfoLabel;

@end

@implementation HeroInfoViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addInfoToLabel];
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - helper methods

- (void)addInfoToLabel {
    self.heroInfoLabel.text = [NSString stringWithFormat:
                               @"Name : %@\n"
                               @"Class : %@\n"
                               @"Level : %@\n"
                               @"Hardcore : %@\n"
                               @"Seasonal : %@\n"
                               @"Elite Kills : %@"
                               ,self.hero.heroName
                               ,self.hero.heroClass
                               ,self.hero.heroLevel
                               ,[self.hero.hardcore boolValue] ? @"YES" : @"NO"
                               ,[self.hero.seasonal boolValue] ? @"YES" : @"NO"
                               ,self.hero.eliteKills
                               ];
}

#pragma mark - IBActions

@end
