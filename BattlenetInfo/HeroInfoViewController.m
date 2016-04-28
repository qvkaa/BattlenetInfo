//
//  HeroInfoViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/21/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "HeroInfoViewController.h"
#import "SkillsViewController.h"


@interface HeroInfoViewController ()

@property (strong,nonatomic) NSArray *leftLabel;
@property (strong,nonatomic) NSArray *rightLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HeroInfoViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"skillsSegue"]) {
        SkillsViewController *vc = [segue destinationViewController];
        
        vc.region = self.region;
        vc.battleTag = self.battleTag;
        vc.hero = self.hero;
        vc.heroID = [self.hero valueForKey:@"heroID"];
    }
}

#pragma mark - accessors

- (NSArray *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = @[@"Name", @"Class ", @"Level", @"Hardcore", @"Seasonal", @"Elite Kills"];
    }
    return _leftLabel;
}
- (NSArray *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = @[self.hero.heroName
                        ,self.hero.heroClass
                        ,[self.hero.heroLevel stringValue]
                        ,[self.hero.hardcore boolValue] ? @"YES" : @"NO"
                        ,[self.hero.seasonal boolValue] ? @"YES" : @"NO"
                        ,[self.hero.eliteKills stringValue]];
    }
    return _rightLabel;
}

#pragma mark - tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 32.0f;
}

#pragma mark - tableview datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"heroInfoCell"];
    
    cell.textLabel.text = [self.leftLabel objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.rightLabel objectAtIndex:indexPath.row];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leftLabel count];
}



#pragma mark - helper methods


#pragma mark - IBActions


@end
