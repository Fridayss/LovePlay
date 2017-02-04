//
//  NewsNormalCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/1/30.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsNormalCellNode.h"

#import "NewsListInfoModel.h"

@interface NewsNormalCellNode ()

@property (nonatomic, strong) NewsListInfoModel *listInfoModel;
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASButtonNode *replyBtnNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
@end

@implementation NewsNormalCellNode

- (instancetype)initWithListInfoModel:(NewsListInfoModel *)listInfoModel
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _listInfoModel = listInfoModel;
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.URL = [NSURL URLWithString:_listInfoModel.imgsrc.firstObject];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    titleTextNode.maximumNumberOfLines = 2;
    titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_listInfoModel.title];
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
    
    ASButtonNode *replyBtnNode = [[ASButtonNode alloc] init];
    replyBtnNode.titleNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", _listInfoModel.replyCount]];
    [self addSubnode:replyBtnNode];
    _replyBtnNode = replyBtnNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = [UIColor lightGrayColor];
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;

}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(80, 80);
//    _textNode.style.flexShrink = 1.0;
//    _textNode.style.flexGrow = 1.0;
//    _textNode.style.alignSelf = ASStackLayoutAlignSelfStart;
    
    _replyBtnNode.style.preferredSize = CGSizeMake(50, 20);
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[_titleTextNode, _replyBtnNode]];
    
    ASStackLayoutSpec *horContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[_imageNode, verContentLayout]];
    
    ASInsetLayoutSpec *insetContentLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:horContentLayout];
    
    ASStackLayoutSpec *horUnderLineLayout = [ASStackLayoutSpec horizontalStackLayoutSpec];
    horUnderLineLayout.children = @[_underLineNode];
    
    
    ASStackLayoutSpec *verLayout = [ASStackLayoutSpec verticalStackLayoutSpec];
    verLayout.children = @[insetContentLayout, horUnderLineLayout];
    
    return verLayout;
}

@end
