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
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        
    }
    return self;
}

- (void)setupCommentItems:(NSDictionary *)commentItems floors:(NSArray *)floors
{
    _commentItemsDict = commentItems;
    _floors = floors;
    
    [self removeAllSubviews];
    
    [self addSubnodes];
    
    [self sd_autoLayoutSubViews];
    
    if (floors.count > 1) {
        self.fixedHeight = nil;
        self.fixedWidth = nil;
        
    }else{
        self.fixedHeight = @(0);
        self.fixedWidth = @(0);
    }
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
    _replyNodeArray = [replyNodeArray copy];
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    [self setupAutoMarginFlowItems:_replyNodeArray withPerRowItemsCount:1 itemWidth:self.width verticalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
}

@end
