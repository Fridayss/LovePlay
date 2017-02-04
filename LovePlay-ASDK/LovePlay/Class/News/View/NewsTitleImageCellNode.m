//
//  NewsTitleImageCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsTitleImageCellNode.h"
#import "NewsListInfoModel.h"

@interface NewsTitleImageCellNode ()
@property (nonatomic, strong) NewsListInfoModel *listInfoModel;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
@end

@implementation NewsTitleImageCellNode

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
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = [UIColor lightGrayColor];
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;

}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(constrainedSize.max.width - 20, 120);
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[_titleTextNode, _imageNode]];
    
    ASInsetLayoutSpec *insetContentLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:verContentLayout];
    
    ASStackLayoutSpec *verStachLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[insetContentLayout, _underLineNode]];
    return verStachLayout;
}

@end
