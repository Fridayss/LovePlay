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
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    UILabel *titleTextLabel = [[UILabel alloc] init];
    titleTextLabel.font = [UIFont systemFontOfSize:13];
    titleTextLabel.textColor = [UIColor whiteColor];
    [self addSubview:titleTextLabel];
    _titleTextLabel = titleTextLabel;
}


- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    _titleTextLabel.text = titleName;
    //直接使用ASTextNode作为【原生view】的子控件，无法适应原生的布局
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setAlignment:NSTextAlignmentJustified];
    NSDictionary *attri = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraph};
    _titleTextLabel.attributedText = [[NSAttributedString alloc] initWithString:titleName attributes:attri];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleTextLabel.frame = CGRectMake(8, 0, 100, self.frame.size.height);
    
    //【可放开词句查看问题】直接使用ASTextNode作为【原生view】的子控件，无法适应原生的布局
//    _titleTextNode.frame = CGRectMake(8, 0, 100, self.frame.size.height);

}

@end
