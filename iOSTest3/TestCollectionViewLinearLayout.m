//
//  TestCollectionViewLayout.m
//  iOSTest3
//
//  Created by 掛川 敦史 on 2012/09/29.
//  Copyright (c) 2012年 掛川 敦史. All rights reserved.
//

#import "TestCollectionViewLinearLayout.h"

@interface TestCollectionViewLinearLayout () {
    NSMutableArray *sectionElements;
    NSMutableArray *headerElements;
    NSMutableArray *footerElements;
    CGFloat contentSize;
}

@end

@implementation TestCollectionViewLinearLayout

- (id)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        sectionElements = [NSMutableArray array];
        headerElements = [NSMutableArray array];
        footerElements = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc
{
    [sectionElements removeAllObjects];
    sectionElements = nil;
    [headerElements removeAllObjects];
    headerElements = nil;
    [footerElements removeAllObjects];
    footerElements = nil;
}

#pragma mark UICollectionViewLayout overriden methods

- (void)prepareLayout
{
    [sectionElements removeAllObjects];
    [headerElements removeAllObjects];
    [footerElements removeAllObjects];
    
    BOOL isVertical = self.scrollDirection == UICollectionViewScrollDirectionVertical;
    BOOL hasHeader = (isVertical && self.headerReferenceSize.height > 0) || (!isVertical && self.headerReferenceSize.width > 0);
    BOOL hasFooter = (isVertical && self.footerReferenceSize.height > 0) || (!isVertical && self.footerReferenceSize.width > 0);
    CGFloat interitemSpacing = self.interitemSpacing;
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    CGFloat collectionViewHeight = self.collectionView.bounds.size.height;
    CGFloat itemWidth = self.itemSize.width;
    CGFloat itemHeight = self.itemSize.height;
    CGFloat currentPosition = 0.0f;
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int sectionNumber = 0; sectionNumber < sectionCount; sectionNumber++) {
        if (hasHeader) {
            UICollectionViewLayoutAttributes *headerAttr =
                [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                               withIndexPath:[NSIndexPath indexPathForItem:0 inSection:sectionNumber]];
            if (isVertical) {
                headerAttr.frame = CGRectMake(0.0f, currentPosition, collectionViewHeight, self.headerReferenceSize.height);
                currentPosition += self.headerReferenceSize.height + interitemSpacing;
            } else {
                headerAttr.frame = CGRectMake(currentPosition, 0.0f, self.headerReferenceSize.width, collectionViewHeight);
                currentPosition += self.headerReferenceSize.width + interitemSpacing;
            }
            
            [headerElements addObject:headerAttr];
        }
        
        int itemCount = [self.collectionView numberOfItemsInSection:sectionNumber];
        NSMutableArray *elements = [NSMutableArray array];
        for (int itemNumber = 0; itemNumber < itemCount; itemNumber++) {
            UICollectionViewLayoutAttributes *attr =
                [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:itemNumber inSection:sectionNumber]];
            
            if (isVertical) {
                attr.center = CGPointMake(collectionViewWidth * 0.5, currentPosition + itemHeight * 0.5);
                currentPosition += itemHeight;
            } else {
                attr.center = CGPointMake(currentPosition + itemWidth * 0.5, collectionViewHeight * 0.5);
                currentPosition += itemWidth;
            }
            attr.size = CGSizeMake(itemWidth, itemHeight);
            
            if (itemNumber != itemCount - 1) {
                currentPosition += interitemSpacing;
            }
            [elements addObject:attr];
        }
        [sectionElements addObject:elements];

        if (hasFooter) {
            UICollectionViewLayoutAttributes *footerAttr =
            [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                           withIndexPath:[NSIndexPath indexPathForItem:0 inSection:sectionNumber]];
            if (isVertical) {
                footerAttr.frame = CGRectMake(0.0f, currentPosition + interitemSpacing, collectionViewHeight, self.footerReferenceSize.height);
                currentPosition += self.footerReferenceSize.height + interitemSpacing;
            } else {
                footerAttr.frame = CGRectMake(currentPosition + interitemSpacing, 0.0f, self.footerReferenceSize.width, collectionViewHeight);
                currentPosition += self.footerReferenceSize.width + interitemSpacing;
            }
            
            [footerElements addObject:footerAttr];
        }
    }

    contentSize = currentPosition;
}

- (CGSize)collectionViewContentSize
{
    CGSize size;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        size = CGSizeMake(self.collectionView.bounds.size.width, contentSize);
    } else {
        size = CGSizeMake(contentSize, self.collectionView.bounds.size.height);
    }
    
    return size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    BOOL isVertical = self.scrollDirection == UICollectionViewScrollDirectionVertical;
    BOOL hasHeader = (isVertical && self.headerReferenceSize.height > 0) || (!isVertical && self.headerReferenceSize.width > 0);
    BOOL hasFooter = (isVertical && self.footerReferenceSize.height > 0) || (!isVertical && self.footerReferenceSize.width > 0);

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
        
        if (hasHeader) {
            UICollectionViewLayoutAttributes *headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                      atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
            if (CGRectIntersectsRect(rect, headerAttributes.frame)) {
                [attributesArray addObject:headerAttributes];
            }
        }
        
        if (hasFooter) {
            UICollectionViewLayoutAttributes *footerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                                      atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
            if (CGRectIntersectsRect(rect, footerAttributes.frame)) {
                [attributesArray addObject:footerAttributes];
            }
        }
    }
    
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{ 
    return sectionElements[indexPath.section][indexPath.item];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind
                                                                     atIndexPath:(NSIndexPath *)indexPath
{   
    UICollectionViewLayoutAttributes *attr = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        attr = headerElements[indexPath.section];
    } else {
        attr = footerElements[indexPath.section];
    }
    
    return attr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

@end
