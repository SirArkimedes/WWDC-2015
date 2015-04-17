//
//  Item.h
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/16/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *itemText;

- (id)initWithImage:(NSString *)image withText:(NSString *)text;

@end
