//
//  BattleTagSelectionViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "BattleTagSelectionViewController.h"
#import "AddBattletagViewController.h"
#import "AccountInfoViewController.h"
#import "DataManager.h"
#import "BattleTag+HelperMethods.h"
#import "WebServiceManager.h"
#import "NSManagedObject+HelperMethods.h"
#import "AlertManager.h"

static NSString * const ALERT_MANY_ACCOUNTS_TITLE = @"This might take a while.";
static NSString * const ALERT_MANY_ACCOUNTS_MESSAGE = @"There are more than 10 accounts. This process might be slow. Do you wish to continue?";

@interface BattleTagSelectionViewController () <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong,nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) NSUInteger refreshedBattleTags;
@property (nonatomic) NSUInteger totalBattleTags;
@property (nonatomic) BOOL shouldProceedRefresh;

@end

@implementation BattleTagSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shouldProceedRefresh = NO;
    // Do any additional setup after loading the view.
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    
    [self initializeFetchedResultsController];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    
//    [self.refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:self.refreshControl];
//    
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.tableView;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshBattleTags) forControlEvents:UIControlEventValueChanged];
    tableViewController.refreshControl = self.refreshControl;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

#pragma mark - accessors

- (CGFloat)cellHeight {
    if (_cellHeight == 0.0f) {
        _cellHeight = 32.0f;
    }
    return _cellHeight;
}

#pragma mark - private helper methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Fetch Record
    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Update Cell
    [cell.textLabel setText:[record valueForKey:@"accountTag"]];
    
    if ([NSManagedObject shouldSynchronizeObject:record]) {
        cell.detailTextLabel.text = @"Not updated";
        cell.detailTextLabel.textColor = [UIColor redColor];
    } else {
        cell.detailTextLabel.text = @"Updated";
        cell.detailTextLabel.textColor = [UIColor greenColor];
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusableCell"];
    [self configureCell:cell atIndexPath:indexPath];
    
 
    return cell;
}

#pragma mark - tableview delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

#pragma mark - segue preperation 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showInfoSegue"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:path];
            AccountInfoViewController *vc = [segue destinationViewController];
            vc.managedObject = record;
            vc.managedObjectContext = self.managedObjectContext;
        }
    }

//    if ([[segue identifier] isEqualToString:@"newBattletagSegue"]) {
//       
//    }
}

#pragma mark - IBActions

- (IBAction)userDidPressEditButton:(id)sender {
    self.tableView.editing = !self.tableView.editing;
    
}

#pragma mark - fetchController

- (void)initializeFetchedResultsController {
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"BattleTag"];
    
    
    
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"accountTag" ascending:YES]]];
    
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

- (void)refreshBattleTags {
    
    NSArray *fetchedBattleTags = [self getAllBattleTags];
    
    if (fetchedBattleTags == nil) {
        [self.refreshControl endRefreshing];
        return;
    }
    
    self.totalBattleTags = [fetchedBattleTags count];
    if (self.totalBattleTags > 2) {
        [self presentViewController:[AlertManager alertWithTitle:ALERT_MANY_ACCOUNTS_TITLE
                                                         message:ALERT_MANY_ACCOUNTS_MESSAGE
                           withYesAndNoButtonsAndCompletionBlock:^(BOOL action) {
                               if (action) {
                                   [self refreshBattleTags:fetchedBattleTags];
                               } else {
                                   [self.refreshControl endRefreshing];
                                   return;
                               }
                            }]
                           animated:YES
                         completion:nil];
    }
}
- (void)refreshBattleTags:(NSArray *)fetchedBattleTags {
    
    [self.tableView setUserInteractionEnabled:NO];
    self.totalBattleTags = [fetchedBattleTags count];
    self.refreshedBattleTags = 0;
    
    for (BattleTag *battleTag in fetchedBattleTags) {
        if ([NSManagedObject shouldSynchronizeObject:battleTag]) {
            NSString *region = [battleTag valueForKey:@"region"];
            NSString *accountTag = [battleTag valueForKey:@"accountTag"];
            NSDictionary *dictionary = [WebServiceManager dictionaryForBattleTagFetchRequestWithAccountTag:accountTag region:region];
            [WebServiceManager fetchObjectWithDictionary:dictionary withCompletionBlock:^(NSDictionary *responseDictonary) {
                [battleTag updateObjectWithDictionary:responseDictonary];
                self.refreshedBattleTags += 1;
                if (self.refreshedBattleTags >= self.totalBattleTags) {
                    [self.refreshControl endRefreshing];
                    [self.tableView setUserInteractionEnabled:YES];
                }
            }];
        } else {
            self.refreshedBattleTags += 1;
            if (self.refreshedBattleTags >= self.totalBattleTags) {
                [self.refreshControl endRefreshing];
                [self.tableView setUserInteractionEnabled:YES];
            }

        }
    }
}

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
@end
