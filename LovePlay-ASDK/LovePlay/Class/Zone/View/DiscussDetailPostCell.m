//
//  DiscussDetailPostCell.m
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussDetailPostCell.h"
#import "DiscussDetailModel.h"

@interface DiscussDetailPostCell ()
//UI
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *nameTextNode;
@property (nonatomic, strong) ASTextNode *timeTextNode;
@property (nonatomic, strong) ASTextNode *floorTextNode;
@property (nonatomic, strong) ASTextNode *contentTextNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
//Data
@property (nonatomic, strong) DiscuzPost *post;
@property (nonatomic, assign) NSInteger floor;
@end

@implementation DiscussDetailPostCell

- (instancetype)initWithPost:(DiscuzPost *)post floor:(NSInteger)floor
{
    self = [super init];
    if (self) {
        _post = post;
        _floor = floor;
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
//    imageNode.URL = [NSURL URLWithString:_post.];
    imageNode.backgroundColor = [UIColor orangeColor];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *nameTextNode = [[ASTextNode alloc] init];
    nameTextNode.attributedText = [[NSAttributedString alloc] initWithString:_post.author];
    [self addSubnode:nameTextNode];
    _nameTextNode = nameTextNode;
    
    ASTextNode *timeTextNode = [[ASTextNode alloc] init];
    timeTextNode.attributedText = [[NSAttributedString alloc] initWithString:[_post.dateline stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""]];
    [self addSubnode:timeTextNode];
    _timeTextNode = timeTextNode;
    
    ASTextNode *floorTextNode = [[ASTextNode alloc] init];
    floorTextNode.attributedText = [[NSAttributedString alloc] initWithString:@(_floor).stringValue];
    [self addSubnode:floorTextNode];
    _floorTextNode = floorTextNode;
    
    ASTextNode *contentTextNode = [[ASTextNode alloc] init];
    contentTextNode.maximumNumberOfLines = 0;
    contentTextNode.attributedText = [[NSAttributedString alloc] initWithString:_post.message];
    [self addSubnode:contentTextNode];
    _contentTextNode = contentTextNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = [UIColor lightGrayColor];
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(30, 30);
    _contentTextNode.style.flexGrow = YES;
    _contentTextNode.style.flexShrink = YES;
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    ASStackLayoutSpec *horUserLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_imageNode, _nameTextNode, _timeTextNode]];
    
    ASStackLayoutSpec *horTopLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsCenter children:@[horUserLayout, _floorTextNode]];
    
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[horTopLayout, _contentTextNode]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:verContentLayout];
    
    ASStackLayoutSpec *verUnderLindeLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[insetLayout, _underLineNode]];
    
    return verUnderLindeLayout;
}

@end
