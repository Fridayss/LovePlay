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
//UI
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *titleTextNode;
//Data
@property (nonatomic, strong) RecommendImageInfoModel *imageInfoModel;
@end

@implementation RecommendImageInfoCellNode

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubnodes];
        [self mas_autoLayoutSubViews];
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
- (void)mas_autoLayoutSubViews
{
    [_imageNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [_titleTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

@end
