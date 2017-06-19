//
//  NewsCommentCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentCellNode.h"
#import "NewsCommentModel.h"
#import "NewsCommentReplyAreaNode.h"

@interface NewsCommentCellNode ()
//UI
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *nameTextNode;
@property (nonatomic, strong) UILabel *locationTextNode;
@property (nonatomic, strong) UIButton *voteBtnNode;
@property (nonatomic, strong) UILabel *contentTextNode;
@property (nonatomic, strong) UIView *underLineNode;
@property (nonatomic, strong) NewsCommentReplyAreaNode *commentReplyAreaNode;
//Data
@property (nonatomic, strong) NewsCommentItem *commentItem;

@property (nonatomic, strong) NSDictionary *commentItemsDict;
@property (nonatomic, strong) NSArray *commentIdsArray;
@end

@implementation NewsCommentCellNode

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsCommentCellNode";
    NewsCommentCellNode *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsCommentCellNode alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

#pragma mark - private
- (void)addSubnodes
{
    [self.contentView addSubview:self.imageNode];
    
    [self.contentView addSubview:self.nameTextNode];
    
    [self.contentView addSubview:self.locationTextNode];
    
    [self.contentView addSubview:self.voteBtnNode];
    
    [self.contentView addSubview:self.commentReplyAreaNode];
    
    [self.contentView addSubview:self.contentTextNode];
    
    [self.contentView addSubview:self.underLineNode];
}

- (void)mas_subViews
{
    [_imageNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [_voteBtnNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
        make.top.equalTo(_imageNode);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_nameTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageNode);
        make.left.equalTo(_imageNode.mas_right).offset(10);
        make.right.equalTo(_voteBtnNode.mas_left).offset(-10);
    }];
    
    [_locationTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_nameTextNode);
        make.bottom.equalTo(_imageNode.mas_bottom);
    }];
    
    [_commentReplyAreaNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageNode.mas_bottom).offset(10);
        make.left.equalTo(_nameTextNode);
        make.right.equalTo(_voteBtnNode);
    }];
    
    [_contentTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentReplyAreaNode.mas_bottom).offset(10);
        make.left.equalTo(_nameTextNode);
        make.right.equalTo(_voteBtnNode);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_contentTextNode.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - public
- (void)setupCommentItems:(NSDictionary *)commentItems commmentIds:(NSArray *)commmentIds
{
    _commentItemsDict = commentItems;
    _commentIdsArray = commmentIds;
    _commentItem = commentItems[commmentIds.lastObject];
    
    [_imageNode setImageWithURL:[NSURL URLWithString:_commentItem.user.avatar] placeholder:[UIImage imageNamed:@"defult_pho"]];
    _nameTextNode.text = _commentItem.user.nickname ? _commentItem.user.nickname : @"火星网友";
    _locationTextNode.text = _commentItem.user.location ? _commentItem.user.location : @"火星";
    [_voteBtnNode setTitle:[NSString stringWithFormat:@"%@顶",@(_commentItem.vote)] forState:UIControlStateNormal];
    _contentTextNode.text = _commentItem.content;
    
    //根据是否有子评论，修改布局
    if (_commentIdsArray.count > 1) {
        [_contentTextNode mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_commentReplyAreaNode.mas_bottom).offset(10);
            make.left.equalTo(_nameTextNode);
            make.right.equalTo(_voteBtnNode);
        }];
    }else{
        [_contentTextNode mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageNode.mas_bottom).offset(10);
            make.left.equalTo(_nameTextNode);
            make.right.equalTo(_voteBtnNode);
        }];
    }
    [_commentReplyAreaNode setupCommentItems:_commentItemsDict floors:_commentIdsArray];
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

- (UILabel *)nameTextNode
{
    if (!_nameTextNode) {
        UILabel *nameTextNode = [[UILabel alloc] init];
        nameTextNode.font = [UIFont systemFontOfSize:14];
        nameTextNode.textColor = RGB(186, 177, 161);
        _nameTextNode = nameTextNode;
    }
    return _nameTextNode;
}

- (UILabel *)locationTextNode
{
    if (!_locationTextNode) {
        UILabel *locationTextNode = [[UILabel alloc] init];
        locationTextNode.font = [UIFont systemFontOfSize:12];
        locationTextNode.textColor = RGB(163, 163, 163);
        _locationTextNode = locationTextNode;
    }
    return _locationTextNode;
}

- (UIButton *)voteBtnNode
{
    if (!_voteBtnNode) {
        UIButton *voteBtnNode = [[UIButton alloc] init];
        voteBtnNode.titleLabel.font = [UIFont systemFontOfSize:12];
        [voteBtnNode setTitleColor:RGB(163, 163, 163) forState:UIControlStateNormal];
        voteBtnNode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _voteBtnNode = voteBtnNode;
    }
    return _voteBtnNode;
}

- (NewsCommentReplyAreaNode *)commentReplyAreaNode
{
    if (!_commentReplyAreaNode) {
        NewsCommentReplyAreaNode *commentReplyAreaNode = [[NewsCommentReplyAreaNode alloc] init];
        _commentReplyAreaNode = commentReplyAreaNode;
    }
    return _commentReplyAreaNode;
}

- (UILabel *)contentTextNode
{
    if (!_contentTextNode) {
        UILabel *contentTextNode = [[UILabel alloc] init];
        contentTextNode.numberOfLines = 0;
        contentTextNode.font = [UIFont systemFontOfSize:14];
        contentTextNode.textColor = RGB(50, 50, 50);
        _contentTextNode = contentTextNode;
    }
    return _contentTextNode;
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
