//
//  NewsDetailSectionCommentFooterView.m
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailSectionCommentFooterView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface NewsDetailSectionCommentFooterView ()
@property (nonatomic, strong) UILabel *titleTextLabel;
@property (nonatomic, copy) commentFooterTouchBlock touchBlock;
@end

@implementation NewsDetailSectionCommentFooterView

+ (instancetype)sectionFooterWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"sectionFooter";
    NewsDetailSectionCommentFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (footer == nil) {
        footer = [[NewsDetailSectionCommentFooterView alloc] initWithReuseIdentifier:ID];
    }
    return footer;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASDisplayNode *titleTextNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        UILabel *titleTextlabel = [[UILabel alloc] init];
        titleTextlabel.textColor = RGB(218, 85, 107);
        titleTextlabel.font = [UIFont systemFontOfSize:14];
        titleTextlabel.textAlignment = NSTextAlignmentCenter;
        _titleTextLabel = titleTextlabel;
        return titleTextlabel;
    }];
    [self.contentView addSubnode:titleTextNode];
}

- (void)setTitle:(NSString *)title
{
    _title = title;

    _titleTextLabel.text = title;
}

- (void)commentFooterViewTouchBlock:(commentFooterTouchBlock)touchBlock
{
    _touchBlock = touchBlock;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_touchBlock) {
        _touchBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleTextLabel.frame = self.bounds;
}

@end
