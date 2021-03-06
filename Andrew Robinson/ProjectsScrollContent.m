//
//  ProjectsScrollContent.m
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/24/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "ProjectsScrollContent.h"

@interface ProjectsScrollContent ()

@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (weak, nonatomic) IBOutlet UIView *videoViewSkills;

@property (weak, nonatomic) IBOutlet UIView *videoViewDelivery;

@end

@implementation ProjectsScrollContent

- (void)didMoveToSuperview {
    
    if (self.videoView) {
        [self performSelector:@selector(movieViewWithPath:) withObject:@"GPA Cal Video" afterDelay:.5];
    } else if (self.videoViewSkills) {
        [self performSelector:@selector(movieViewWithPath:) withObject:@"SillsUSA Meetings Video" afterDelay:.5];
    } else if (self.videoViewDelivery) {
        [self performSelector:@selector(movieViewWithPath:) withObject:@"Delivery Co Video" afterDelay:.5];
    }
    
}

#pragma mark - Buttons

- (IBAction)playGPACal:(id)sender {
    
    [self movieViewWithPath:@"GPA Cal Video"];
    
}

- (IBAction)playSkillsUSA:(id)sender {
    
    [self movieViewWithPath:@"SillsUSA Meetings Video"];
    
}

- (IBAction)playDelivery:(id)sender {
    
    [self movieViewWithPath:@"Delivery Co Video"];
    
}

- (IBAction)GPACalAppStore:(id)sender {
    
    NSString *model = [[UIDevice currentDevice] model];
    if ([model isEqualToString:@"iPhone Simulator"]) {
        NSLog(@"iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/gpa-cal/id873434927?mt=8"]];
    }
    
}

- (IBAction)GPACalGithub:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/SirArkimedes/GPACal"]];
    
}

- (IBAction)githubSkillsUSA:(id)sender {
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/SirArkimedes/SkillsUSA"]];
}

- (IBAction)githubDelivery:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/CTC-CompTech/delivery"]];
    
}

#pragma mark - Videos

- (void)movieViewWithPath:(NSString*)path {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:path ofType:@"mov"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    
    self.videoController = [[MPMoviePlayerController alloc] init];
    
    [self.videoController setContentURL:movieURL];
    
    if (self.videoViewSkills) {
        [self.videoController.view setFrame:self.videoViewSkills.frame];
    } else if (self.videoView) {
        [self.videoController.view setFrame:self.videoView.frame];
    } else if (self.videoViewDelivery) {
        [self.videoController.view setFrame:self.videoViewDelivery.frame];
    }
    
    [self addSubview:self.videoController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(videoPlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.videoController];
    
    [self.videoController play];
    
}

- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // Stop the video player and remove it from view
    [self.videoController stop];
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
