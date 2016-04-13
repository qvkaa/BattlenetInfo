//
//  AddBattletagViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "AddBattletagViewController.h"
#import "WebServiceManager.h"
@interface AddBattletagViewController ()

@end

@implementation AddBattletagViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)userDidPressSave:(id)sender {
    [[WebServiceManager manager] fetchProfileWithBattleTag:@"tazza-2997" region:BattlenetRegionEU withCompletionBlock:^(NSArray *array) {
        
    }];
}

@end
