//
//  DetailViewController.m
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/20/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIScrollView *content = [[[NSBundle mainBundle] loadNibNamed:@"Education Scroll" owner:self options:nil] objectAtIndex:0];
    content.frame = CGRectMake(0, 0, self.view.frame.size.width - 32, content.frame.size.height);
    content.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:content];
    self.scrollView.contentSize = content.frame.size;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
