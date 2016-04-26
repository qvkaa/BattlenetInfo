//
//  SkillsViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/22/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "SkillsViewController.h"
#import "MBProgressHUD.h"
#import "SkillCell.h"
@interface SkillsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SkillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[WebServiceManager manager] fetchCharacterInfoWithBattleTag:self.battleTag region:self.region heroID:self.heroID withCompletionBlock:^(NSDictionary *dictonary) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self insertSkillsWithDictionary:dictonary];
                [self.tableView registerNib:[UINib nibWithNibName:@"SkillCell" bundle:nil] forCellReuseIdentifier:@"skillCell"];
                self.tableView.delegate = self;
                self.tableView.dataSource = self;
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
               
            });
        }];
    });
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private helper methods

- (void)configureCell:(SkillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.skillNameLabel.text = @"SSA";
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row ==7) {
        return 30.0f;
    }
    return 100.0f;
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row ==7) {
        UITableViewCell *regularCell = [tableView dequeueReusableCellWithIdentifier:@"activeSkillsCell"];
        if (indexPath.row == 0) {
            regularCell.textLabel.text = @"Active Skills : ";
        } else {
            regularCell.textLabel.text = @"Passive Skills : ";
        }
        return regularCell;
    }
    SkillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"skillCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}

#pragma mark - helper methods

- (void)insertSkillsWithDictionary:(NSDictionary *)dictionary {
    NSArray *activeSkills = [[dictionary valueForKey:@"skills"] valueForKey:@"active"];
    for (NSDictionary *skillDictionary in activeSkills) {
       [self.hero addSkillsObject:[[CoreDataBridge sharedCoreDataBridge] insertSkillWithDictionary:skillDictionary]];
    }
    activeSkills = [[dictionary valueForKey:@"skills"] valueForKey:@"passive"];
    
    for (NSDictionary *skillDictionary in activeSkills) {
        [self.hero addPassiveSkillsObject:[[CoreDataBridge sharedCoreDataBridge] insertPassiveSkillWithDictionary:skillDictionary]];
    }
    
}

@end
