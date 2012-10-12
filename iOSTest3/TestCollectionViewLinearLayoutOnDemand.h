//
//  TestCollectionViewLinearLayoutOnDemand.h
//  CollectionViewLayoutTest
//
//  Created by KAKEGAWA Atsushi on 2012/10/12.
//  Copyright (c) 2012年 掛川 敦史. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCollectionViewLinearLayoutOnDemand : UICollectionViewLayout

@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGSize headerReferenceSize;
@property (nonatomic) CGSize footerReferenceSize;
@property (nonatomic) CGFloat interitemSpacing;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

@end
