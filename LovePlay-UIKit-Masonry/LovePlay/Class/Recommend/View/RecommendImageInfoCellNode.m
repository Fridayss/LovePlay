//
//  RecommendImageInfoCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "RecommendImageInfoCellNode.h"
#import "RecommendImageInfoModel.h"

@interface RecommendImageInfoCellNode ()
@property (nonatomic, strong) RecommendImageInfoModel *imageInfoModel;
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *titleTextNode;
@end

@implementation RecommendImageInfoCellNode

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubnodes];
        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UIImageView *imageNode = [[UIImageView alloc] init];
    imageNode.userInteractionEnabled = NO;
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    titleTextNode.font = [UIFont systemFontOfSize:14];
    titleTextNode.textColor = [UIColor whiteColor];
    titleTextNode.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleTextNode];
    _titleTextNode = titleTextNode;
}

- (void)setupImageInfoModel:(RecommendImageInfoModel *)imageInfoModel
{
    _imageInfoModel = imageInfoModel;
    _imageNode.imageURL = [NSURL URLWithString:_imageInfoModel.imgUrl];
    _titleTextNode.text = _imageInfoModel.title;
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _imageNode.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    _titleTextNode.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .autoHeightRatio(0);
    [_titleTextNode setMaxNumberOfLinesToShow:1];
}

@end
