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

@end

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTextLabel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - helper methods
- (void)prepareTextLabel {
    
    self.infoLabel.text = [NSString stringWithFormat:@"Battle Tag : %@\nGuild Name : %@\nMonsters Killed : %@\nHardcore Monster Killed : %@\nElites Killed : %@\nParagon Level :%@\nParagon Level Hardcore : %@",//\nParagon Season Level %@\nParagon Season Level Hardcore : %@",
                            [self.managedObject valueForKey:@"accountTag"],
                            [self.managedObject valueForKey:@"guildName"],
                            [self.managedObject valueForKey:@"monsters"],
                            [self.managedObject valueForKey:@"hardcoreMonsters"],
                            [self.managedObject valueForKey:@"elites"],
                            [self.managedObject valueForKey:@"paragonLevel"],
                            [self.managedObject valueForKey:@"paragonLevelHardcore"]
                           // [self.managedObject valueForKey:@"paragonLevelSeason"],
                           // [self.managedObject valueForKey:@"paragonLevelSeasonHardcore"]
                           ];
    
    
    
//    [managedObject valueForKey:@"account tag"];
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

@end
