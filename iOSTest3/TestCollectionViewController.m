//
//  TestCollectionViewController.m
//  iOSTest3
//
//  Created by 掛川 敦史 on 2012/09/25.
//  Copyright (c) 2012年 掛川 敦史. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "TestCollectionViewCell.h"
#import "TestCollectionViewLinearLayout.h"
#import "TestCollectionViewLinearLayoutOnDemand.h"
#import "TestCollectionViewHeader.h"
#import "TestCollectionViewFooter.h"

@interface TestCollectionViewController () {
    NSMutableArray *datas;
    UICollectionViewFlowLayout *vFlowLayout;
    UICollectionViewFlowLayout *hFlowLayout;
    TestCollectionViewLinearLayout *vLinearLayout;
    TestCollectionViewLinearLayout *hLinearLayout;
}

@end

@implementation TestCollectionViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        datas = [NSMutableArray array];
        for (int i = 0; i < 2; i++) {
            datas[i] = [NSMutableArray array];
            for (int j = 0; j < 30; j++) {
                datas[i][j] = [NSString stringWithFormat:@"%d", i * 30 + j];
            }
        }
        vFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        vFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        vFlowLayout.itemSize = CGSizeMake(90.0f, 90.0f);
        vFlowLayout.minimumInteritemSpacing = 10.0f;
        vFlowLayout.minimumLineSpacing = 10.0f;
        vFlowLayout.headerReferenceSize = CGSizeMake(0.0f, 30.0f);
        vFlowLayout.footerReferenceSize = CGSizeMake(0.0f, 30.0f);
        vFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        hFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        hFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        hFlowLayout.itemSize = CGSizeMake(90.0f, 90.0f);
        hFlowLayout.minimumInteritemSpacing = 10.0f;
        hFlowLayout.minimumLineSpacing = 10.0f;
        hFlowLayout.headerReferenceSize = CGSizeMake(30.0f, 0.0f);
        hFlowLayout.footerReferenceSize = CGSizeMake(30.0f, 0.0f);
        hFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        vLinearLayout = [[TestCollectionViewLinearLayout alloc] init];
        vLinearLayout.itemSize = CGSizeMake(180.0f, 180.0f);
        vLinearLayout.interitemSpacing = 40.0f;
        vLinearLayout.headerReferenceSize = CGSizeMake(0.0f, 30.0f);
        vLinearLayout.footerReferenceSize = CGSizeMake(0.0f, 30.0f);
        vLinearLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        hLinearLayout = [[TestCollectionViewLinearLayout alloc] init];
        hLinearLayout.itemSize = CGSizeMake(180.0f, 180.0f);
        hLinearLayout.interitemSpacing = 40.0f;
        hLinearLayout.headerReferenceSize = CGSizeMake(30.0f, 0.0f);
        hLinearLayout.footerReferenceSize = CGSizeMake(30.0f, 0.0f);
        hLinearLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[TestCollectionViewCell class]
            forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerClass:[TestCollectionViewHeader class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"Header"];
    [self.collectionView registerClass:[TestCollectionViewFooter class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:@"Footer"];
    [self.collectionView setCollectionViewLayout:vFlowLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [datas[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TestCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                                                forIndexPath:indexPath];
    cell.label.text = datas[indexPath.section][indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *resusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        TestCollectionViewHeader *header = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                   withReuseIdentifier:@"Header"
                                                                                          forIndexPath:indexPath];
        header.label.text = [NSString stringWithFormat:@"%d", indexPath.section];
        resusableView = header;
    } else if (kind == UICollectionElementKindSectionFooter) {
        TestCollectionViewFooter *footer = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                   withReuseIdentifier:@"Footer"
                                                                                          forIndexPath:indexPath];
        footer.label.text = [NSString stringWithFormat:@"%d", indexPath.section];
        resusableView = footer;
    }
    return resusableView;
}

#pragma mark - Handler methods

- (IBAction)buttonDidTouch:(id)sender
{
    if (self.collectionView.collectionViewLayout == vFlowLayout) {
        [self.collectionView setCollectionViewLayout:hFlowLayout animated:YES];
    } else if (self.collectionView.collectionViewLayout == hFlowLayout) {
        [self.collectionView setCollectionViewLayout:vLinearLayout animated:YES];
    } else if (self.collectionView.collectionViewLayout == vLinearLayout) {
        [self.collectionView setCollectionViewLayout:hLinearLayout animated:YES];
    } else {
        [self.collectionView setCollectionViewLayout:vFlowLayout animated:YES];
    }
}

@end
