//
//  NewsCommentCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentCellNode.h"
#import "NewsCommentModel.h"
//#import "NewsCommentReplyAreaNode.h"
//#import "NewsCommentReplyView.h"

@interface NewsCommentCellNode ()
//UI
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *nameTextNode;
@property (nonatomic, strong) UILabel *locationTextNode;
@property (nonatomic, strong) UIButton *voteBtnNode;
@property (nonatomic, strong) UILabel *contentTextNode;
@property (nonatomic, strong) UIView *underLineNode;
//@property (nonatomic, strong) NewsCommentReplyAreaNode *commentReplyAreaNode;
//@property (nonatomic, strong) NewsCommentReplyView *commentReplyView;
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
        [self mas_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UIImageView *imageNode = [[UIImageView alloc] init];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *nameTextNode = [[UILabel alloc] init];
    nameTextNode.font = [UIFont systemFontOfSize:14];
    nameTextNode.textColor = RGB(186, 177, 161);
    [self.contentView addSubview:nameTextNode];
    _nameTextNode = nameTextNode;
    
    UILabel *locationTextNode = [[UILabel alloc] init];
    locationTextNode.font = [UIFont systemFontOfSize:12];
    locationTextNode.textColor = RGB(163, 163, 163);
    [self.contentView addSubview:locationTextNode];
    _locationTextNode = locationTextNode;
    
    UIButton *voteBtnNode = [[UIButton alloc] init];
    voteBtnNode.titleLabel.font = [UIFont systemFontOfSize:12];
    [voteBtnNode setTitleColor:RGB(163, 163, 163) forState:UIControlStateNormal];
    voteBtnNode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.contentView addSubview:voteBtnNode];
    _voteBtnNode = voteBtnNode;

//    NewsCommentReplyAreaNode *commentReplyAreaNode = [[NewsCommentReplyAreaNode alloc] init];
//    [self.contentView addSubview:commentReplyAreaNode];
//    _commentReplyAreaNode = commentReplyAreaNode;
    
//    NewsCommentReplyView *commentReplyView = [[NewsCommentReplyView alloc] init];
//    [self.contentView addSubview:commentReplyView];
//    _commentReplyView = commentReplyView;
    
    UILabel *contentTextNode = [[UILabel alloc] init];
    contentTextNode.numberOfLines = 0;
    contentTextNode.font = [UIFont systemFontOfSize:14];
    contentTextNode.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:contentTextNode];
    _contentTextNode = contentTextNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self.contentView addSubview:underLineNode];
    _underLineNode = underLineNode;

}

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
    
//    [_commentReplyView setupCommentItems:_commentItemsDict floors:_commentIdsArray didReloadBlock:^(CGFloat contentSizeHeight) {
//        _commentReplyView.sd_layout.heightIs(contentSizeHeight);
//        [self updateLayout];
//    }];
//    [_commentReplyAreaNode setupCommentItems:_commentItemsDict floors:_commentIdsArray];
}

#pragma mark - layout

- (void)mas_autoLayoutSubViews
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
        make.left.mas_equalTo(_imageNode.mas_right).offset(10);
        make.right.mas_equalTo(_voteBtnNode.mas_left).offset(-10);
    }];
    
    [_locationTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_nameTextNode);
        make.bottom.mas_equalTo(_imageNode.mas_bottom);
    }];
    
    [_contentTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageNode.mas_bottom).offset(10);
        make.left.equalTo(_nameTextNode);
        make.right.equalTo(_voteBtnNode);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(_contentTextNode.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

@end
