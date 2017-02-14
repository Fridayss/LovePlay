//
//  ZoneListCell.m
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "ZoneListCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ZoneListModel.h"

@interface ZoneListCell ()
// UI
@property (nonatomic, strong) UILabel *titleTextLabel;
@property (nonatomic, strong) UILabel *detailTextLabel;
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@end

@implementation ZoneListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    [self.contentView addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASDisplayNode *titleTextNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        UILabel *titleTextLabel = [[UILabel alloc] init];
        titleTextLabel.font = [UIFont systemFontOfSize:14];
        titleTextLabel.textColor = RGB(36, 36, 36);
        _titleTextLabel = titleTextLabel;
        return titleTextLabel;
    }];
    [self.contentView addSubnode:titleTextNode];
    
    ASDisplayNode *detailTextNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        UILabel *detailTextLabel = [[UILabel alloc] init];
        detailTextLabel.font = [UIFont systemFontOfSize:12];
        detailTextLabel.textColor = RGB(150, 150, 150);
        _detailTextLabel = detailTextLabel;
        return detailTextLabel;
    }];
    [self.contentView addSubnode:detailTextNode];

}

- (void)setDiscussItem:(ZoneDiscussItem *)discussItem
{
    _discussItem = discussItem;
    _imageNode.URL = [NSURL URLWithString:_discussItem.iconUrl];
    _titleTextLabel.text = _discussItem.modelName;
    _detailTextLabel.text = _discussItem.modelDesc;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat horEdge = 10;
    CGFloat imageNodeWH = 54;
    CGFloat imageNodeY = (self.frame.size.height - imageNodeWH) / 2;
    
    _imageNode.frame = CGRectMake(horEdge, imageNodeY, imageNodeWH, imageNodeWH);
    CGFloat textNodeW = self.frame.size.width - imageNodeWH - 3 * horEdge;
    CGFloat textNodeH = 20;
    _titleTextLabel.frame = CGRectMake(CGRectGetMaxX(_imageNode.frame) + horEdge, CGRectGetMinY(_imageNode.frame), textNodeW, textNodeH);
    _detailTextLabel.frame = CGRectMake(CGRectGetMinX(_titleTextLabel.frame), CGRectGetMaxY(_imageNode.frame) - textNodeH, textNodeW, textNodeH);
}

@end
