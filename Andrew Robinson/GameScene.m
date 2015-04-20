//
//  GameScene.m
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/19/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

@property (strong, nonatomic) NSMutableArray *circles;

@end

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    NSLog(@"Loaded.");
}

#pragma mark - Update

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
}

@end
