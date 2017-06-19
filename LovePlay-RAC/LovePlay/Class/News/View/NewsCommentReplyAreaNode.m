//
//  NewsCommentReplyAreaNode.m
//  LovePlay
//
//  Created by weiying on 2017/2/6.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentReplyAreaNode.h"
#import "NewsCommentModel.h"
#import "NewsCommentReplyNode.h"

@interface NewsCommentReplyAreaNode ()
//UI
@property (nonatomic, strong) NewsCommentReplyNode *commentReplyNode;
//Data
@property (nonatomic, strong) NSDictionary *commentItemsDict;
@property (nonatomic, strong) NSArray *floors;
@end

@implementation NewsCommentReplyAreaNode

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(248, 249, 241);
        self.layer.borderColor = RGB(218, 218, 218).CGColor;
        self.layer.borderWidth = 0.5;
    }
    return self;
}

#pragma mark - private
- (void)addSubnodes
{
    UIView *lastTopView = nil;
    for (NSInteger i = 0; i < _floors.count - 1; i ++) {
        NSString *floor = _floors[i];
        NewsCommentItem *commentItem = _commentItemsDict[floor];
        NewsCommentReplyNode *commentReplyNode = [[NewsCommentReplyNode alloc] initWithcommentItem:commentItem floor:i + 1];
        [self addSubview:commentReplyNode];
        
        //mas_layout
        [self mas_subViewsWithIndex:i commentReplyNode:commentReplyNode lastTopView:lastTopView];
        
        lastTopView = commentReplyNode;
    }
}

- (void)mas_subViewsWithIndex:(NSInteger)index commentReplyNode:(NewsCommentReplyNode *)commentReplyNode lastTopView:(UIView *)lastTopView
{
    if (0 == index) {
        [commentReplyNode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.right.equalTo(self);
        }];
    }else{
        [commentReplyNode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastTopView.mas_bottom);
            make.left.right.equalTo(self);
        }];
    }
    
    if (index == _floors.count - 2) {
        [commentReplyNode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
        }];
    }
}

#pragma mark - public
- (void)setupCommentItems:(NSDictionary *)commentItems floors:(NSArray *)floors
{
    _commentItemsDict = commentItems;
    _floors = floors;
    
    [self removeAllSubviews];
    
    [self addSubnodes];
}

@end
