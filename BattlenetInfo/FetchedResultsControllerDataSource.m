//
//  FetchedResultsControllerDataSource.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/14/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "FetchedResultsControllerDataSource.h"

@interface FetchedResultsControllerDataSource ()

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong,nonatomic) NSString *reuseIdentifier;
@end

@implementation FetchedResultsControllerDataSource

- (id)initWithTableView:(UITableView*)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.tableView.dataSource = self;
    }
    return self;
}

- (void)setFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController
{
    _fetchedResultsController = fetchedResultsController;
    fetchedResultsController.delegate = self;
    [fetchedResultsController performFetch:NULL];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    id<NSFetchedResultsSectionInfo> section = self.fetchedResultsController.sections[sectionIndex];
    return section.numberOfObjects;
}
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    id cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier
                                              forIndexPath:indexPath];
    [self.delegate configureCell:cell withObject:object];
    return cell;
}


@end
