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
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
//Data
@property (nonatomic, strong) RecommendTopicModel *topicModel;
@end

@implementation RecommendTopicCellNode

- (instancetype)initWithTopicModel:(RecommendTopicModel *)topicModel
{
    self = [super init];
    if (self) {
        _topicModel = topicModel;
        [self addSubnodes];
        [self loadData];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    titleTextNode.maximumNumberOfLines = 1;
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
}

- (void)loadData
{
    _imageNode.URL = [NSURL URLWithString:_topicModel.iconUrl];
    NSDictionary *titleAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : RGB(36, 36, 36)};
    _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_topicModel.topicName attributes:titleAttribute];
}

#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(78, 78);
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:8 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_imageNode, _titleTextNode]];
    return verStackLayout;
}


@end
