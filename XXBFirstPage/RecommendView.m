//
//  RecommendView.m
//  XXBFirstPage
//
//  Created by xxb on 15/7/10.
//  Copyright (c) 2015年 xxb. All rights reserved.
//

#import "RecommendView.h"

@implementation RecommendView
- (instancetype)initWithDataArr:(NSMutableArray *)dataArr
{
    self = [super init];
    if (self) {
        self.flag = 0;
        self.dataArr = dataArr;
        _firstBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _firstBtn.frame = CGRectMake(0, 0, kScreen_Width / 3, 30);
        _firstBtn.tag = 100;
        [_firstBtn setTitle:@"最好玩" forState:UIControlStateNormal];
        [_firstBtn addTarget:self action:@selector(tableReloadData:) forControlEvents:UIControlEventTouchUpInside];
        [_firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_firstBtn];
        
        _secondBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _secondBtn.frame = CGRectMake(kScreen_Width / 3, 0, kScreen_Width / 3, 30);
        _secondBtn.tag = 101;
        [_secondBtn setTitle:@"最实惠" forState:UIControlStateNormal];
        [_secondBtn addTarget:self action:@selector(tableReloadData:) forControlEvents:UIControlEventTouchUpInside];
        [_secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_secondBtn];
        
        _thirdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _thirdBtn.frame = CGRectMake(kScreen_Width / 3 * 2, 0, kScreen_Width / 3, 30);
        _thirdBtn.tag = 102;
        [_thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_thirdBtn setTitle:@"最逼格" forState:UIControlStateNormal];
        [_thirdBtn addTarget:self action:@selector(tableReloadData:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_thirdBtn];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreen_Width, ((NSArray *)self.dataArr[self.flag]).count * 80)];
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return self;
}
- (void)tableReloadData:(UIButton *)sender {
    self.flag = sender.tag - 100;
    NSInteger height = ((NSArray *)self.dataArr[self.flag]).count * 80;
    _tableView.frame = CGRectMake(0, 30, kScreen_Width, height);
    if ([self.delegate respondsToSelector:@selector(resetFrame)]) {
        [self.delegate resetFrame];
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.dataArr[self.flag]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.dataArr[self.flag][indexPath.row];
    return cell;
}
#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
@end
