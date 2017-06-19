//
//  NewsRelativeCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsRelativeCellNode.h"
#import "NewsDetailModel.h"

@interface NewsRelativeCellNode ()
//UI
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *titleTextNode;
@property (nonatomic, strong) UILabel *timeInfoTextNode;
@property (nonatomic, strong) UIView *underLineNode;
//Data
@property (nonatomic, strong) NewsRelativeInfo *relativeInfo;
@end

@implementation NewsRelativeCellNode

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsRelativeCellNode";
    NewsRelativeCellNode *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsRelativeCellNode alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubnodes];
        [self mas_subViews];
    }
    return self;
}

- (void)addSubnodes
{
    [self.contentView addSubview:self.imageNode];
    
    [self.contentView addSubview:self.titleTextNode];
    
    [self.contentView addSubview:self.timeInfoTextNode];
    
    [self.contentView addSubview:self.underLineNode];
    
}

- (void)mas_subViews
{
    [_imageNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(80);
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [_titleTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageNode);
        make.left.equalTo(_imageNode.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_timeInfoTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleTextNode);
        make.bottom.equalTo(_imageNode.mas_bottom);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_imageNode.mas_bottom).offset(10);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

#pragma mark - public
- (void)setupRelativeInfo:(NewsRelativeInfo *)relativeInfo
{
    _relativeInfo = relativeInfo;
    _imageNode.imageURL = [NSURL URLWithString:_relativeInfo.imgsrc];
    _titleTextNode.text = _relativeInfo.title;
    _timeInfoTextNode.text = [NSString stringWithFormat:@"%@ %@",_relativeInfo.source, _relativeInfo.ptime];
}

#pragma mark - setter / getter
- (UIImageView *)imageNode
{
    if (!_imageNode) {
        UIImageView *imageNode = [[UIImageView alloc] init];
        _imageNode = imageNode;
    }
    return  _imageNode;
}

- (UILabel *)titleTextNode
{
    if (!_titleTextNode) {
        UILabel *titleTextNode = [[UILabel alloc] init];
        titleTextNode.numberOfLines = 2;
        titleTextNode.font = [UIFont systemFontOfSize:16];
        titleTextNode.textColor = RGB(36, 36, 36);
        _titleTextNode = titleTextNode;
    }
    return _titleTextNode;
}

- (UILabel *)timeInfoTextNode
{
    if (!_timeInfoTextNode) {
        UILabel *timeInfoTextNode = [[UILabel alloc] init];
        timeInfoTextNode.font = [UIFont systemFontOfSize:10];
        timeInfoTextNode.textColor = RGB(150, 150, 150);
        _timeInfoTextNode = timeInfoTextNode;
    }
    return _timeInfoTextNode;
}

- (UIView *)underLineNode
{
    if (!_underLineNode) {
        UIView *underLineNode = [[UIView alloc] init];
        underLineNode.backgroundColor = RGB(222, 222, 222);
        _underLineNode = underLineNode;
    }
    return _underLineNode;
}


@end
