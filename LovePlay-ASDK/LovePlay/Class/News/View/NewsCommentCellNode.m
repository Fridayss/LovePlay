//
//  NewsCommentCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentCellNode.h"
#import "NewsCommentModel.h"

@interface NewsCommentCellNode ()
//UI
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *nameTextNode;
@property (nonatomic, strong) ASTextNode *loctionTextNode;
@property (nonatomic, strong) ASTextNode *contentTextNode;
@property (nonatomic, strong) ASButtonNode *voteBtnNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
//Data
@property (nonatomic, strong) NewsCommentItem *commentItem;
@end

@implementation NewsCommentCellNode

- (instancetype)initWithcommentItem:(NewsCommentItem *)commentItem
{
    self = [super init];
    if (self) {
        _commentItem = commentItem;
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
//    imageNode.URL = [NSURL URLWithString:_commentItem.user.avatar];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *nameTextNode = [[ASTextNode alloc] init];
//    nameTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.user.nickname];
    [self addSubnode:nameTextNode];
    _nameTextNode = nameTextNode;
    
    ASTextNode *loctionTextNode = [[ASTextNode alloc] init];
//    loctionTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.user.location];
    [self addSubnode:loctionTextNode];
    _loctionTextNode = loctionTextNode;
    
    ASTextNode *contentTextNode = [[ASTextNode alloc] init];
    contentTextNode.style.flexGrow = 1.0;
    contentTextNode.style.flexShrink = 1.0;
    contentTextNode.maximumNumberOfLines = 3;
    contentTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.content];
    [self addSubnode:contentTextNode];
    _contentTextNode = contentTextNode;
    
    ASButtonNode *voteBtnNode = [[ASButtonNode alloc] init];
//    voteBtnNode.titleNode.attributedText = [[NSAttributedString alloc] initWithString:@(_commentItem.vote).stringValue];
    [self addSubnode:voteBtnNode];
    _voteBtnNode = voteBtnNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = [UIColor lightGrayColor];
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
    
    imageNode.backgroundColor = [UIColor orangeColor];
    nameTextNode.backgroundColor = [UIColor yellowColor];
    voteBtnNode.backgroundColor = [UIColor redColor];
    voteBtnNode.backgroundColor = [UIColor cyanColor];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(40, 40);
    _voteBtnNode.style.preferredSize = CGSizeMake(50, 20);
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    ASStackLayoutSpec *verTopLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:2 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[_nameTextNode, _loctionTextNode]];
    
    ASStackLayoutSpec *horTopLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[verTopLayout, _voteBtnNode]];
    
    ASStackLayoutSpec *verCotentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[horTopLayout, _contentTextNode]];
    
    ASStackLayoutSpec *horContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[_imageNode, verCotentLayout]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:horContentLayout];
    
    ASStackLayoutSpec *verUnderLineLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[insetLayout, _underLineNode]];
    
    return verUnderLineLayout;
}

@end
