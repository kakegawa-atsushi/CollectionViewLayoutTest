//
//  TestCollectionViewController.h
//  iOSTest3
//
//  Created by 掛川 敦史 on 2012/09/25.
//  Copyright (c) 2012年 掛川 敦史. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
- (IBAction)buttonDidTouch:(id)sender;

@end
