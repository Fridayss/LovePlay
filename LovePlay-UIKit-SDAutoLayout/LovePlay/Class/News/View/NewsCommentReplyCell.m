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
        [self sd_autoLayoutSubViews];
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
- (void)sd_autoLayoutSubViews
{
    _floorTextNode.sd_layout
    .topSpaceToView(self.contentView, 4)
    .rightSpaceToView(self.contentView, 4)
    .autoHeightRatio(0);
    [_floorTextNode setMaxNumberOfLinesToShow:1];
    [_floorTextNode setSingleLineAutoResizeWithMaxWidth:50];
    
    _nameTextNode.sd_layout
    .topSpaceToView(self.contentView, 4)
    .leftSpaceToView(self.contentView, 4)
    .rightSpaceToView(_floorTextNode, 5)
    .autoHeightRatio(0);
    [_nameTextNode setMaxNumberOfLinesToShow:1];
    
    _contentTextNode.sd_layout
    .topSpaceToView(_nameTextNode, 6)
    .leftEqualToView(_nameTextNode)
    .rightEqualToView(_floorTextNode)
    .autoHeightRatio(0);
    [_contentTextNode setMaxNumberOfLinesToShow:0];
    
    _underLineNode.sd_layout
    .heightIs(0.5)
    .topSpaceToView(_contentTextNode, 10)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
    [self setupAutoHeightWithBottomView:_underLineNode bottomMargin:0];
}


@end
