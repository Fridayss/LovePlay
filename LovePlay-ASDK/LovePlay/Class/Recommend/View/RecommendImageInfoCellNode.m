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
    titleTextNode.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
}

- (void)loadData
{
    _imageNode.URL = [NSURL URLWithString:_imageInfoModel.imgUrl];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setAlignment:NSTextAlignmentCenter];
    NSDictionary *titleAttribute = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraph, NSFontAttributeName : [UIFont systemFontOfSize:14]};
    _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_imageInfoModel.title attributes:titleAttribute];
}

#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, constrainedSize.max.height);
    
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsStretch children:@[_titleTextNode]];
    ASOverlayLayoutSpec *overlayLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_imageNode overlay:verStackLayout];
    return overlayLayout;
}

@end
