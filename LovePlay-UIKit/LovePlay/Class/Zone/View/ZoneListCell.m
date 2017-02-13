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
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubnodes];
        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UIImageView *imageNode = [[UIImageView alloc] init];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *titleTextLabel = [[UILabel alloc] init];
    titleTextLabel.font = [UIFont systemFontOfSize:14];
    titleTextLabel.textColor = RGB(36, 36, 36);
    [self.contentView addSubview:titleTextLabel];
    _titleTextLabel = titleTextLabel;
    
    UILabel *detailTextLabel = [[UILabel alloc] init];
    detailTextLabel.font = [UIFont systemFontOfSize:12];
    detailTextLabel.textColor = RGB(150, 150, 150);
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
    _imageNode.sd_layout
    .widthIs(50)
    .heightIs(50)
    .leftSpaceToView(self.contentView, 10)
    .centerYEqualToView(self.contentView);
    
    _titleTextLabel.sd_layout
    .topEqualToView(_imageNode).offset(3)
    .leftSpaceToView(_imageNode, 5)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_titleTextLabel setMaxNumberOfLinesToShow:1];
    
    _detailTextLabel.sd_layout
    .leftEqualToView(_titleTextLabel)
    .bottomEqualToView(_imageNode).offset(- 3)
    .rightEqualToView(_titleTextLabel)
    .autoHeightRatio(0);
    [_detailTextLabel setMaxNumberOfLinesToShow:1];
}

@end
