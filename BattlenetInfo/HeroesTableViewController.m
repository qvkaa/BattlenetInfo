//
//  HeroesTableViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "HeroesTableViewController.h"
#import "HeroInfoViewController.h"
@interface HeroesTableViewController () //<NSFetchedResultsControllerDelegate>

@end

@implementation HeroesTableViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initializeFetchedResultsController];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"heroInfo"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            HeroInfoViewController *vc = [segue destinationViewController];
            vc.hero = [self.characters objectAtIndex:path.row];
        }
    }
}
#pragma mark - private helper methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [[self.characters objectAtIndex:indexPath.row] valueForKey:@"heroName"];
    NSNumber *hardcore =[[self.characters objectAtIndex:indexPath.row] valueForKey:@"hardcore"];
    if ([hardcore boolValue]) {
        [cell.textLabel setTextColor:[UIColor redColor]];
    }
    cell.detailTextLabel.text = [[self.characters objectAtIndex:indexPath.row] valueForKey:@"heroClass"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.characters count];;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"heroCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;

}

@end
