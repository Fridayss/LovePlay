//
//  RecommendTopicCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "RecommendTopicCellNode.h"
#import "RecommendTopicModel.h"

@interface RecommendTopicCellNode ()
//UI
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *titleTextNode;
//Data
@property (nonatomic, strong) RecommendTopicModel *topicModel;
@end

@implementation RecommendTopicCellNode

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
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.font = [UIFont systemFontOfSize:12];
    titleTextNode.textColor = RGB(36, 36, 36);
    titleTextNode.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleTextNode];
    _titleTextNode = titleTextNode;
}

- (void)setupTopicModel:(RecommendTopicModel *)topicModel
{
    _topicModel = topicModel;
    _imageNode.imageURL = [NSURL URLWithString:_topicModel.iconUrl];
    _titleTextNode.text = _topicModel.topicName;
}

#pragma mark - layout

- (void)mas_autoLayoutSubViews
{
    [_imageNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(@78);
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
    }];
    
    [_titleTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageNode.mas_bottom).offset(8);
        make.left.and.right.equalTo(self.contentView);
    }];
}

@end
