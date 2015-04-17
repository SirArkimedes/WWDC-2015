//
//  Item.m
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/16/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "Item.h"

@implementation Item

- (id)initWithImage:(NSString *)image withText:(NSString *)text {
    
    if (self = [super init]) {
        _imageName = image;
        _itemText = text;
    }
    return self;
}

@end
