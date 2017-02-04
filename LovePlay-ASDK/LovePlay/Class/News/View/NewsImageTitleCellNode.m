//
//  NewsImageTitleCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsImageTitleCellNode.h"
#import "NewsListInfoModel.h"

@interface NewsImageTitleCellNode ()
@property (nonatomic, strong) NewsListInfoModel *listInfoModel;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *timeTextNode;
@property (nonatomic, strong) ASButtonNode *replyBtnNode;

@end

@implementation NewsImageTitleCellNode

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
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    titleTextNode.maximumNumberOfLines = 2;
    titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_listInfoModel.title];
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
    
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.URL = [NSURL URLWithString:_listInfoModel.imgsrc.firstObject];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *timeTextNode = [[ASTextNode alloc] init];
    NSString *ptime = _listInfoModel.ptime.length > 0 ? [_listInfoModel.ptime componentsSeparatedByString:@" "].firstObject : _listInfoModel.ptime;
    timeTextNode.attributedText = [[NSAttributedString alloc] initWithString:ptime];
    [self addSubnode:timeTextNode];
    _timeTextNode = timeTextNode;
    
    ASButtonNode *replyBtnNode = [[ASButtonNode alloc] init];
    replyBtnNode.titleNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", _listInfoModel.replyCount]];
    [self addSubnode:replyBtnNode];
    _replyBtnNode = replyBtnNode;

}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 120);
//    _titleTextNode.style.flexShrink = 0.0;
//    _titleTextNode.style.alignSelf = ASStackLayoutAlignSelfCenter;
    _replyBtnNode.style.preferredSize = CGSizeMake(50, 20);
    
    ASStackLayoutSpec *horTimeLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:0 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsCenter children:@[_timeTextNode, _replyBtnNode]];
    horTimeLayout.style.flexGrow = YES;
    
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[_titleTextNode, horTimeLayout]];
    
    ASInsetLayoutSpec *insetContentLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 10, 10, 10) child:verContentLayout];
    
    ASStackLayoutSpec *verStachLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[_imageNode, insetContentLayout]];
    return verStachLayout;
}


@end
