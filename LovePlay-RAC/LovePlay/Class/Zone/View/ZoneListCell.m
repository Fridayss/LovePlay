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
//Data
@property (nonatomic, strong) ZoneDiscussItem *discussItem;
@end

@implementation ZoneListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubnodes];
        [self mas_subViews];
    }
    return self;
}

#pragma mark - private
- (void)addSubnodes
{
    [self.contentView addSubview:self.imageNode];
    
    [self.contentView addSubview:self.titleTextLabel];
    
    [self.contentView addSubview:self.detailTextLabel];
}

- (void)mas_subViews
{
    [_imageNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageNode).offset(3);
        make.left.equalTo(_imageNode.mas_right).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleTextLabel);
        make.bottom.equalTo(_imageNode.mas_bottom).offset(-3);
    }];
}

#pragma mark -  public
- (void)setupDiscussItem:(ZoneDiscussItem *)discussItem
{
    _discussItem = discussItem;
    _imageNode.imageURL = [NSURL URLWithString:_discussItem.iconUrl];
    _titleTextLabel.text = _discussItem.modelName;
    _detailTextLabel.text = _discussItem.modelDesc;
}

#pragma mark - setter / getter
- (UIImageView *)imageNode
{
    if (!_imageNode) {
        UIImageView *imageNode = [[UIImageView alloc] init];
        _imageNode = imageNode;
    }
    return _imageNode;
}

- (UILabel *)titleTextLabel
{
    if (!_titleTextLabel) {
        UILabel *titleTextLabel = [[UILabel alloc] init];
        titleTextLabel.font = [UIFont systemFontOfSize:14];
        titleTextLabel.textColor = RGB(36, 36, 36);
        _titleTextLabel = titleTextLabel;
    }
    return _titleTextLabel;
}

- (UILabel *)detailTextLabel
{
    if (!_detailTextLabel) {
        UILabel *detailTextLabel = [[UILabel alloc] init];
        detailTextLabel.font = [UIFont systemFontOfSize:12];
        detailTextLabel.textColor = RGB(150, 150, 150);
        _detailTextLabel = detailTextLabel;
    }
    return _detailTextLabel;
}
@end
