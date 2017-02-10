//
//  NewsDetailSectionTitleHeaderView.m
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailSectionTitleHeaderView.h"

@interface NewsDetailSectionTitleHeaderView ()
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
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    UIView *leftLineView = [[UIView alloc] init];
    leftLineView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:leftLineView];
    _leftLineView = leftLineView;
    
    UILabel *titleTextLabel = [[UILabel alloc] init];
    titleTextLabel.backgroundColor = [UIColor lightGrayColor];
    titleTextLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:titleTextLabel];
    _titleTextLabel = titleTextLabel;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleTextLabel.text = title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat edging = 6;
    _leftLineView.frame = CGRectMake(12, edging, 3, CGRectGetHeight(self.frame)-2*edging);
    _titleTextLabel.frame = CGRectMake(CGRectGetMaxX(_leftLineView.frame)+ 8, 0, 200, CGRectGetHeight(self.frame));
}

@end
