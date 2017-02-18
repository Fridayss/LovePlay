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
        [self loadData];
        [self mas_autoLayoutSubViews];
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
////    NSLog(@"layout-frame -- %@", NSStringFromCGRect(self.frame));
//    [self mas_autoLayoutSubViews];
//}

- (void)addSubnodes
{
    UILabel *nameTextNode = [[UILabel alloc] init];
    nameTextNode.font = [UIFont systemFontOfSize:12];
    nameTextNode.textColor = RGB(138, 138, 138);
    [self addSubview:nameTextNode];
    _nameTextNode = nameTextNode;
    
    UILabel *floorTextNode = [[UILabel alloc] init];
    floorTextNode.font = [UIFont systemFontOfSize:12];
    floorTextNode.textColor = RGB(64, 64, 64);
    floorTextNode.textAlignment = NSTextAlignmentRight;
    [self addSubview:floorTextNode];
    _floorTextNode = floorTextNode;
    
    UILabel *contentTextNode = [[UILabel alloc] init];
    contentTextNode.numberOfLines = 0;
    contentTextNode.font = [UIFont systemFontOfSize:14];
    contentTextNode.textColor = RGB(50, 50, 50);
    [self addSubview:contentTextNode];
    _contentTextNode = contentTextNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self addSubview:underLineNode];
    _underLineNode = underLineNode;
}

- (void)loadData
{
    _nameTextNode.text = [NSString stringWithFormat:@"%@ %@", _commentItem.user.nickname ? _commentItem.user.nickname : @"火星网友", _commentItem.user.location ? _commentItem.user.location : @"火星"];
    _floorTextNode.text = [NSString stringWithFormat:@"%@#", @(_floor).stringValue];
    _contentTextNode.text = _commentItem.content ? _commentItem.content : @"NULL";
}

#pragma mark - layout
- (void)mas_autoLayoutSubViews
{
    [_floorTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(4);
        make.right.equalTo(self).offset(-4);
    }];
    
    [_nameTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(4);
        make.left.equalTo(self).offset(4);
        make.right.equalTo(_floorTextNode.mas_left).offset(-10).priorityLow();
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

@end
