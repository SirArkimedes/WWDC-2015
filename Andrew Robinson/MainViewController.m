//
//  MainViewController.m
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/16/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "MainViewController.h"
#import "AboutCell.h"
#import "Item.h"

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageOfSelf;
@property (weak, nonatomic) IBOutlet UILabel *selfText;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *gameContainer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topPosition;

@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Array readiness
    self.items = [[NSMutableArray alloc] init];
    
    // Add items to array - The order of these matter in where the item is placed.
    Item *firstItem = [[Item alloc] initWithImage:@"402-Faceit-SirArkimedesBukkitDev.png" withText:@"About Me"];
    [self.items addObject:firstItem];
    
    Item *secondItem = [[Item alloc] initWithImage:@"GitHub_Logo.png" withText:@"Projects"];
    [self.items addObject:secondItem];
    
    Item *thirdItem = [[Item alloc] initWithImage:@"High School logo.png" withText:@"Education"];
    [self.items addObject:thirdItem];
    
    Item *fourthItem = [[Item alloc] initWithImage:@"GitHub_Logo.png" withText:@"Skills & Interests"];
    [self.items addObject:fourthItem];
    
    Item *fiveItem = [[Item alloc] initWithImage:@"High School logo.png" withText:@"Experience"];
    [self.items addObject:fiveItem];
    
    // Set clear color to collection view for no background.
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    UINib *cellNib = [UINib nibWithNibName:@"AboutCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"aboutCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 150)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumLineSpacing:15.f];
    [flowLayout setMinimumInteritemSpacing:15.f];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // Blur Game
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = self.view.bounds;
    visualEffectView.frame = CGRectMake(0, 0, self.view.bounds.size.width*2, self.view.bounds.size.height*2);
    [self.gameContainer addSubview:visualEffectView];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    CGRect viewFrame = self.collectionView.frame;
    viewFrame.origin.y = -viewFrame.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.collectionView.frame = viewFrame;
    
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"aboutCell";
    
    AboutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Item *grabbedItem = [self.items objectAtIndex:indexPath.row];
    
    cell.cellImage.image = [UIImage imageNamed:grabbedItem.imageName];
    cell.cellText.text = grabbedItem.itemText;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // If you need to use the touched cell, you can retrieve it like so
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    NSLog(@"touched cell %@ at indexPath %@", cell, indexPath);
    
    if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"testId" sender:self];
    }
    
}

#pragma mark - Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toOrientation duration:(NSTimeInterval)duration {
    
    if (toOrientation == UIInterfaceOrientationPortrait ||
        toOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        [[self view] addSubview:self.imageOfSelf];
                
        [self setupConstraintsforPortrait];
        
        
    } else {
        if (toOrientation == UIInterfaceOrientationLandscapeLeft ||
            toOrientation == UIInterfaceOrientationLandscapeRight) {
            
            [self setupConstraintsforLandscaoe];
            
            [self.imageOfSelf removeFromSuperview];
            
        }
    }
}

- (void)setupConstraintsforPortrait {
    
    // Constrain label to image
    [self.view removeConstraint:self.topPosition];
    
    [self.view layoutIfNeeded];
    
    self.topPosition = [NSLayoutConstraint constraintWithItem:self.selfText
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.imageOfSelf
                                                    attribute:NSLayoutAttributeBottom
                                                   multiplier:1.f
                                                     constant:20.f];
    
    [self.view addConstraint:self.topPosition];
    
    // Constrain image to view
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.imageOfSelf
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.f
                                                            constant:30.f];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.imageOfSelf
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.selfText
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.f
                                                                constant:0.f];
    
    [self.view addConstraint:top];
    [self.view addConstraint:centerX];
    
    // Change font size
    self.selfText.font = [UIFont fontWithName:@"AvenirNext-Regular" size:17.f];
    
    [UIView animateWithDuration:1
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
    
    //        self.view animate:^() with duration: completion:^()

}


- (void)setupConstraintsforLandscaoe {
    
    // Begin constraint
    [self.view removeConstraint:self.topPosition];
    
//    [self.view layoutIfNeeded];
    
    
    self.topPosition = [NSLayoutConstraint constraintWithItem:self.selfText
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.view
                                                    attribute:NSLayoutAttributeTop
                                                   multiplier:1.f
                                                     constant:20.f];
    [self.view addConstraint:self.topPosition];
    
    // Change font size
    self.selfText.font = [UIFont fontWithName:@"AvenirNext-Regular" size:25.f];
    
    [UIView animateWithDuration:1
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
    
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
