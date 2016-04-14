//
//  AccountBase.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/14/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "AccountBase.h"

@interface AccountBase ()
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation AccountBase

- (BattleTag*)rootItem
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", nil];
    NSArray* objects = [self.managedObjectContext executeFetchRequest:request error:NULL];
    BattleTag* rootItem = [objects lastObject];
    if (rootItem == nil) {
        rootItem = [rootItem ]
        rootItem = [BattleTag insertBattleTagWithTitle:nil
                                      parent:nil
                      inManagedObjectContext:self.managedObjectContext];
    }
    return rootItem;
}


@end
