//
//  NewsRelativeCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsRelativeCellNode.h"
#import "NewsDetailModel.h"

@interface NewsRelativeCellNode ()
//UI
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASTextNode *timeInfoTextNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
//Data
@property (nonatomic, strong) NewsRelativeInfo *relativeInfo;
@end

@implementation NewsRelativeCellNode

- (instancetype)initWithRelativeInfo:(NewsRelativeInfo *)relativeInfo
{
    self = [super init];
    if (self) {
        _relativeInfo = relativeInfo;
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.URL = [NSURL URLWithString:_relativeInfo.imgsrc];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_relativeInfo.title];
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
    
    ASTextNode *timeInfoTextNode = [[ASTextNode alloc] init];
    timeInfoTextNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",_relativeInfo.source, _relativeInfo.ptime]];
    [self addSubnode:timeInfoTextNode];
    _timeInfoTextNode = timeInfoTextNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = [UIColor lightGrayColor];
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
    
}

#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(80, 80);
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[_titleTextNode, _timeInfoTextNode]];
    
    ASStackLayoutSpec *horContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[_imageNode, verContentLayout]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:horContentLayout];
    
    ASStackLayoutSpec *verUnderLineLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[insetLayout, _underLineNode]];
    
    return verUnderLineLayout;
}

@end
