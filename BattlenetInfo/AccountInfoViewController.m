//
//  AccountInfoViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/19/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "HeroesTableViewController.h"
@interface AccountInfoViewController () <NSFetchedResultsControllerDelegate>

@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong,nonatomic) NSArray *leftLabel;
@property (strong,nonatomic) NSArray *rightLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeFetchedResultsController];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([NSManagedObject shouldSynchronizeObject:self.managedObject]) {
       // [BattleTag updateBattleTag:self.managedObject WithDictionary:<#(NSDictionary *)#> managedObjectContext:<#(NSManagedObjectContext *)#>]
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showHeroesSegue"]) {
        HeroesTableViewController *vc = [segue destinationViewController];
        vc.navigationItem.title = @"Heroes";
        vc.managedObject = self.managedObject;
        vc.managedObjectContext = self.managedObjectContext;
        vc.battleTag = [self.managedObject valueForKey:@"accountTag"];
        vc.region = [self.managedObject valueForKey:@"region"];
    }
}

#pragma mark - accessors

- (NSArray *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = @[@"Battle Tag", @"Guild Name ", @"Monsters Killed", @"Hardcore Monster Killed", @"Elites Killed", @"Paragon Level", @"Paragon Level Hardcore"];
    }
    return _leftLabel;
}
- (NSArray *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = @[[self.managedObject valueForKey:@"accountTag"],
                        [self.managedObject valueForKey:@"guildName"],
                        [[self.managedObject valueForKey:@"monsters"] stringValue],
                        [[self.managedObject valueForKey:@"hardcoreMonsters"] stringValue],
                        [[self.managedObject valueForKey:@"elites"] stringValue],
                        [[self.managedObject valueForKey:@"paragonLevel"] stringValue],
                        [[self.managedObject valueForKey:@"paragonLevelHardcore"] stringValue]];
    }
    return _rightLabel;
}

#pragma mark - tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 32.0f;
}

#pragma mark - private helper methods
- (NSString *)stringAtIndex:(NSUInteger)index {
    NSString *result;
    switch (index) {
        case 0 : {
           result = [self.managedObject valueForKey:@"accountTag"];
        } break;
        case 1 : {
            result = [self.managedObject valueForKey:@"guildName"];
        } break;
        case 2 : {
            result = [[self.managedObject valueForKey:@"monsters"] stringValue];
        } break;
        case 3 : {
            result = [[self.managedObject valueForKey:@"hardcoreMonsters"] stringValue];
        } break;
        case 4 : {
            result = [[self.managedObject valueForKey:@"elites"] stringValue];
        } break;
        case 5 : {
            result = [[self.managedObject valueForKey:@"paragonLevel"] stringValue];
        } break;
        case 6 : {
            result = [[self.managedObject valueForKey:@"paragonLevelHardcore"] stringValue];
        } break;
        default : {
            //error
        }break;
    }
    return result;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Fetch Record
//    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Update Cell
    
    cell.textLabel.text = [self.leftLabel objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self stringAtIndex:indexPath.row];
}
//
//#pragma mark - tableview datasource
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"accountInfoCell"];
//
//    cell.textLabel.text = [self.leftLabel objectAtIndex:indexPath.row];
//    cell.detailTextLabel.text = [self.rightLabel objectAtIndex:indexPath.row];
//
//    return cell;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leftLabel count];
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

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *sections = [self.fetchedResultsController sections];
//    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
//    
//    return [sectionInfo numberOfObjects];
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountInfoCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}



#pragma mark - fetchController

- (void)initializeFetchedResultsController {
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"BattleTag"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"accountTag == %@",[self.managedObject valueForKey:@"accountTag"]];
    
    [fetchRequest setPredicate:predicate];
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



@end
