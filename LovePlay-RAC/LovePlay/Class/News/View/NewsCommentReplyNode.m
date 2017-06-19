//
//  NewsCommentReplyNode.m
//  LovePlay
//
//  Created by weiying on 2017/2/6.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentReplyNode.h"
#import "NewsCommentModel.h"

@interface NewsCommentReplyNode ()
//UI
@property (nonatomic, strong) UILabel *nameTextNode;
@property (nonatomic, strong) UILabel *floorTextNode;
@property (nonatomic, strong) UILabel *contentTextNode;
@property (nonatomic, strong) UIView *underLineNode;
//Data
@property (nonatomic, strong) NewsCommentItem *commentItem;
@property (nonatomic, assign) NSInteger floor;
@end

@implementation NewsCommentReplyNode

- (instancetype)initWithcommentItem:(NewsCommentItem *)commentItem floor:(NSInteger)floor
{
    self = [super init];
    if (self) {
        _commentItem = commentItem;
        _floor = floor;
        [self addSubnodes];
        [self mas_subViews];
        [self loadData];
    }
    return self;
}

#pragma mark - private
- (void)addSubnodes
{
    [self addSubview:self.nameTextNode];
    
    [self addSubview:self.floorTextNode];
    
    [self addSubview:self.contentTextNode];
    
    [self addSubview:self.underLineNode];
}

- (void)mas_subViews
{
    [_floorTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30).priorityLow();
        make.top.equalTo(self).offset(4);
        make.right.equalTo(self).offset(-4);
    }];
    
    [_nameTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(4);
        make.left.equalTo(self).offset(4);
        make.right.equalTo(_floorTextNode.mas_left).offset(-10);
    }];
    
    [_contentTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTextNode.mas_bottom).offset(5);
        make.left.equalTo(self).offset(4);
        make.right.equalTo(self).offset(-4);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_contentTextNode.mas_bottom).offset(4);
        make.left.bottom.right.equalTo(self);
    }];
}

- (void)loadData
{
    _nameTextNode.text = [NSString stringWithFormat:@"%@ %@", _commentItem.user.nickname ? _commentItem.user.nickname : @"火星网友", _commentItem.user.location ? _commentItem.user.location : @"火星"];
    _floorTextNode.text = [NSString stringWithFormat:@"%@#", @(_floor).stringValue];
    _contentTextNode.text = _commentItem.content ? _commentItem.content : @"NULL";
}

#pragma mark - setter / getter
- (UILabel *)nameTextNode
{
    if (!_nameTextNode) {
        UILabel *nameTextNode = [[UILabel alloc] init];
        nameTextNode.font = [UIFont systemFontOfSize:12];
        nameTextNode.textColor = RGB(138, 138, 138);
        _nameTextNode = nameTextNode;
    }
    return _nameTextNode;
}

- (UILabel *)floorTextNode
{
    if (!_floorTextNode) {
        UILabel *floorTextNode = [[UILabel alloc] init];
        floorTextNode.font = [UIFont systemFontOfSize:12];
        floorTextNode.textColor = RGB(64, 64, 64);
        floorTextNode.textAlignment = NSTextAlignmentRight;
        _floorTextNode = floorTextNode;
    }
    return _floorTextNode;
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
