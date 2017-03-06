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
//Data
@property (nonatomic, strong) NewsListInfoModel *listInfoModel;
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
        [self mas_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UIImageView *imageNode = [[UIImageView alloc] init];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.numberOfLines = 2;
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

- (void)setupListInfoModel:(NewsListInfoModel *)listInfoModel
{
    _listInfoModel = listInfoModel;
    _imageNode.imageURL = [NSURL URLWithString:listInfoModel.imgsrc.firstObject];
    _titleTextNode.text = listInfoModel.title;
    [_replyBtnNode setTitle:[NSString stringWithFormat:@"%ld", listInfoModel.replyCount] forState:UIControlStateNormal];
}

#pragma mark - layout

- (void)mas_autoLayoutSubViews
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
    
    [_replyBtnNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
        make.left.equalTo(_titleTextNode.mas_left);
        make.bottom.equalTo(_imageNode.mas_bottom);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_imageNode.mas_bottom).offset(10);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

@end
