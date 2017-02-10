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
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *nameTextNode;
@property (nonatomic, strong) UILabel *loctionTextNode;
@property (nonatomic, strong) UIButton *voteBtnNode;
@property (nonatomic, strong) UILabel *contentTextNode;
@property (nonatomic, strong) UIView *underLineNode;
@property (nonatomic, strong) NewsCommentReplyAreaNode *commentReplyAreaNode;
//Data
@property (nonatomic, strong) NewsCommentItem *commentItem;

@property (nonatomic, strong) NSDictionary *commentItemsDict;
@property (nonatomic, strong) NSArray *commentIdsArray;
@end

@implementation NewsCommentCellNode

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsCommentCellNode";
    NewsCommentCellNode *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsCommentCellNode alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    UIImageView *imageNode = [[UIImageView alloc] init];
    imageNode.imageURL = [NSURL URLWithString:_commentItem.user.avatar];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *nameTextNode = [[UILabel alloc] init];
    nameTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.user.nickname ? _commentItem.user.nickname : @"火星网友"];
    [self.contentView addSubview:nameTextNode];
    _nameTextNode = nameTextNode;
    
    UILabel *loctionTextNode = [[UILabel alloc] init];
    loctionTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.user.location ? _commentItem.user.location : @"火星"];
    [self.contentView addSubview:loctionTextNode];
    _loctionTextNode = loctionTextNode;
    
    UIButton *voteBtnNode = [[UIButton alloc] init];
    [voteBtnNode setTitle:[NSString stringWithFormat:@"%@顶",@(_commentItem.vote)] forState:UIControlStateNormal];
    [self.contentView addSubview:voteBtnNode];
    _voteBtnNode = voteBtnNode;
    
    if (_commentIdsArray.count > 1) {
        NewsCommentReplyAreaNode *commentReplyAreaNode = [[NewsCommentReplyAreaNode alloc] initWithcommentItems:_commentItemsDict floors:_commentIdsArray];
        [self.contentView addSubview:commentReplyAreaNode];
        _commentReplyAreaNode = commentReplyAreaNode;
    }
    
    UILabel *contentTextNode = [[UILabel alloc] init];
    contentTextNode.numberOfLines = 0;
    contentTextNode.attributedText = [[NSAttributedString alloc] initWithString:_commentItem.content];
    [self.contentView addSubview:contentTextNode];
    _contentTextNode = contentTextNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:underLineNode];
    _underLineNode = underLineNode;
    
    imageNode.backgroundColor = [UIColor orangeColor];
    nameTextNode.backgroundColor = [UIColor yellowColor];
    loctionTextNode.backgroundColor = [UIColor blueColor];
    voteBtnNode.backgroundColor = [UIColor redColor];
    contentTextNode.backgroundColor = [UIColor cyanColor];
}

- (void)setupCommentItems:(NSDictionary *)commentItems commmentIds:(NSArray *)commmentIds
{
    _commentItemsDict = commentItems;
    _commentIdsArray = commmentIds;
    _commentItem = commentItems[commmentIds.lastObject];
    
}

#pragma mark - layout
- (void)sd_autoLayout
{
    
}

//- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
//{
//    _imageNode.style.preferredSize = CGSizeMake(40, 40);
//    _voteBtnNode.style.preferredSize = CGSizeMake(50, 20);
//    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
//    
//    ASStackLayoutSpec *verTopLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:2 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[_nameTextNode, _loctionTextNode]];
//    
//    ASStackLayoutSpec *horTopLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[verTopLayout, _voteBtnNode]];
//    horTopLayout.style.flexGrow = YES;
//    
//    NSArray *contentNodeArray = _commentIdsArray.count > 1 ? @[horTopLayout, _commentReplyAreaNode, _contentTextNode] : @[horTopLayout, _contentTextNode];
//    
//    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:contentNodeArray];
//    verContentLayout.style.flexGrow = YES;//等分多余的空间
//    verContentLayout.style.flexShrink = YES;//空间（宽度）不够，等比例缩小（触发换行）
//    
//    ASStackLayoutSpec *horContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[_imageNode, verContentLayout]];
//    
//    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:horContentLayout];
//    
//    ASStackLayoutSpec *verUnderLineLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[insetLayout, _underLineNode]];
//    
//    return verUnderLineLayout;
//}

@end
