//
//  NewsNormalCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/1/30.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsNormalCellNode.h"
#import "NewsListInfoModel.h"

@interface NewsNormalCellNode ()
//UI
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *titleTextNode;
@property (nonatomic, strong) UIButton *replyBtnNode;
@property (nonatomic, strong) UIView *underLineNode;

@end

@implementation NewsNormalCellNode

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsNormalCellNode";
    NewsNormalCellNode *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsNormalCellNode alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    UIImageView *imageNode = [[UIImageView alloc] init];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.font = [UIFont systemFontOfSize:16];
    titleTextNode.textColor = RGB(36, 36, 36);
    [self.contentView addSubview:titleTextNode];
    _titleTextNode = titleTextNode;
    
    UIButton *replyBtnNode = [[UIButton alloc] init];
    replyBtnNode.titleLabel.font = [UIFont systemFontOfSize:10];
    [replyBtnNode setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
    [replyBtnNode setImage:[UIImage imageNamed:@"common_chat_new"] forState:UIControlStateNormal];
    [replyBtnNode setTitle:@"0" forState:UIControlStateNormal];
    replyBtnNode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    replyBtnNode.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    replyBtnNode.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    replyBtnNode.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.contentView addSubview:replyBtnNode];
    _replyBtnNode = replyBtnNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self.contentView addSubview:underLineNode];
    _underLineNode = underLineNode;
}

- (void)setListInfoModel:(NewsListInfoModel *)listInfoModel
{
    _listInfoModel = listInfoModel;
    _imageNode.imageURL = [NSURL URLWithString:listInfoModel.imgsrc.firstObject];
    _titleTextNode.text = listInfoModel.title;
    [_replyBtnNode setTitle:[NSString stringWithFormat:@"%ld", listInfoModel.replyCount] forState:UIControlStateNormal];
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _imageNode.sd_layout
    .widthIs(80)
    .heightIs(80)
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10);
    
    _titleTextNode.sd_layout
    .topEqualToView(_imageNode)
    .leftSpaceToView(_imageNode, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_titleTextNode setMaxNumberOfLinesToShow:2];
    
    _replyBtnNode.sd_layout
    .widthIs(50)
    .heightIs(20)
    .leftSpaceToView(_imageNode, 10)
    .bottomEqualToView(_imageNode);
    
    _underLineNode.sd_layout
    .heightIs(0.5)
    .topSpaceToView(_imageNode, 10)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
    [self setupAutoHeightWithBottomView:_underLineNode bottomMargin:0];
}

@end
