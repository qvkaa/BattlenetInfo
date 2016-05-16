//
//  AlertManager.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/16/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlertManager : NSObject
//+ (instancetype)sharedAlertManager;
+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message;
@end
