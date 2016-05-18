//
//  SynchronizableManagedObjectProtocol.h
//  BattlenetInfo
//
//  Created by yavoraleksiev on 5/18/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SynchronizableManagedObject <NSObject>

@required
- (NSDate *)lastSynchronizedDate;
@end

@interface SynchronizableManagedObjectProtocol : NSObject

@end
