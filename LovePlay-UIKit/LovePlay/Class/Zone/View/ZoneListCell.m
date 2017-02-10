//
//  ZoneListCell.m
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "ZoneListCell.h"
#import "ZoneListModel.h"

@interface ZoneListCell ()
// UI
@property (nonatomic, strong) UILabel *titleTextLabel;
@property (nonatomic, strong) UILabel *detailTextLabel;
@property (nonatomic, strong) UIImageView *imageNode;
@end

@implementation ZoneListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    UIImageView *imageNode = [[UIImageView alloc] init];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *titleTextLabel = [[UILabel alloc] init];
    titleTextLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:titleTextLabel];
    _titleTextLabel = titleTextLabel;
    
    UILabel *detailTextLabel = [[UILabel alloc] init];
    detailTextLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:detailTextLabel];
    _detailTextLabel = detailTextLabel;

}

- (void)setDiscussItem:(ZoneDiscussItem *)discussItem
{
    _discussItem = discussItem;
    _imageNode.imageURL = [NSURL URLWithString:_discussItem.iconUrl];
    _titleTextLabel.text = _discussItem.modelName;
    _detailTextLabel.text = _discussItem.modelDesc;
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    CGFloat horEdge = 10;
//    CGFloat imageNodeWH = 54;
//    CGFloat imageNodeY = (self.frame.size.height - imageNodeWH) / 2;
//    
//    _imageNode.frame = CGRectMake(horEdge, imageNodeY, imageNodeWH, imageNodeWH);
//    CGFloat textNodeW = self.frame.size.width - imageNodeWH - 3 * horEdge;
//    CGFloat textNodeH = 20;
//    _titleTextLabel.frame = CGRectMake(CGRectGetMaxX(_imageNode.frame) + horEdge, CGRectGetMinY(_imageNode.frame), textNodeW, textNodeH);
//    _detailTextLabel.frame = CGRectMake(CGRectGetMinX(_titleTextLabel.frame), CGRectGetMaxY(_imageNode.frame) - textNodeH, textNodeW, textNodeH);
//}

//- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
//{
//    _imageNode.style.preferredSize = CGSizeMake(54, 54);
//
//    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[_titleTextNode, _detailTextNode]];
//
//    ASStackLayoutSpec *horContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[_imageNode, verContentLayout]];
//
//    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:horContentLayout];
//    return insetLayout;
//}



@end
