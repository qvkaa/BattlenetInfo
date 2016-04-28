//
//  AccountInfoViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/19/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "HeroesTableViewController.h"
@interface AccountInfoViewController ()

@property (strong,nonatomic) NSArray *leftLabel;
@property (strong,nonatomic) NSArray *rightLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showHeroesSegue"]) {
        HeroesTableViewController *vc = [segue destinationViewController];
        vc.navigationItem.title = @"Heroes";
        NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"heroName" ascending:YES];
        NSSet *characterSet = [self.managedObject valueForKey:@"characters"];
        NSArray *characters = [characterSet sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameDescriptor]];
        vc.characters = characters;
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

#pragma mark - tableview datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"accountInfoCell"];
    
    cell.textLabel.text = [self.leftLabel objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.rightLabel objectAtIndex:indexPath.row];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leftLabel count];
}



@end
