//
//  LogInViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/1/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "LogInViewController.h"
#import "WebServiceManager.h"
@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LogInViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordTextField.secureTextEntry = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - IBAction
- (IBAction)tapLoginButton:(id)sender {
    
    [self sendRequestWithName:nil password:nil];
}

#pragma mark - Web service methods

- (void)sendRequestWithName:(NSString *)username password:(NSString *)password {
    WebServiceManager* manager = [WebServiceManager sharedWebServiceManager];
    [manager authenticateWithUsername:self.userNameTextField.text password:self.passwordTextField.text region:@"eu"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
