//
//  ZoneListHeaderView.m
//  LovePlay
//
//  Created by Yuns on 2017/2/2.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "ZoneListHeaderView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ZoneListHeaderView ()
@property (nonatomic, strong) UILabel *titleTextLabel;
//无法适应原生布局和显示效果，用于问题调试
@property (nonatomic, strong) ASTextNode *titleTextNode;
@end

@implementation ZoneListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
#warning - 在【原生view】中，想要子控件具有【原生控件】的特性，又想使子控件获得ASDK提升的性能。比如使用ASTextNode作为【原生view】子控件时，原生的布局和显示方式对其不起作用。正确的处理方式是：使用ASDisplayNode对原生控件包装

    ASDisplayNode *textNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        UILabel *titleTextLabel = [[UILabel alloc] init];
        titleTextLabel.font = [UIFont systemFontOfSize:14];
        titleTextLabel.textColor = RGB(36, 36, 36);
        _titleTextLabel = titleTextLabel;
        return titleTextLabel;
    }];
    [self addSubnode:textNode];
    
    //直接使用ASTextNode作为【原生view】的子控件，无法适应原生的布局
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
}


- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    _titleTextLabel.text = titleName;
    //直接使用ASTextNode作为【原生view】的子控件，无法适应原生的布局
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setAlignment:NSTextAlignmentJustified];
    NSDictionary *attri = @{NSForegroundColorAttributeName : RGB(36, 36, 36), NSParagraphStyleAttributeName : paragraph, NSFontAttributeName : [UIFont systemFontOfSize:14]};
    _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:titleName attributes:attri];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleTextLabel.frame = CGRectMake(8, 0, 100, self.frame.size.height);
    
    //【可放开词句查看问题】直接使用ASTextNode作为【原生view】的子控件，无法适应原生的布局
//    _titleTextNode.frame = CGRectMake(8, 0, 100, self.frame.size.height);

}

@end
