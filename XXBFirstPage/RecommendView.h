//
//  RecommendView.h
//  XXBFirstPage
//
//  Created by xxb on 15/7/10.
//  Copyright (c) 2015年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecommendViewDelegate <NSObject>
- (void)resetFrame;
@end
@interface RecommendView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UIButton *firstBtn;
@property (nonatomic, strong)UIButton *secondBtn;
@property (nonatomic, strong)UIButton *thirdBtn;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, assign)NSInteger flag;
@property (nonatomic, assign)id<RecommendViewDelegate>delegate;
- (instancetype)initWithDataArr:(NSMutableArray *)dataArr;
@end
