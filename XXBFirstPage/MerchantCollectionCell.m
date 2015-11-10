//
//  MerchantCollectionCell.m
//  XXBFirstPage
//
//  Created by xxb on 15/7/10.
//  Copyright (c) 2015年 xxb. All rights reserved.
//

#import "MerchantCollectionCell.h"

@implementation MerchantCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _imgView.center = CGPointMake(self.frame.size.width / 2, 30);
        _imgView.image = [UIImage imageNamed:@"QQ.jpg"];
        _imgView.layer.cornerRadius = 20;
        [self addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, self.frame.size.width, 20)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
    }
    return self;
}
@end
