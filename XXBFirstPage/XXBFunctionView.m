//
//  XXBFunctionView.m
//  
//
//  Created by xxb on 15/7/10.
//
//

#import "XXBFunctionView.h"

@implementation XXBFunctionView
- (instancetype)init
{
    self = [super init];
    if (self) {
        _firstImg = [[UIImageView alloc] init];
        _firstImg.image = [UIImage imageNamed:@"1"];
        _firstImg.frame = CGRectMake(0, 0, kScreen_Width / 2, 70);
        _firstImg.userInteractionEnabled = YES;
        [_firstImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstAction:)]];
        [self addSubview:_firstImg];
        
        _secondImg = [[UIImageView alloc] init];
        _secondImg.image = [UIImage imageNamed:@"2"];
        _secondImg.frame = CGRectMake(kScreen_Width / 2, 0, kScreen_Width / 2, 70);
        _secondImg.userInteractionEnabled = YES;
        [_secondImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondAction)]];
        [self addSubview:_secondImg];
        
        _thirdImg = [[UIImageView alloc] init];
        _thirdImg.image = [UIImage imageNamed:@"3"];
        _thirdImg.frame = CGRectMake(0, 70, kScreen_Width, 70);
        _thirdImg.userInteractionEnabled = YES;
        [_thirdImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdAction)]];
        [self addSubview:_thirdImg];
        
    }
    return self;
}
- (void)firstAction:(UIGestureRecognizer *)sender {
    NSLog(@"第一个功能界面");
}
- (void)secondAction {
    NSLog(@"第二个功能界面");
}
- (void)thirdAction {
    NSLog(@"第三个功能界面");
}

@end
