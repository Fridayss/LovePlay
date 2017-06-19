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
        [self mas_subViews];
    }
    return self;
}

- (void)addSubnodes
{
    [self.contentView addSubview:self.imageNode];
    
    [self.contentView addSubview:self.titleTextNode];
}

- (void)mas_subViews
{
    [_imageNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [_titleTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

#pragma mark - public
- (void)setupImageInfoModel:(RecommendImageInfoModel *)imageInfoModel
{
    _imageInfoModel = imageInfoModel;
    _imageNode.imageURL = [NSURL URLWithString:_imageInfoModel.imgUrl];
    _titleTextNode.text = _imageInfoModel.title;
}

#pragma mark - setter / getter
- (UIImageView *)imageNode
{
    if (!_imageNode) {
        UIImageView *imageNode = [[UIImageView alloc] init];
        imageNode.userInteractionEnabled = NO;
        _imageNode = imageNode;
    }
    return _imageNode;
}

- (UILabel *)titleTextNode
{
    if (!_titleTextNode) {
        UILabel *titleTextNode = [[UILabel alloc] init];
        titleTextNode.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        titleTextNode.font = [UIFont systemFontOfSize:14];
        titleTextNode.textColor = [UIColor whiteColor];
        titleTextNode.textAlignment = NSTextAlignmentCenter;
        _titleTextNode = titleTextNode;
    }
    return _titleTextNode;
}
@end
