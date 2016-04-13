//
//  BattleTagSelectionViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/12/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "BattleTagSelectionViewController.h"
#import "AddBattletagViewController.h"
@interface BattleTagSelectionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic) CGFloat cellHeight;
@end

@implementation BattleTagSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
        _cellHeight = self.view.frame.size.height / 7;
    }
    return _cellHeight;
}

#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusableCell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
 
    return cell;
}

#pragma mark - tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}
#pragma mark - segue preperation 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showHeroesSegue"])
    {
        
        UITableViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.navigationItem.title = @"Heroes";
    }
    
    if ([[segue identifier] isEqualToString:@"newBattletagSegue"])
    {
    
       
    }

    
}

#pragma mark - IBActions
//- (IBAction)userDidPressAddButton:(id)sender {
//    if (!self.editing) {
//        [self performSegueWithIdentifier:@"showHeroesSegue" sender:sender];
//    }
//}
- (IBAction)userDidPressEditButton:(id)sender {
    self.tableView.editing = !self.tableView.editing;
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
