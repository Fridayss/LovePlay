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
        [self loadData];
    }
    return self;
}

- (void)addSubnodes
{
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    titleTextNode.maximumNumberOfLines = 2;
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
    
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *timeTextNode = [[ASTextNode alloc] init];
    [self addSubnode:timeTextNode];
    _timeTextNode = timeTextNode;
    
    ASButtonNode *replyBtnNode = [[ASButtonNode alloc] init];
    [self addSubnode:replyBtnNode];
    _replyBtnNode = replyBtnNode;

}

- (void)loadData
{
    _imageNode.URL = [NSURL URLWithString:_listInfoModel.imgsrc.firstObject];
    NSDictionary *titleAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : RGB(36, 36, 36)};
    _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_listInfoModel.title attributes:titleAttribute];
    [_replyBtnNode setTitle:@(_listInfoModel.replyCount).stringValue withFont:[UIFont systemFontOfSize:10] withColor:RGB(150, 150, 150) forState:ASControlStateNormal];
    [_replyBtnNode setImage:[UIImage imageNamed:@"common_chat_new"] forState:ASControlStateNormal];
    NSDictionary *timeAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : RGB(150, 150, 150)};
    NSString *ptime = _listInfoModel.ptime.length > 0 ? [_listInfoModel.ptime componentsSeparatedByString:@" "].firstObject : _listInfoModel.ptime;
    _timeTextNode.attributedText = [[NSAttributedString alloc] initWithString:ptime attributes:timeAttribute];
}

#pragma mark - layout

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
