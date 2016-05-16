//
//  AlertManager.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/16/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager

//+ (instancetype)sharedAlertManager {
//    static dispatch_once_t once;
//    static id sharedAlertManager;
//    dispatch_once(&once, ^{
//        sharedAlertManager = [[self alloc] init];
//    });
//    return sharedAlertManager;
//}
+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    return alert;
}

@end
