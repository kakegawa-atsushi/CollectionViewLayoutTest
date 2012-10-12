//
//  TestCollectionViewCell2.m
//  iOSTest3
//
//  Created by 掛川 敦史 on 2012/10/03.
//  Copyright (c) 2012年 掛川 敦史. All rights reserved.
//

#import "TestCollectionViewCell2.h"

@implementation TestCollectionViewCell2

- (void)setLabel:(NSString *)label
{
    _label = label;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] set];
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize size = [self.label sizeWithFont:font];
    CGRect labelRect = CGRectMake((rect.size.width - size.width) / 2, (rect.size.height - size.height) / 2, size.width, size.height);
    [self.label drawInRect:labelRect withFont:font];
}

@end
