//
//  NewsDetailSectionTitleHeaderView.m
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailSectionTitleHeaderView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

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
    }
    return self;
}

- (void)addSubnodes
{
    ASDisplayNode *leftLineNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        UIView *leftLineView = [[UIView alloc] init];
        leftLineView.backgroundColor = RGB(218, 85, 107);
        _leftLineView = leftLineView;
        return leftLineView;
    }];
    [self.contentView addSubnode:leftLineNode];
    
    ASDisplayNode *titleTextNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        UILabel *titleTextLabel = [[UILabel alloc] init];
        titleTextLabel.backgroundColor = RGB(155, 155, 155);
        titleTextLabel.backgroundColor = [UIColor clearColor];
        titleTextLabel.font = [UIFont systemFontOfSize:12];
        _titleTextLabel = titleTextLabel;
        return titleTextLabel;
    }];
    [self.contentView addSubnode:titleTextNode];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleTextLabel.text = title;
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat edging = 6;
    _leftLineView.frame = CGRectMake(12, edging, 3, CGRectGetHeight(self.frame)-2*edging);
    _titleTextLabel.frame = CGRectMake(CGRectGetMaxX(_leftLineView.frame)+ 8, 0, 200, CGRectGetHeight(self.frame));
}

@end
