//
//  DetailScrollContent.m
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/26/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "DetailScrollContent.h"

@interface DetailScrollContent ()

@property (weak, nonatomic) IBOutlet UIImageView *imageOfSelf;

@end

@implementation DetailScrollContent

- (void)awakeFromNib {
    
    self.imageOfSelf.layer.cornerRadius = self.imageOfSelf.frame.size.width / 2;
    self.imageOfSelf.clipsToBounds = YES;
    
    self.imageOfSelf.layer.borderWidth = 3.0f;
    self.imageOfSelf.layer.borderColor = [UIColor whiteColor].CGColor;
    
}

#pragma mark - Buttons

- (IBAction)github:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/SirArkimedes"]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
