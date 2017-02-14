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
    
    [self sd_autoLayoutSubViews];

}

- (void)addSubnodes
{
    NSMutableArray *replyNodeArray = [NSMutableArray array];
    for (NSInteger i = 0; i < _floors.count - 1; i ++) {
        NSString *floor = _floors[i];
        NewsCommentItem *commentItem = _commentItemsDict[floor];
        NewsCommentReplyNode *commentReplyNode = [[NewsCommentReplyNode alloc] initWithcommentItem:commentItem floor:i + 1];
        [self addSubview:commentReplyNode];
        [replyNodeArray addObject:commentReplyNode];
    }
    
    if (replyNodeArray.count > 0) {
        [replyNodeArray enumerateObjectsUsingBlock:^(NewsCommentReplyNode *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj sd_clearAutoLayoutSettings];
            obj.hidden = YES;
        }];
    }
    _replyNodeArray = [replyNodeArray copy];
    
    if (replyNodeArray.count > 0) {
        self.fixedHeight = nil;
        self.fixedWidth = nil;

    }else{
        self.fixedHeight = @(0);
        self.fixedWidth = @(0);
    }
    
    
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    if (_replyNodeArray.count > 0) {
        UIView *lastTopView = self;
        for (NSInteger i = 0; i < _replyNodeArray.count; i ++) {
            NewsCommentReplyNode *commentReplyNode = _replyNodeArray[i];
            
            commentReplyNode.sd_layout
            .topSpaceToView(lastTopView, 0)
            .leftEqualToView(self)
            .rightEqualToView(self);
            
            lastTopView = commentReplyNode;
        }
        [self setupAutoHeightWithBottomView:lastTopView bottomMargin:10];
    }
    
//    [self setupAutoMarginFlowItems:_replyNodeArray withPerRowItemsCount:1 itemWidth:self.width verticalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
}

@end
