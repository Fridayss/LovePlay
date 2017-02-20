//
//  NewsCommentCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentCellNode.h"
#import "NewsCommentModel.h"
#import "NewsCommentReplyAreaNode.h"

@interface NewsCommentCellNode ()
//UI
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *nameTextNode;
@property (nonatomic, strong) ASTextNode *loctionTextNode;
@property (nonatomic, strong) ASButtonNode *voteBtnNode;
@property (nonatomic, strong) ASTextNode *contentTextNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
@property (nonatomic, strong) NewsCommentReplyAreaNode *commentReplyAreaNode;
//Data
@property (nonatomic, strong) NewsCommentItem *commentItem;

@property (nonatomic, strong) NSDictionary *commentItemsDict;
@property (nonatomic, strong) NSArray *commentIdsArray;
@end

@implementation NewsCommentCellNode

- (instancetype)initWithcommentItem:(NewsCommentItem *)commentItem
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _commentItem = commentItem;
        [self addSubnodes];
    }
    return self;
}

- (instancetype)initWithcommentItems:(NSDictionary *)commentItems commmentIds:(NSArray *)commmentIds
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _commentItemsDict = commentItems;
        _commentIdsArray = commmentIds;
        _commentItem = commentItems[commmentIds.lastObject];
        [self addSubnodes];
        [self loadData];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.defaultImage = [UIImage imageNamed:@"defult_pho"];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *nameTextNode = [[ASTextNode alloc] init];
    [self addSubnode:nameTextNode];
    _nameTextNode = nameTextNode;
    
    ASTextNode *loctionTextNode = [[ASTextNode alloc] init];
    [self addSubnode:loctionTextNode];
    _loctionTextNode = loctionTextNode;
    
    ASButtonNode *voteBtnNode = [[ASButtonNode alloc] init];
    [self addSubnode:voteBtnNode];
    _voteBtnNode = voteBtnNode;
    
    if (_commentIdsArray.count > 1) {
        NewsCommentReplyAreaNode *commentReplyAreaNode = [[NewsCommentReplyAreaNode alloc] initWithcommentItems:_commentItemsDict floors:_commentIdsArray];
        [self addSubnode:commentReplyAreaNode];
        _commentReplyAreaNode = commentReplyAreaNode;
    }
    
    ASTextNode *contentTextNode = [[ASTextNode alloc] init];
    contentTextNode.maximumNumberOfLines = 0;
    [self addSubnode:contentTextNode];
    _contentTextNode = contentTextNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (void)loadData
{
    _imageNode.URL = [NSURL URLWithString:_commentItem.user.avatar];
    NSDictionary *nameAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: RGB(186, 177, 161)};
    _nameTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.user.nickname ? _commentItem.user.nickname : @"火星网友" attributes:nameAttribute];
    NSDictionary *locationAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: RGB(163, 163, 163)};
    _loctionTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.user.location ? _commentItem.user.location : @"火星" attributes:locationAttribute];
    [_voteBtnNode setTitle:[NSString stringWithFormat:@"%@顶",@(_commentItem.vote)] withFont:[UIFont systemFontOfSize:12] withColor:RGB(163, 163, 163) forState:ASControlStateNormal];
    NSDictionary *contentAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: RGB(50, 50, 50)};
    _contentTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.content attributes:contentAttribute];
}

#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    CGFloat imageWH = 40;
    CGFloat imageToNameMargin = 5;
    _imageNode.style.preferredSize = CGSizeMake(imageWH, imageWH);
    _voteBtnNode.style.preferredSize = CGSizeMake(50, 20);
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    //顶部（用户）信息布局
    ASStackLayoutSpec *verUserLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:2 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[_nameTextNode, _loctionTextNode]];
    
    ASStackLayoutSpec *horUserLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStretch children:@[verUserLayout, _voteBtnNode]];
    horUserLayout.style.flexGrow = YES;
    
    ASStackLayoutSpec *horTopLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:imageToNameMargin justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[_imageNode, horUserLayout]];
    
    //评论模块布局
    NSArray *commentNodeArray = _commentIdsArray.count > 1 ? @[_commentReplyAreaNode, _contentTextNode] : @[_contentTextNode];
    
    ASStackLayoutSpec *verCommentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:commentNodeArray];
    
    ASInsetLayoutSpec *insetCommentLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, imageWH + imageToNameMargin, 0, 0) child:verCommentLayout];
    
    //整体内容布局
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[horTopLayout, insetCommentLayout]];
    verContentLayout.style.flexGrow = YES;//等分多余的空间
    verContentLayout.style.flexShrink = YES;//空间（宽度）不够，等比例缩小（触发换行）
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:verContentLayout];
    
    ASStackLayoutSpec *verUnderLineLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[insetLayout, _underLineNode]];
    
    return verUnderLineLayout;
}

@end
