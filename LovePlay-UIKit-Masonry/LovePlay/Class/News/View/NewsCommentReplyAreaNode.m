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
@property (nonatomic, strong) NSArray *replyNodeArray;
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

- (void)setupCommentItems:(NSDictionary *)commentItems floors:(NSArray *)floors
{
    _commentItemsDict = commentItems;
    _floors = floors;
    
//    [self removeAllSubviews];

    [self addSubnodes];
    
    [self mas_autoLayoutSubViews];

}

- (void)addSubnodes
{
    UIView *lastTopView = nil;
    NSMutableArray *replyNodeArray = [NSMutableArray array];
    for (NSInteger i = 0; i < _floors.count - 1; i ++) {
        NSString *floor = _floors[i];
        NewsCommentItem *commentItem = _commentItemsDict[floor];
        NewsCommentReplyNode *commentReplyNode = [[NewsCommentReplyNode alloc] initWithcommentItem:commentItem floor:i + 1];
        [self addSubview:commentReplyNode];
        [replyNodeArray addObject:commentReplyNode];
        
        if (0 == i) {
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
        lastTopView = commentReplyNode;
    }
    
    _replyNodeArray = [replyNodeArray copy];
}

#pragma mark - layout
- (void)mas_autoLayoutSubViews
{

}

@end
