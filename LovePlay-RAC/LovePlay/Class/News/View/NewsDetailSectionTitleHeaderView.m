//
//  NewsDetailSectionTitleHeaderView.m
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailSectionTitleHeaderView.h"

@interface NewsDetailSectionTitleHeaderView ()
//UI
@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UILabel *titleTextLabel;
@end

@implementation NewsDetailSectionTitleHeaderView

+ (instancetype)sectionHeaderWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"sectionHeader";
    NewsDetailSectionTitleHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[NewsDetailSectionTitleHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = RGB(235, 235, 235);
        [self addSubnodes];
        [self mas_subViews];
    }
    return self;
}

#pragma mark - private
- (void)addSubnodes
{
    [self.contentView addSubview:self.leftLineView];
    
    [self.contentView addSubview:self.titleTextLabel];
}

- (void)mas_subViews
{
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(3);
        make.top.equalTo(self.contentView).mas_offset(5);
        make.left.top.equalTo(self.contentView).mas_offset(12);
        make.bottom.top.equalTo(self.contentView).mas_offset(-5);
    }];
    
    [self.titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.top.equalTo(self.contentView);
        make.left.equalTo(self.leftLineView.mas_right).mas_offset(8);
    }];
}

#pragma mark - public
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleTextLabel.text = title;
}

#pragma mark - setter / getter
- (UIView *)leftLineView
{
    if (!_leftLineView) {
        UIView *leftLineView = [[UIView alloc] init];
        leftLineView.backgroundColor = RGB(218, 85, 107);
        _leftLineView = leftLineView;
    }
    return _leftLineView;
}

- (UILabel *)titleTextLabel
{
    if (!_titleTextLabel) {
        UILabel *titleTextLabel = [[UILabel alloc] init];
        titleTextLabel.textColor = RGB(155, 155, 155);
        titleTextLabel.font = [UIFont systemFontOfSize:12];
        _titleTextLabel = titleTextLabel;
    }
    return _titleTextLabel;
}
@end
