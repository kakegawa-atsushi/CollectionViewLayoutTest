//
//  TestCollectionViewFooter.m
//  iOSTest3
//
//  Created by 掛川 敦史 on 2012/10/03.
//  Copyright (c) 2012年 掛川 敦史. All rights reserved.
//

#import "TestCollectionViewFooter.h"

@implementation TestCollectionViewFooter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.label];
    }
    return self;
}

@end
