//
//  TestCollectionViewCell.m
//  iOSTest3
//
//  Created by 掛川 敦史 on 2012/09/25.
//  Copyright (c) 2012年 掛川 敦史. All rights reserved.
//

#import "TestCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TestCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor colorWithWhite:0.97f alpha:1.0f];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor clearColor];
        self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end
