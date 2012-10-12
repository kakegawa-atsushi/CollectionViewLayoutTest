//
//  TestCollectionViewLayout.h
//  iOSTest3
//
//  Created by 掛川 敦史 on 2012/09/29.
//  Copyright (c) 2012年 掛川 敦史. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCollectionViewLinearLayout : UICollectionViewLayout

@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGSize headerReferenceSize;
@property (nonatomic) CGSize footerReferenceSize;
@property (nonatomic) CGFloat interitemSpacing;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

@end
