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
//UI
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
//Data
@property (nonatomic, strong) NewsListInfoModel *listInfoModel;
@end

@implementation NewsTitleImageCellNode

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
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;

}

- (void)loadData
{
    _imageNode.URL = [NSURL URLWithString:_listInfoModel.imgsrc.firstObject];
    NSDictionary *titleAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : RGB(36, 36, 36)};
    _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_listInfoModel.title attributes:titleAttribute];
}

#pragma mark - layout
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
