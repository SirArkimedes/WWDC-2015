//
//  AboutCell.m
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/16/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "AboutCell.h"

@implementation AboutCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"AboutCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    return self;
    
}

- (void)awakeFromNib {
    
    // Clear background
    self.backgroundColor = [UIColor clearColor];
    
//    // Circle it
//    self.layer.borderColor = [[UIColor grayColor] CGColor];
//    self.layer.borderWidth = 2;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.masksToBounds = YES;
    
    self.cellImage.layer.cornerRadius = self.frame.size.width/2 - 5;
    self.cellImage.layer.masksToBounds = YES;
    
    //only apply the blur if the user hasn't disabled transparency effects
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.cellImage.bounds;
        [self.cellImage addSubview:blurEffectView];
    } else {
        self.cellImage.backgroundColor = [UIColor blackColor];
    }
    
}

@end
