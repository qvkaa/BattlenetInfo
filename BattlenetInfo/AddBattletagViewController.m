//
//  AddBattletagViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

/*
 tazza-2997
 tailgunner-2266
 jonin-2172
 */
#import "AddBattletagViewController.h"
#import "WebServiceManager.h"
#import "CoreDataBridge.h"
@interface AddBattletagViewController () 
@property (weak, nonatomic) IBOutlet UITextField *battleTagTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (strong, nonatomic)  UIPickerView *pickerView;

@end

@implementation AddBattletagViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPickerView];
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - accessors
- (NSArray *)regions {
    if (!_regions) {
        _regions = @[@"eu", @"na",@"kr", @"tw", @"cn"];
    }
    return _regions;
}

- (void)initPickerView {
  
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [_pickerView setShowsSelectionIndicator:YES];
        self.regionTextField.inputView = _pickerView;
}
#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return self.regions.count;
}

#pragma mark -
#pragma mark PickerView Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.regions[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.regionTextField.text = [self.regions objectAtIndex:row];
}


#pragma mark - IBActions
- (IBAction)userDidPressSave:(id)sender {
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        [self alertWithTitle:@"No Internet Connection" message:@"You need to be online to use this feature."];
        return;
    }
    NSString *battleTag = self.battleTagTextField.text;
    NSString *region = self.regionTextField.text;
    if ([battleTag length] < 6) {
         [self alertWithTitle:@"Missing Battle Tag" message:@"Please insert a valid tag e.g. noob-1234."];
    } else if ([region isEqualToString:@""]) {
         [self alertWithTitle:@"Missing Region" message:@"Please select a region."];
        
    } else {
        
        BOOL isExisting = YES;
        [[DataManager sharedDataManager] addProfileWithBattleTag:battleTag region:region isExisting:&isExisting withCompletionBlock:^(BOOL success) {
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                if (isExisting) {
                    [self alertWithTitle:@"Battle Tag exists" message:@"A BattleTag with the same name and region exists"];
                } else {
                    [self alertWithTitle:@"Invalid Battle Tag" message:@"Please insert a valid tag e.g. noob-1234."];
                }
                
            }
        }];

    }
}
- (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)userDidTapBackground:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.battleTagTextField) {
        [self.regionTextField becomeFirstResponder];
    }
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.regionTextField) {
        if ([self.regionTextField.text isEqualToString:@""]){
            self.regionTextField.text = @"eu";
        }
    }
}
@end
