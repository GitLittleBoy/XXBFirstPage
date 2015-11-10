//
//  XXBXXBCreditView.m
//  XXBFirstPage
//
//  Created by xxb on 15/7/10.
//  Copyright (c) 2015年 xxb. All rights reserved.
//

#import "XXBCreditView.h"

@implementation XXBCreditView{
    UIView *_contactView;
    UIImageView *_balanceView;
    CGFloat _progress;
    NSTimer *_timer;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
        self.money = 400;
    }
    return self;
}
- (void)initView {
    
    // 背景图片
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 180)];
    backView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:backView];
    
    // 未领取额度
    self.noReceiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    self.noReceiveLabel.backgroundColor = [UIColor darkGrayColor];
    self.noReceiveLabel.text = [NSString stringWithFormat:@"您还有%d信用额度尚未领取，点击领取", 600];
    self.noReceiveLabel.textAlignment = NSTextAlignmentCenter;
    self.noReceiveLabel.textColor = [UIColor whiteColor];
    self.noReceiveLabel.font = [UIFont systemFontOfSize:12];
    [self.noReceiveLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(receiveMoney)]];
    [self addSubview:self.noReceiveLabel];
    
    _contactView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, kScreen_Width, 105)];
    [self addSubview:_contactView];
    
    // view2背景
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, kScreen_Width, 88)];
    label1.backgroundColor = HexColor(0x00a276);
    [_contactView addSubview:label1];
    
    // view2
    UIImageView *view2 = [[UIImageView alloc] initWithFrame:CGRectMake(-kScreen_Width, 0, kScreen_Width * 2, 17)];
    view2.image = [UIImage imageNamed:@"wave2"];
    [view2.layer addAnimation:[self moveX:1.5 X:[NSNumber numberWithFloat:kScreen_Width]] forKey:nil];
    [_contactView addSubview:view2];
    
    // view1背景
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, kScreen_Width, 68)];
    label.backgroundColor = HexColor(0x1abc90);
    [_contactView addSubview:label];
    
    // view1
    UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMake(-kScreen_Width, 20, kScreen_Width * 2, 17)];
    view1.image = [UIImage imageNamed:@"wave1"];
    [view1.layer addAnimation:[self moveX:1.5 X:[NSNumber numberWithFloat:kScreen_Width]] forKey:nil];
    [_contactView addSubview:view1];
    
    // 圆
    _balanceView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    //_balanceView.backgroundColor = [UIColor whiteColor];
    _balanceView.image = [UIImage imageNamed:@"fb_rotation"];
    _balanceView.center = CGPointMake(kScreen_Width / 2.0, 255);
    _balanceView.layer.cornerRadius = 75;
    _balanceView.alpha = 0.3;
    [_balanceView.layer addAnimation:[self transformAnimation] forKey:nil];
    [self addSubview:_balanceView];
    
    // 可用余额
    self.receiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.receiveLabel.text = [NSString stringWithFormat:@"%d", 0];
    self.receiveLabel.textAlignment = NSTextAlignmentCenter;
    self.receiveLabel.font = [UIFont systemFontOfSize:45];
    self.receiveLabel.textColor = [UIColor whiteColor];
    self.receiveLabel.center = CGPointMake(kScreen_Width / 2, 205);
    self.receiveLabel.alpha = 0.6;
    [self addSubview:self.receiveLabel];
    self.usable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width / 2, 30)];
    self.usable.text = @"可用余额";
    self.usable.textAlignment = NSTextAlignmentCenter;
    self.usable.font = [UIFont systemFontOfSize:17];
    self.usable.textColor = [UIColor whiteColor];
    self.usable.center = CGPointMake(kScreen_Width / 2, 235);
    self.usable.alpha = 0.6;
    [self addSubview:self.usable];
}
// 流水动画
- (void)contactAppear {
    [UIView animateWithDuration:1 animations:^{
        _balanceView.center = CGPointMake(kScreen_Width / 2.0, 100);
        _contactView.frame = CGRectMake(0, 75, kScreen_Width, 105);
        self.receiveLabel.text = @"0";
    } completion:^(BOOL finished) {
        self.receiveLabel.center = CGPointMake(kScreen_Width / 2, 95);
        self.usable.center = CGPointMake(kScreen_Width / 2, 135);
        [self usableMoneyIncre];// 金钱增加
    }];
}
- (void)contactDisappear {
    [UIView animateWithDuration:1 animations:^{
        _balanceView.center = CGPointMake(kScreen_Width / 2.0, 255);
        _contactView.frame = CGRectMake(0, 180, kScreen_Width, 105);
        self.receiveLabel.center = CGPointMake(kScreen_Width / 2, 205);
        self.usable.center = CGPointMake(kScreen_Width / 2, 235);
    } completion:^(BOOL finished) {
        [_timer invalidate];
    }];
}
#pragma mark ======纵向、旋转移动===========
-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];///.y的话就向下移动。
    animation.toValue = x;
    animation.duration = time;
    animation.removedOnCompletion = NO;//yes的话，又返回原位置了。
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}
- (CABasicAnimation *)transformAnimation {
    CABasicAnimation * transformRoate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    transformRoate.byValue = [NSNumber numberWithDouble:(2 * M_PI)];
    transformRoate.duration = 2;
    transformRoate.repeatCount = MAXFLOAT;
    return transformRoate;
}
#pragma mark ====点击领取信用额度
- (void)receiveMoney {

}
// 可用余额增长
-  (void)usableMoneyIncre {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(incress) userInfo:nil repeats:YES];
}
- (void)incress {
    if ([self.receiveLabel.text integerValue] != self.money) {
        self.receiveLabel.text = [NSString stringWithFormat:@"%ld", [self.receiveLabel.text integerValue] + 1];
    } else {
        [_timer invalidate];
        [self.delegate waveViewDisapper];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
