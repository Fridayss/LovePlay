//
//  NewsCommentReplyCell.m
//  LovePlay
//
//  Created by weiying on 2017/2/14.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentReplyCell.h"
#import "NewsCommentModel.h"

@interface NewsCommentReplyCell ()
//UI
@property (nonatomic, strong) UILabel *nameTextNode;
@property (nonatomic, strong) UILabel *floorTextNode;
@property (nonatomic, strong) UILabel *contentTextNode;
@property (nonatomic, strong) UIView *underLineNode;
//Data
@property (nonatomic, strong) NewsCommentItem *commentItem;
@property (nonatomic, assign) NSInteger floor;
@end

@implementation NewsCommentReplyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsCommentReplyCell";
    NewsCommentReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsCommentReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    UILabel *nameTextNode = [[UILabel alloc] init];
    nameTextNode.font = [UIFont systemFontOfSize:12];
    nameTextNode.textColor = RGB(138, 138, 138);
    [self.contentView addSubview:nameTextNode];
    _nameTextNode = nameTextNode;
    
    UILabel *floorTextNode = [[UILabel alloc] init];
    floorTextNode.font = [UIFont systemFontOfSize:12];
    floorTextNode.textColor = RGB(64, 64, 64);
    floorTextNode.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:floorTextNode];
    _floorTextNode = floorTextNode;
    
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

- (void)setupCommentItem:(NewsCommentItem *)commentItem floor:(NSInteger)floor
{
    _commentItem = commentItem;
    _floor = floor;
    _nameTextNode.text = [NSString stringWithFormat:@"%@ %@", _commentItem.user.nickname ? _commentItem.user.nickname : @"火星网友", _commentItem.user.location ? _commentItem.user.location : @"火星"];
    _floorTextNode.text = [NSString stringWithFormat:@"%@#", @(_floor).stringValue];
    _contentTextNode.text = _commentItem.content ? _commentItem.content : @"NULL";
}

#pragma mark - layout

- (void)mas_autoLayoutSubViews
{
    [_floorTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(4);
        make.right.equalTo(self.contentView).offset(-4);
    }];
    
    [_nameTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(4);
        make.left.equalTo(self.contentView).offset(4);
        make.right.equalTo(_floorTextNode.mas_left).offset(-10).priorityLow();
    }];
    
    [_contentTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTextNode.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(4);
        make.right.equalTo(self.contentView).offset(-4);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

@end
