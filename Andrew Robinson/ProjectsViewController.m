//
//  ProjectsViewController.m
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/22/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "ProjectsViewController.h"
#import "AboutCell.h"
#import "Item.h"
#import "DetailViewController.h"

@interface ProjectsViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *projectItems;

@end

@implementation ProjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    // Array readiness
    self.projectItems = [[NSMutableArray alloc] init];
    
    // Add items to array - The order of these matter in where the item is placed.
    Item *firstItem = [[Item alloc] initWithImage:@"deliverycoicon.png" withText:@"Delivery Co."];
    [self.projectItems addObject:firstItem];
    
    Item *secondItem = [[Item alloc] initWithImage:@"blankicon.png" withText:@"SkillsUSA Meetings"];
    [self.projectItems addObject:secondItem];
    
    Item *thirdItem = [[Item alloc] initWithImage:@"gpacal.png" withText:@"GPA Cal"];
    [self.projectItems addObject:thirdItem];
    
//    Item *fourthItem = [[Item alloc] initWithImage:@"deliverycoicon.png" withText:@"andrewrobinson.org"];
//    [self.projectItems addObject:fourthItem];
    
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
    return [self.projectItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"aboutCell";
    
    AboutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    Item *grabbedItem = [self.projectItems objectAtIndex:indexPath.row];
    
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
            vc = [vc setupDetailwithTitle:@"Delivery Co." withNib:@"Delivery Co Detail"];
            break;
        case 1:
            vc = [vc setupDetailwithTitle:@"SkillsUSA Meetings" withNib:@"SkillsUSA Meetings Detail"];
            break;
        case 2:
            vc = [vc setupDetailwithTitle:@"GPA Cal" withNib:@"Delivery Co Detail"];
            break;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
    
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
