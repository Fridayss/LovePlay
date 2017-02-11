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
        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UILabel *nameTextNode = [[UILabel alloc] init];
    nameTextNode.text = [NSString stringWithFormat:@"%@ %@", _commentItem.user.nickname ? _commentItem.user.nickname : @"火星网友", _commentItem.user.location ? _commentItem.user.location : @"火星"];
    [self addSubview:nameTextNode];
    _nameTextNode = nameTextNode;
    
    UILabel *floorTextNode = [[UILabel alloc] init];
    floorTextNode.text = @(_floor).stringValue;
    [self addSubview:floorTextNode];
    _floorTextNode = floorTextNode;
    
    UILabel *contentTextNode = [[UILabel alloc] init];
    contentTextNode.numberOfLines = 0;
    contentTextNode.text = _commentItem.content ? _commentItem.content : @"NULL";
    [self addSubview:contentTextNode];
    _contentTextNode = contentTextNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:underLineNode];
    _underLineNode = underLineNode;
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _floorTextNode.sd_layout
    .widthIs(50)
    .heightIs(20)
    .topSpaceToView(self, 4)
    .rightSpaceToView(self, 4);
    
    _nameTextNode.sd_layout
    .topSpaceToView(self, 4)
    .leftSpaceToView(self, 4)
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
    .leftEqualToView(self)
    .rightEqualToView(self);
    
    [self setupAutoHeightWithBottomView:_underLineNode bottomMargin:0];
}

@end
