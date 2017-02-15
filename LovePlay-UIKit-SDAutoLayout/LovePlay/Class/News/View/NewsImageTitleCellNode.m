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
//UI
@property (nonatomic, strong) UILabel *titleTextNode;
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *timeTextNode;
@property (nonatomic, strong) UIButton *replyBtnNode;

@end

@implementation NewsImageTitleCellNode

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsImageTitleCellNode";
    NewsImageTitleCellNode *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsImageTitleCellNode alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubnodes];
        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.font = [UIFont systemFontOfSize:16];
    titleTextNode.textColor = RGB(36, 36, 36);
    [self.contentView addSubview:titleTextNode];
    _titleTextNode = titleTextNode;
    
    UIImageView *imageNode = [[UIImageView alloc] init];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *timeTextNode = [[UILabel alloc] init];
    timeTextNode.font = [UIFont systemFontOfSize:10];
    timeTextNode.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:timeTextNode];
    _timeTextNode = timeTextNode;
    
    UIButton *replyBtnNode = [[UIButton alloc] init];
    replyBtnNode.titleLabel.font = [UIFont systemFontOfSize:10];
    [replyBtnNode setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
    [replyBtnNode setImage:[UIImage imageNamed:@"common_chat_new"] forState:UIControlStateNormal];
    [replyBtnNode setTitle:@"0" forState:UIControlStateNormal];
    replyBtnNode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    replyBtnNode.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    replyBtnNode.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.contentView addSubview:replyBtnNode];
    _replyBtnNode = replyBtnNode;
    
}

- (void)setListInfoModel:(NewsListInfoModel *)listInfoModel
{
    _listInfoModel = listInfoModel;
    _imageNode.imageURL = [NSURL URLWithString:listInfoModel.imgsrc.firstObject];
    _titleTextNode.text = listInfoModel.title;
    NSString *ptime = _listInfoModel.ptime.length > 0 ? [_listInfoModel.ptime componentsSeparatedByString:@" "].firstObject : _listInfoModel.ptime;
    _timeTextNode.attributedText = [[NSAttributedString alloc] initWithString:ptime];
    [_replyBtnNode setTitle:[NSString stringWithFormat:@"%ld", _listInfoModel.replyCount] forState:UIControlStateNormal];
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _imageNode.sd_layout
    .heightIs(120)
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
    _titleTextNode.sd_layout
    .topSpaceToView(_imageNode, 10)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_titleTextNode setMaxNumberOfLinesToShow:2];
    
    _replyBtnNode.sd_layout
    .widthIs(50)
    .heightIs(20)
    .topSpaceToView(_titleTextNode, 10)
    .leftSpaceToView(_timeTextNode, 10)
    .rightEqualToView(_titleTextNode);
    
    _timeTextNode.sd_layout
    .leftEqualToView(_titleTextNode)
    .rightSpaceToView(_replyBtnNode, 10)
    .centerYEqualToView(_replyBtnNode)
    .autoHeightRatio(0);
    [_timeTextNode setMaxNumberOfLinesToShow:1];
    
    [self setupAutoHeightWithBottomView:_replyBtnNode bottomMargin:10];
}

@end
