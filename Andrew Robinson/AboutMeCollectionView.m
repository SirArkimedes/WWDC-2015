//
//  AboutMeCollectionView.m
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/16/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "AboutMeCollectionView.h"

@implementation AboutMeCollectionView

- (void)viewDidLoad {
    
    UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    [self registerNib:AboutCell forCellWithReuseIdentifier:@"cvCell"];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
