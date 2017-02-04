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
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@end

@implementation RecommendTopicCellNode

- (instancetype)initWithTopicModel:(RecommendTopicModel *)topicModel
{
    self = [super init];
    if (self) {
        _topicModel = topicModel;
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.URL = [NSURL URLWithString:_topicModel.iconUrl];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_topicModel.topicName];
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(78, 78);
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:8 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_imageNode, _titleTextNode]];
    return verStackLayout;
}


@end
