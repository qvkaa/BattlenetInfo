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
#pragma mark - accessors
- (NSArray *)regions {
    if (!_regions) {
        _regions = @[@"eu", @"na",@"kr", @"tw", @"cn"];
    }
    return _regions;
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.regions.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.regions[row];
}
#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
//    float rate = [_exchangeRates[row] floatValue];
//    float dollars = [_dollarText.text floatValue];
//    float result = dollars * rate;
//    
//    NSString *resultString = [[NSString alloc] initWithFormat:
//                              @"%.2f USD = %.2f %@", dollars, result,
//                              _countryNames[row]];
//    _resultLabel.text = resultString;
}

#pragma mark - IBActions
- (IBAction)userDidPressSave:(id)sender {
    NSString *battleTag = self.battleTagTextField.text;
    [[WebServiceManager manager] fetchProfileWithBattleTag:battleTag region:BattlenetRegionEU withCompletionBlock:^(NSDictionary *dictionary) {
        if (dictionary) {
            CoreDataBridge *sharedCoreDataBridge = [CoreDataBridge sharedCoreDataBridge];
            [sharedCoreDataBridge insertBattleTagWithDictionary:dictionary];
            [sharedCoreDataBridge fetchAllBattleTags];
        }else {
            
            [self alertWithTitle:@"Invalid Battle Tag" message:@"Please insert a valid tag e.g. noob-1234."];

        }
    }];
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
@end
