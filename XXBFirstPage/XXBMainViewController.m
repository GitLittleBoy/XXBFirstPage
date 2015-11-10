//
//  XXBMainViewController.m
//  XXBFirstPage
//
//  Created by xxb on 15/7/10.
//  Copyright (c) 2015年 xxb. All rights reserved.
//

#import "XXBMainViewController.h"
#import "XXBCreditView.h"
#import "XXBMerchantItemView.h"
#import "XXBFunctionView.h"
#import "RecommendView.h"
@interface XXBMainViewController ()<RecommendViewDelegate,XXBCreditViewDelegate, UIScrollViewDelegate>{
    UIScrollView    *_scrolle;
    BOOL _scrolleOffsetY;           // 记录scroll的偏移量
    BOOL isDisappear;
    XXBCreditView  *_availableXXBCreditView;   // 可用额度
    //XXBImgCycPla  *_imgPlayerView;         // 图片滚动视图∑
    XXBMerchantItemView  *_merchantView;          // 商户选择
    XXBFunctionView  *_functionView;          // 附加功能视图
    RecommendView  *_recommendView;         // 推荐视图
}

@end

@implementation XXBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isDisappear = YES; // 只有第一次进入首页会自动消失
    _scrolle = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _scrolle.backgroundColor = [UIColor lightGrayColor];
    _scrolle.showsVerticalScrollIndicator = NO;
    _scrolle.delegate = self;
    //[_scrolle setContentSize:CGSizeMake(kScreen_Width, 900)];
    [self.view addSubview:_scrolle];
    self.title = @"学信宝";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    // Do any additional setup after loading the view.
}
- (void)initView {
    // 1.水流图
    _availableXXBCreditView = [[XXBCreditView alloc] init];
    _availableXXBCreditView.frame = CGRectMake(0, -180, kScreen_Width, 180);
    _availableXXBCreditView.delegate = self;
    [_scrolle addSubview:_availableXXBCreditView];
    
    // 2.分类
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = (CGSize){80, 80};
    _merchantView = [[XXBMerchantItemView alloc] initWithFrame:CGRectMake(0, _availableXXBCreditView.frame.origin.y + 180, kScreen_Width, 180) collectionViewLayout:flowLayout];
    if (kScreen_Width <= 320) {
        flowLayout.itemSize = (CGSize){70, 70};
        _merchantView = [[XXBMerchantItemView alloc] initWithFrame:CGRectMake(0, _availableXXBCreditView.frame.origin.y + 180, kScreen_Width, 170) collectionViewLayout:flowLayout];
    }
    _merchantView.itemArr = [@[@"餐饮", @"酒店", @"休闲娱乐", @"生活服务", @"丽人", @"旅游", @"水果超市", @"爱逛街"] mutableCopy];
    [_scrolle addSubview:_merchantView]
    ;
    
    // 3.功能
    _functionView = [[XXBFunctionView alloc] init];
    _functionView.frame = CGRectMake(0, _merchantView.frame.origin.y + _merchantView.frame.size.height, kScreen_Width, 140);
    [_scrolle addSubview:_functionView];
    
    // 4.推荐
    NSArray *arr1 = @[@"外婆桥", @"新白鹿", @"花田餐厅", @"过桥米线", @"秦晋小吃"];
    NSArray *arr2 = @[@"水果鲜生", @"喜事多", @"便利店", @"生活服务"];
    NSArray *arr3 = @[@"孙家酒店公寓", @"悠家租房", @"小米租房", @"80客栈", @"鸿运宾馆", @"望月旅馆", @"微微租房", @"爱逛酒店"];
    NSMutableArray *arr = [@[arr1, arr2, arr3] mutableCopy];
    _recommendView = [[RecommendView alloc] initWithDataArr:arr];
    _recommendView.frame = CGRectMake(0, _functionView.frame.origin.y + 140, kScreen_Width, _recommendView.tableView.frame.size.height + 30);
    _recommendView.delegate = self;
    [_scrolle addSubview:_recommendView];
    
    // 5
    _scrolle.contentSize = CGSizeMake(kScreen_Width, _merchantView.frame.size.height + _functionView.frame.size.height + _recommendView.frame.size.height);
    _scrolle.contentOffset = CGPointMake(0, -180);
    
    [_availableXXBCreditView contactAppear];
}
// 1s后动画收起 信用额度view
- (void)pageAnimation {
    [UIView animateWithDuration:1.5 animations:^{
        _scrolle.contentOffset = CGPointMake(0, - 64);
        [_availableXXBCreditView contactDisappear];
    } completion:^(BOOL finished) {
        _scrolleOffsetY = YES;
    }];
}
# pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrolle) {
        CGFloat offSetY = _scrolle.contentOffset.y;
        if (offSetY < -170 && _scrolleOffsetY) {
            [_scrolle setContentOffset:CGPointMake(0, -180 - 64) animated:YES];
            [_availableXXBCreditView contactAppear];
            _scrolleOffsetY = NO;
        } else if (offSetY > -244 && offSetY < -64 && !_scrolleOffsetY) {
            [_scrolle setContentOffset:CGPointMake(0, - 64) animated:YES];
            [_availableXXBCreditView contactDisappear];
            _scrolleOffsetY = YES;
        } else if(offSetY < -244){
            [_scrolle setContentOffset:CGPointMake(0, -180 - 64) animated:YES];
        } else if(offSetY < 0 ){
            if (_scrolleOffsetY) {
                [_scrolle setContentOffset:CGPointMake(0, - 64) animated:YES];
            } else {
                [_scrolle setContentOffset:CGPointMake(0, -180 - 64) animated:YES];
            }
        } else {
        }

    }
}
#pragma mark - RecommendViewDelegate
- (void)resetFrame {
    _recommendView.frame = CGRectMake(0, _functionView.frame.origin.y + 140, kScreen_Width, _recommendView.tableView.frame.size.height + 30);;
    _scrolle.contentSize = CGSizeMake(kScreen_Width, _merchantView.frame.size.height + _functionView.frame.size.height + _recommendView.frame.size.height);
}
#pragma mark - XXBCreditViewDelegate 水流动画消失
-(void)waveViewDisapper {
    if (isDisappear) {
        [self performSelector:@selector(pageAnimation) withObject:nil afterDelay:2.0];
    }
    isDisappear = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
