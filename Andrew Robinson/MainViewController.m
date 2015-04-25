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
#import "DetailViewController.h"

#define kAnimation .5f

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *selfText;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *gameContainer;
@property (weak, nonatomic) IBOutlet UIView *projectsContainer;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topPosition;

@property (strong, nonatomic) NSMutableArray *items;

@property BOOL shouldAnimate;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shouldAnimate = YES;
    
    // Hide to prepare for Projects cell tap
    self.projectsContainer.hidden = YES;
    self.backButton.hidden = YES;
    
    // Array readiness
    self.items = [[NSMutableArray alloc] init];
    
    // Add items to array - The order of these matter in where the item is placed.
    Item *secondItem = [[Item alloc] initWithImage:@"deliverycoicon.png" withText:@"Projects"];
    [self.items addObject:secondItem];
    
    Item *firstItem = [[Item alloc] initWithImage:@"Andrew Robinson.png" withText:@"About Me"];
    [self.items addObject:firstItem];
    
    Item *fiveItem = [[Item alloc] initWithImage:@"xcode_hammer.png" withText:@"Experience"];
    [self.items addObject:fiveItem];
    
    Item *thirdItem = [[Item alloc] initWithImage:@"High School logo.png" withText:@"Education"];
    [self.items addObject:thirdItem];
    
    Item *fourthItem = [[Item alloc] initWithImage:@"iPhone6.png" withText:@"Skills & Interests"];
    [self.items addObject:fourthItem];
    
    // Set clear color to collection view for no background.
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    // Collection view
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
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.shouldAnimate) {
        self.selfText.alpha = 0;
        
        CGRect viewFrame = self.collectionView.frame;
        viewFrame.origin.y = -viewFrame.size.height;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kAnimation];
//        [UIView setAnimationDelay:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.collectionView.frame = viewFrame;
        
        self.selfText.alpha = 1;
        
        [UIView commitAnimations];
        
        self.shouldAnimate = NO;
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - unwind

- (void)unwindToList:(UIStoryboardSegue *)segue {
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // If you need to use the touched cell, you can retrieve it like so
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
//    NSLog(@"touched cell %@ at indexPath %@", cell, indexPath);
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *vc = (DetailViewController *)[sb instantiateViewControllerWithIdentifier:@"detailViewController"];
    
    switch (indexPath.row) {
        case 0:
            [self animateHideMainView];
            break;
        case 1:
            vc = [vc setupDetailwithTitle:@"About" withNib:@"About Me Scroll"];
            [self presentViewController:vc animated:YES completion:nil];
            break;
        case 2:
            vc = [vc setupDetailwithTitle:@"Experience" withNib:@"Experience Scroll"];
            [self presentViewController:vc animated:YES completion:nil];
            break;
        case 3:
            vc = [vc setupDetailwithTitle:@"Education" withNib:@"Education Scroll"];
            [self presentViewController:vc animated:YES completion:nil];
            break;
        case 4:
            vc = [vc setupDetailwithTitle:@"Skills & Interests" withNib:@"Skills And Interests Scroll"];
            [self presentViewController:vc animated:YES completion:nil];
            break;
    }
    
}

#pragma mark - Projects methods

- (void)animateHideMainView {
    
//    NSLog(self.backButton.hidden ? @"Yes" : @"No");
//    NSLog(@"Initial: %@", NSStringFromCGRect(self.backButton.frame));
    
    CGRect viewFrame = self.collectionView.frame;
    viewFrame.origin.y = self.view.frame.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimation];
    //        [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    self.collectionView.frame = viewFrame;
    
    self.selfText.alpha = 0;
    
    [UIView commitAnimations];
    
    [self performSelector:@selector(animateShowProjectsView) withObject:nil afterDelay:kAnimation];
    
}

- (void)animateShowProjectsView {
    
    // Hide
    self.collectionView.hidden = YES;
    
    // Unhide
    self.projectsContainer.hidden = NO;
    self.backButton.hidden = NO;
    
    // OG positions
    CGRect ogFrame = self.view.frame;
    CGRect backFrame = self.backButton.frame;
    
    // New positions
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = -viewFrame.size.height;
    self.projectsContainer.frame = viewFrame;
    
    CGRect buttonViewFrame = self.backButton.frame;
    buttonViewFrame.origin.y = -buttonViewFrame.size.height;
    self.backButton.frame = buttonViewFrame;
    
    // Animate
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimation];
    //        [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.projectsContainer.frame = ogFrame;
    self.backButton.frame = backFrame;

    [UIView commitAnimations];
    
}

// BACK BUTTON TAP
- (IBAction)backTapped:(id)sender {
    
    // New positions
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = -viewFrame.size.height;
    
    CGRect buttonViewFrame = self.backButton.frame;
    buttonViewFrame.origin.y = -buttonViewFrame.size.height;
    
    // Animate
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimation];
    //        [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    self.projectsContainer.frame = viewFrame;
    self.backButton.frame = buttonViewFrame;
    
    [UIView commitAnimations];
    
    [self performSelector:@selector(originalMainView) withObject:nil afterDelay:.5];
    
}

- (void)originalMainView {
    
    self.collectionView.hidden = NO;
    
    self.backButton.hidden = YES;
    self.projectsContainer.hidden = YES;
    
//    NSLog(@"End: %@", NSStringFromCGRect(self.backButton.frame));
    
    //
    self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x,
                                           self.view.frame.size.height,
                                           self.collectionView.frame.size.width,
                                           self.collectionView.frame.size.height);
    
    // Put button back to og position
    self.backButton.frame = CGRectMake(16, 26, 50, 30);
    
    CGRect viewFrame = self.collectionView.frame;
    viewFrame.origin.y = self.view.frame.size.height - self.collectionView.frame.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimation];
    //        [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.collectionView.frame = viewFrame;
    
    self.selfText.alpha = 1;
    
    [UIView commitAnimations];
    
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
