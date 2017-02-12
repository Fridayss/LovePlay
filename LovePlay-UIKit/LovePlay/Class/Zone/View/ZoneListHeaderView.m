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
        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UILabel *titleTextLabel = [[UILabel alloc] init];
    titleTextLabel.font = [UIFont systemFontOfSize:14];
    titleTextLabel.textColor = [UIColor whiteColor];
    [self addSubview:titleTextLabel];
    _titleTextLabel = titleTextLabel;
}


- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    _titleTextLabel.text = titleName;
    
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _titleTextLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 8, 0, 8));
}

@end
