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
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@end

@implementation RecommendImageInfoCellNode

- (instancetype)initWithImageInfoModel:(RecommendImageInfoModel *)imageInfoModel
{
    self = [super init];
    if (self) {
        _imageInfoModel = imageInfoModel;
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.userInteractionEnabled = NO;
    imageNode.URL = [NSURL URLWithString:_imageInfoModel.imgUrl];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    titleTextNode.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setAlignment:NSTextAlignmentCenter];
    NSDictionary *attri = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraph};
    titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_imageInfoModel.title attributes:attri];
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(267, constrainedSize.max.width);
    _titleTextNode.style.flexShrink = 1.0;
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsStretch children:@[_titleTextNode]];
    ASOverlayLayoutSpec *overlayLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_imageNode overlay:verStackLayout];
    return overlayLayout;
}

@end
