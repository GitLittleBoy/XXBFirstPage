//
//  XXBMerchantItemView.h
//  XXBFirstPage
//
//  Created by xxb on 15/7/10.
//  Copyright (c) 2015年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXBMerchantItemView : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)NSMutableArray *itemArr;

@end