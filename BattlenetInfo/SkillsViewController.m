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
#import "UIImageView+AFNetworking.h"

@interface SkillsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *icons;
@property (strong,nonatomic) NSMutableArray *skillNames;
@property (strong,nonatomic) NSMutableArray *runeNames;

@property (strong,nonatomic) NSMutableArray *passiveNames;
@property (strong,nonatomic) NSMutableArray *passiveIcons;

@end

@implementation SkillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SkillCell" bundle:nil] forCellReuseIdentifier:@"skillCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    if ([[self.hero valueForKey:@"skills"] count] == 0 ) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[DataManager sharedDataManager] fetchSkillsInfoWithBattleTag:self.battleTag region:self.region heroID:self.heroID forHero:self.hero withCompletionBlock:^(BOOL success) {
                [self initilizeDataSource];
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    } else {
        [self initilizeDataSource];
        [self.tableView reloadData];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private helper methods
- (void)initilizeDataSource {
    _icons = [[NSMutableArray alloc] initWithCapacity:6];
    _skillNames = [[NSMutableArray alloc] initWithCapacity:6];
    _runeNames = [[NSMutableArray alloc] initWithCapacity:6];
    
    _passiveIcons = [[NSMutableArray alloc] initWithCapacity:4];
    _passiveNames = [[NSMutableArray alloc] initWithCapacity:4];
    
    
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"skillName" ascending:YES];
    NSSet *skillsSet = [self.hero valueForKey:@"skills"];
    NSArray *skills = [skillsSet sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameDescriptor]];
  
    for (Skill *skill in skills) {
        
        [self.icons addObject:[skill valueForKey:@"icon"] ? [skill valueForKey:@"icon"] : @""];
        [self.skillNames addObject:[skill valueForKey:@"skillName"] ? [skill valueForKey:@"skillName"] : @"Not Selected"];
        [self.runeNames addObject:[skill valueForKey:@"runeName"] ? [skill valueForKey:@"runeName"] : @"Not Selected"];
    }
    
    nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"passiveName" ascending:YES];
    skillsSet = [self.hero valueForKey:@"passiveSkills"];
    skills = [skillsSet sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameDescriptor]];
    
    
    for (Skill *skill in skills) {
        [self.passiveIcons addObject:[skill valueForKey:@"icon"] ? [skill valueForKey:@"icon"] : @""];
        [self.passiveNames addObject:[skill valueForKey:@"passiveName"] ? [skill valueForKey:@"passiveName"] : @"Not Selected"];
    }
}
- (void)configureCell:(SkillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
       
        cell.skillNameLabel.text = [self.skillNames objectAtIndex:indexPath.row];
        cell.runeNameLabel.text = [self.runeNames objectAtIndex:indexPath.row];
        NSString *icon = [self.icons objectAtIndex:indexPath.row];
        NSString *urlString = [WebServiceManager imageURLWithType:@"skills" icon:icon];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        cell.iconImageView.image = [UIImage imageNamed:@"noImage"];
        [cell.iconImageView setImageWithURLRequest:request
                                   placeholderImage:nil
                                            success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                                cell.iconImageView.image = image;
                                            }
                                            failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                cell.iconImageView.image = [UIImage imageNamed:@"noImage"];
                                            }];

    } else {
        cell.skillNameLabel.text = [NSString stringWithFormat:@"%@",[self.passiveNames objectAtIndex:indexPath.row]];
        cell.runeNameLabel.text = @"";
        NSString *icon = [self.passiveIcons objectAtIndex:indexPath.row];
        NSString *urlString = [WebServiceManager imageURLWithType:@"skills" icon:icon];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        cell.iconImageView.image = [UIImage imageNamed:@"noImage"];
        [cell.iconImageView setImageWithURLRequest:request
                                  placeholderImage:nil
                                           success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                               cell.iconImageView.image = image;
                                           }
                                           failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                               cell.iconImageView.image = [UIImage imageNamed:@"noImage"];
                                           }];
        

    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.0f;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.icons count];
    } else {
        return [self.passiveIcons count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SkillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"skillCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"skillTypeHeader"];// [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"skillTypeHeader"];
//    header.contentView.backgroundColor = [UIColor whiteColor];
//    if (section == 0) {
//        header.textLabel.text = @"Active Skills";
//    } else {
//        header.textLabel.text = @"Passive Skills";
//    }
//    return header;
//}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        if (section == 0) {
            return @"Active Skills";
        } else {
            return @"Passive Skills";
        }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36.0f;
}
#pragma mark - helper methods

- (void)insertSkillsWithDictionary:(NSDictionary *)dictionary {
    NSArray *activeSkills = [[dictionary valueForKey:@"skills"] valueForKey:@"active"];
    for (NSDictionary *skillDictionary in activeSkills) {
     [[CoreDataBridge sharedCoreDataBridge] insertSkillWithDictionary:skillDictionary forHero:self.hero];
    }
    activeSkills = [[dictionary valueForKey:@"skills"] valueForKey:@"passive"];
    
    for (NSDictionary *skillDictionary in activeSkills) {
        [[CoreDataBridge sharedCoreDataBridge] insertPassiveSkillWithDictionary:skillDictionary forHero:self.hero];
    }
    
}


@end
