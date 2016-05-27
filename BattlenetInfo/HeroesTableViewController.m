//
//  HeroesTableViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/13/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "HeroesTableViewController.h"
#import "HeroInfoViewController.h"
#import "DataManager.h"
#import "WebServiceManager.h"
@interface HeroesTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation HeroesTableViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.refreshControl addTarget:self action:@selector(refreshHeroes) forControlEvents:UIControlEventValueChanged];
    [self initializeFetchedResultsController];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshHeroes) forControlEvents:UIControlEventValueChanged];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[self.managedObject valueForKey:@"characters"] count] == 0 && [AFNetworkReachabilityManager sharedManager].reachable) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSString *region = [self.managedObject valueForKey:@"region"];
        NSString *accountTag = [self.managedObject valueForKey:@"accountTag"];
        NSDictionary *dictionary = [WebServiceManager dictionaryForBattleTagFetchRequestWithAccountTag:accountTag region:region];
        [DataManager addHeroesToBattleTag:(BattleTag *)self.managedObject
                           withDictionary:dictionary
                   inManagedObjectContext:self.managedObjectContext withCompletionBlock:^{
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                   }];
    }
    //
  
}
#pragma mark - private 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"heroInfo"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
           
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            HeroInfoViewController *vc = [segue destinationViewController];
            vc.hero = [self.fetchedResultsController objectAtIndexPath:path];
            
            vc.region = self.region;
            vc.battleTag = self.battleTag;
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Fetch Record
    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Update Cell
    
    cell.textLabel.text = [record valueForKey:@"heroName"];
    cell.detailTextLabel.text = [record valueForKey:@"heroClass"];
    NSNumber *hardcore =[record valueForKey:@"hardcore"];
    if ([hardcore boolValue]) {
        [cell.textLabel setTextColor:[UIColor redColor]];
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}
#pragma mark - tableview datasource

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        //        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"heroCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}



#pragma mark - fetchController

- (void)initializeFetchedResultsController {
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hero"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"battleTag == %@",self.managedObject];
    
    [fetchRequest setPredicate:predicate];
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"heroName" ascending:YES]]];
    
    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

#pragma mark - pull to refresh
//
//- (void)refreshBattleTags {
//    
//    NSArray *fetchedBattleTags = [self getAllBattleTags];
//    
//    if (fetchedBattleTags == nil) {
//        [self.refreshControl endRefreshing];
//        return;
//    }
//    
//    self.totalBattleTags = [fetchedBattleTags count];
//    if (self.totalBattleTags > 2) {
//        [self presentViewController:[AlertManager alertWithTitle:ALERT_MANY_ACCOUNTS_TITLE
//                                                         message:ALERT_MANY_ACCOUNTS_MESSAGE
//                           withYesAndNoButtonsAndCompletionBlock:^(BOOL action) {
//                               if (action) {
//                                   [self refreshBattleTags:fetchedBattleTags];
//                               } else {
//                                   [self.refreshControl endRefreshing];
//                                   return;
//                               }
//                           }]
//                           animated:YES
//                         completion:nil];
//    }
//}
//- (void)refreshBattleTags:(NSArray *)fetchedBattleTags {
//    
//    [self.tableView setUserInteractionEnabled:NO];
//    self.totalBattleTags = [fetchedBattleTags count];
//    self.refreshedBattleTags = 0;
//    
//    for (BattleTag *battleTag in fetchedBattleTags) {
//        if ([NSManagedObject shouldSynchronizeObject:battleTag]) {
//            NSString *region = [battleTag valueForKey:@"region"];
//            NSString *accountTag = [battleTag valueForKey:@"accountTag"];
//            NSDictionary *dictionary = [WebServiceManager dictionaryForBattleTagFetchRequestWithAccountTag:accountTag region:region];
//            [WebServiceManager fetchObjectWithDictionary:dictionary withCompletionBlock:^(NSDictionary *responseDictonary) {
//                [battleTag updateObjectWithDictionary:responseDictonary];
//                self.refreshedBattleTags += 1;
//                if (self.refreshedBattleTags >= self.totalBattleTags) {
//                    [self.refreshControl endRefreshing];
//                    [self.tableView setUserInteractionEnabled:YES];
//                }
//            }];
//        } else {
//            self.refreshedBattleTags += 1;
//            if (self.refreshedBattleTags >= self.totalBattleTags) {
//                [self.refreshControl endRefreshing];
//                [self.tableView setUserInteractionEnabled:YES];
//            }
//            
//        }
//    }
//}

- (NSArray *)getAllBattleTags {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BattleTag" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"accountTag"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

#pragma mark - private helper methods

- (void)refreshHeroes {
    NSLog(@"SADNESS");
}

@end
