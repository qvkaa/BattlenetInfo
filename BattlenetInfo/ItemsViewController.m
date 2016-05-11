//
//  ItemsViewController.m
//  BattlenetInfo
//
//  Created by yavoraleksiev on 4/22/16.
//  Copyright © 2016 yavoraleksiev. All rights reserved.
//

#import "ItemsViewController.h"
#import "UIImageView+AFNetworking.h"
@interface ItemsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *torsoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *helmImageView;
@property (weak, nonatomic) IBOutlet UIImageView *offHandImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mainHandImageView;
@property (weak, nonatomic) IBOutlet UIImageView *beltImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pantsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bootsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftRingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightRingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *neckImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shoulderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *glovesImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bracersImageView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *equipments;


@end

@implementation ItemsViewController

#pragma mark - lifecycle

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[self.hero valueForKey:@"equips"] count] == 0 ) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     
            [[DataManager sharedDataManager] fetchCharacterInfoWithBattleTag:self.battleTag region:self.region heroID:self.heroID forHero:self.hero withCompletionBlock:^(BOOL success) {
                if (success) {
                    [self initilizeEquipmentViews];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                }
            }];
    } else {
        [self initilizeEquipmentViews];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - helper methods
- (void)initilizeEquipmentViews {
    NSSortDescriptor *typeDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:YES];
    NSSet *itemsSet = [self.hero valueForKey:@"equips"];
    NSArray *items = [itemsSet sortedArrayUsingDescriptors:[NSArray arrayWithObject:typeDescriptor]];
    
    NSString *icon;
    NSString *itemID;
    NSString *itemName;
    NSString *toolTipParam;
    NSString *type;
    NSString *displayColor;
    
    for (Item *item in items) {
        
        icon = [item valueForKey:@"icon"];
        itemID = [item valueForKey:@"itemID"];
        itemName = [item valueForKey:@"itemName"];
        toolTipParam = [item valueForKey:@"toolTipParam"];
        type = [item valueForKey:@"type"];
        displayColor = [item valueForKey:@"displayColor"];
        
        NSString *urlString = [WebServiceManager imageURLWithType:@"items" icon:icon];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
       
        [self setItemImageWithRequest:request type:type];
        [self setItemBackgroundWithDisplayColor:displayColor type:type];
        
        
    }

}

- (void)setItemImageWithRequest:(NSURLRequest *)request type:(NSString *)type {
    [[self imageViewForType:type] setImageWithURLRequest:request
                                        placeholderImage:nil
                                                 success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                                     [self imageViewForType:type].image = image;
                                                 }
                                                 failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {

                                                 }];
}
- (void)setItemBackgroundWithDisplayColor:(NSString *)color type:(NSString *)type {
    if ([color isEqualToString:@"orange"]) {
        [[self imageViewForType:type] setBackgroundColor:[UIColor orangeColor]];
    } else if ([color isEqualToString:@"green"]) {
        [[self imageViewForType:type] setBackgroundColor:[UIColor colorWithRed:0.5f green:0.9f blue:0.5f alpha:1.0f]];
    } else if ([color isEqualToString:@"white"]) {
        [[self imageViewForType:type] setBackgroundColor:[UIColor whiteColor] ];
    } else if ([color isEqualToString:@"blue"]) {
        [[self imageViewForType:type] setBackgroundColor:[UIColor blueColor]];
    } else if ([color isEqualToString:@"yellow"]) {
        [[self imageViewForType:type] setBackgroundColor:[UIColor yellowColor]];
    }
}
- (UIImageView *)imageViewForType:(NSString *)type {
    UIImageView *currentImageView;
    if ([type isEqualToString:@"torso"]) {
        currentImageView = self.torsoImageView;
    } else if ([type isEqualToString:@"waist"]) {
        currentImageView = self.beltImageView;
    } else if ([type isEqualToString:@"rightFinger"]) {
        currentImageView = self.rightRingImageView;
    } else if ([type isEqualToString:@"neck"]) {
        currentImageView = self.neckImageView;
    } else if ([type isEqualToString:@"head"]) {
        currentImageView = self.helmImageView;
    } else if ([type isEqualToString:@"feet"]) {
        currentImageView = self.bootsImageView;
    } else if ([type isEqualToString:@"legs"]) {
        currentImageView = self.pantsImageView;
    } else if ([type isEqualToString:@"shoulders"]) {
        currentImageView = self.shoulderImageView;
    } else if ([type isEqualToString:@"leftFinger"]) {
        currentImageView = self.leftRingImageView;
    } else if ([type isEqualToString:@"offHand"]) {
        currentImageView = self.offHandImageView;
    } else if ([type isEqualToString:@"hands"]) {
        currentImageView = self.glovesImageView;
    } else if ([type isEqualToString:@"mainHand"]) {
        currentImageView = self.mainHandImageView;
    } else if ([type isEqualToString:@"bracers"]) {
        currentImageView = self.bracersImageView;
    }
    
    return currentImageView;
}

@end
