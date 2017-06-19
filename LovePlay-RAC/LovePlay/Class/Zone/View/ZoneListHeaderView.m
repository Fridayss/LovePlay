//
//  ZoneListHeaderView.m
//  LovePlay
//
//  Created by Yuns on 2017/2/2.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "ZoneListHeaderView.h"

@interface ZoneListHeaderView ()
@property (nonatomic, strong) UILabel *titleTextLabel;
@end

@implementation ZoneListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubnodes];
        [self mas_subViews];
    }
    return self;
}

#pragma mark - private
- (void)addSubnodes
{
    [self addSubview:self.titleTextLabel];
}

- (void)mas_subViews
{
    [_titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 8, 0, 8));
    }];
}

#pragma mark - public
- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    _titleTextLabel.text = titleName;
}

#pragma mark - setter / getter
- (UILabel *)titleTextLabel
{
    if (!_titleTextLabel) {
        UILabel *titleTextLabel = [[UILabel alloc] init];
        titleTextLabel.font = [UIFont systemFontOfSize:14];
        titleTextLabel.textColor = RGB(36, 36, 36);
        _titleTextLabel = titleTextLabel;
    }
    return _titleTextLabel;
}

@end
