//
//  XXBCreditView.h
//  XXBFirstPage
//
//  Created by xxb on 15/7/10.
//  Copyright (c) 2015年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XXBCreditViewDelegate <NSObject>
- (void)waveViewDisapper;
@end
@interface XXBCreditView : UIView
@property (nonatomic, strong)UILabel *noReceiveLabel;   // 未领取的信用额度
@property (nonatomic, strong)UILabel *receiveLabel;     // 可用额度
@property (nonatomic, strong)UILabel *usable;     //
@property (nonatomic, assign)NSInteger money; //可用余额数值
@property (nonatomic, assign)id<XXBCreditViewDelegate>delegate;
- (void)contactAppear;
- (void)contactDisappear;
@end
