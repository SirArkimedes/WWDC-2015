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

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
