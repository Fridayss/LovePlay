//
//  NewsCommentReplyNode.m
//  LovePlay
//
//  Created by weiying on 2017/2/6.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentReplyNode.h"
#import "NewsCommentModel.h"

@interface NewsCommentReplyNode ()
//UI
@property (nonatomic, strong) ASTextNode *nameTextNode;
@property (nonatomic, strong) ASTextNode *floorTextNode;
@property (nonatomic, strong) ASTextNode *contentTextNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
//Data
@property (nonatomic, strong) NewsCommentItem *commentItem;
@property (nonatomic, assign) NSInteger floor;
@end

@implementation NewsCommentReplyNode

- (instancetype)initWithcommentItem:(NewsCommentItem *)commentItem floor:(NSInteger)floor
{
    self = [super init];
    if (self) {
        _commentItem = commentItem;
        _floor = floor;
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASTextNode *nameTextNode = [[ASTextNode alloc] init];
    nameTextNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", _commentItem.user.nickname ? _commentItem.user.nickname : @"火星网友", _commentItem.user.location ? _commentItem.user.location : @"火星"]];
    [self addSubnode:nameTextNode];
    _nameTextNode = nameTextNode;
    
    ASTextNode *floorTextNode = [[ASTextNode alloc] init];
    floorTextNode.attributedText = [[NSAttributedString alloc] initWithString:@(_floor).stringValue];
    [self addSubnode:floorTextNode];
    _floorTextNode = floorTextNode;
    
    ASTextNode *contentTextNode = [[ASTextNode alloc] init];
    contentTextNode.maximumNumberOfLines = 0;
    contentTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.content];
    [self addSubnode:contentTextNode];
    _contentTextNode = contentTextNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = [UIColor lightGrayColor];
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    ASStackLayoutSpec *horTopLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[_nameTextNode, _floorTextNode]];
    
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[horTopLayout, _contentTextNode]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 4, 8, 4) child:verContentLayout];
    
    ASStackLayoutSpec *verUnderLineLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[insetLayout, _underLineNode]];
    
    return verUnderLineLayout;
}

@end
