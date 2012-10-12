//
//  TestCollectionViewLinearLayoutOnDemand.m
//  CollectionViewLayoutTest
//
//  Created by KAKEGAWA Atsushi on 2012/10/12.
//  Copyright (c) 2012年 掛川 敦史. All rights reserved.
//

#import "TestCollectionViewLinearLayoutOnDemand.h"

@implementation TestCollectionViewLinearLayoutOnDemand

- (id)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

#pragma mark UICollectionViewLayout overriden methods

- (CGSize)collectionViewContentSize
{
    CGSize size;
    CGFloat contentWidth = 0.0f;
    CGFloat contentHeight = 0.0f;
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSInteger section = 0;
    while (section < sectionCount) {
        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            contentHeight += [self heightForSection:section];
        } else {
            contentWidth += [self widthForSection:section];
        }
        section++;
    }

    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        contentWidth = self.collectionView.frame.size.width;
    } else {
        contentHeight = self.collectionView.frame.size.height;
    }

    size = CGSizeMake(contentWidth, contentHeight);
    
    return size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributesArray = [NSMutableArray array];
    int sectionCount = self.collectionView.numberOfSections;
    for (int i = 0; i < sectionCount; i++) {
        int itemCount = [self.collectionView numberOfItemsInSection:i];
        for (int j= 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [attributesArray addObject:attributes];
            }
        }
        UICollectionViewLayoutAttributes *headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                  atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
        if (CGRectIntersectsRect(rect, headerAttributes.frame)) {
            [attributesArray addObject:headerAttributes];
        }
        UICollectionViewLayoutAttributes *footerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                                  atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
        if (CGRectIntersectsRect(rect, footerAttributes.frame)) {
            [attributesArray addObject:footerAttributes];
        }
    }
    
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.size = self.itemSize;
    attr.center = [self centerPointOfItemAtIndexPath:indexPath];
    return attr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind
                                                                     atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind
                                                                                                            withIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionHeader) {
        attr.size = self.headerReferenceSize;
        CGPoint headerPoint = [self pointOfHeaderInSection:indexPath.section];
        CGFloat width = 0.0f;
        CGFloat height = 0.0f;
        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            width = self.collectionView.frame.size.width;
            height = self.headerReferenceSize.height;
        } else {
            width = self.headerReferenceSize.width;
            height = self.collectionView.frame.size.height;
        }
        attr.frame = CGRectMake(headerPoint.x, headerPoint.y, width, height);
    } else if (kind == UICollectionElementKindSectionFooter) {
        attr.size = self.footerReferenceSize;
        CGPoint footerPoint = [self pointOfFooterInSection:indexPath.section];
        CGFloat width = 0.0f;
        CGFloat height = 0.0f;
        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            width = self.collectionView.frame.size.width;
            height = self.footerReferenceSize.height;
        } else {
            width = self.footerReferenceSize.width;
            height = self.collectionView.frame.size.height;
        }
        attr.frame = CGRectMake(footerPoint.x, footerPoint.y, width, height);
    }
    
    return attr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

#pragma mark - Private methods

- (CGFloat)widthForSection:(NSInteger)section
{
    CGFloat width = 0.0f;
    
    CGFloat itemsCount = [self.collectionView numberOfItemsInSection:section];
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        width = self.itemSize.width + self.interitemSpacing * 2;
    } else {
        width = (self.itemSize.width + self.interitemSpacing) * itemsCount - self.interitemSpacing;
        if (self.headerReferenceSize.width > 0) {
            width += self.headerReferenceSize.width + self.interitemSpacing;
        }
        if (self.footerReferenceSize.width > 0) {
            width += self.footerReferenceSize.width + self.interitemSpacing;
        }
    }
    return width;
}


- (CGFloat)heightForSection:(NSInteger)section
{
    CGFloat height = 0.0f;
    
    CGFloat itemsCount = [self.collectionView numberOfItemsInSection:section];
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        height = (self.itemSize.height + self.interitemSpacing) * itemsCount - self.interitemSpacing;
        if (self.headerReferenceSize.height > 0) {
            height += self.headerReferenceSize.height + self.interitemSpacing;
        }
        if (self.footerReferenceSize.height > 0) {
            height += self.footerReferenceSize.height + self.interitemSpacing;
        }
    } else {
        height = self.itemSize.height + self.interitemSpacing * 2;
    }
    return height;
}

- (CGPoint)centerPointOfItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat centerX = 0.0f;
    CGFloat centerY = 0.0f;
    
    NSInteger section = indexPath.section;
    NSInteger count = 0;
    while (count < section) {
        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            centerY += [self heightForSection:count];
        } else {
            centerX += [self widthForSection:count];
        }
        count++;
    }
    
    NSInteger itemsCount = indexPath.row;
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        centerX = CGRectGetMidX(self.collectionView.frame);
        centerY += (self.itemSize.height + self.interitemSpacing) * itemsCount + self.itemSize.height / 2 + self.headerReferenceSize.height + self.interitemSpacing;
    } else {
        centerX += (self.itemSize.width + self.interitemSpacing) * itemsCount + self.itemSize.width / 2 + self.headerReferenceSize.width + self.interitemSpacing;
        centerY = CGRectGetMidY(self.collectionView.frame);
    }
    
    return CGPointMake(centerX, centerY);
}

- (CGPoint)pointOfHeaderInSection:(NSInteger)section
{
    CGFloat headerX = 0.0f;
    CGFloat headerY = 0.0f;
    
    NSInteger count = 0;
    while (count < section) {
        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            headerY += [self heightForSection:count];
        } else {
            headerX += [self widthForSection:count];
        }
        count++;
    }
    
    return CGPointMake(headerX, headerY);
}

- (CGPoint)pointOfFooterInSection:(NSInteger)section
{
    CGFloat footerX = 0.0f;
    CGFloat footerY = 0.0f;
    
    NSInteger count = 0;
    while (count <= section) {
        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            footerY += [self heightForSection:count];
            if (count == section) {
                footerY -= self.footerReferenceSize.height;
            }
        } else {
            footerX += [self widthForSection:count];
            if (count == section) {
                footerX -= self.footerReferenceSize.width;
            }
        }
        count++;
    }
    
    return CGPointMake(footerX, footerY);
}

@end
