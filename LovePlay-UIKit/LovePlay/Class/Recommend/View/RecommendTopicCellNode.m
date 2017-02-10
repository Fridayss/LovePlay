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
@property (nonatomic, strong) RecommendTopicModel *topicModel;
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *titleTextNode;
@end

@implementation RecommendTopicCellNode

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor redColor];
        [self addSubnodes];
        [self sd_autoLayoutSubViews];
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
    titleTextNode.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleTextNode];
    _titleTextNode = titleTextNode;
    
    imageNode.backgroundColor = [UIColor orangeColor];
    titleTextNode.backgroundColor = [UIColor cyanColor];
}

- (void)setupTopicModel:(RecommendTopicModel *)topicModel
{
    _topicModel = topicModel;
    _imageNode.imageURL = [NSURL URLWithString:_topicModel.iconUrl];
    _titleTextNode.text = _topicModel.topicName;
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _imageNode.sd_layout
    .widthIs(78)
    .heightIs(78)
    .topEqualToView(self.contentView)
    .centerXEqualToView(self.contentView);
    
    _titleTextNode.sd_layout
    .topSpaceToView(_imageNode, 8)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .autoHeightRatio(0);
    //不管label是否设置numberOfLines（单行、多行和自动换行显示所有内容），都需要在布局后，调用autoHeightRatio(0)来获取最新行高（可用label.backgroundColor调试）。并且，如果要限定显示行数，需调用sdlayout的label扩展方法setMaxNumberOfLinesToShow
    [_titleTextNode setMaxNumberOfLinesToShow:1];
}

//- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
//{
//    _imageNode.style.preferredSize = CGSizeMake(78, 78);
//    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:8 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_imageNode, _titleTextNode]];
//    return verStackLayout;
//}


@end
