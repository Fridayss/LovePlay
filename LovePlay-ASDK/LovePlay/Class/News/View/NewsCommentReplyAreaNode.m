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

- (instancetype)initWithcommentItems:(NSDictionary *)commentItems floors:(NSArray *)floors
{
    self = [super init];
    if (self) {
        self.backgroundColor = RGB(248, 249, 241);
        _commentItemsDict = commentItems;
        _floors = floors;
        [self addSubnodes];
    }
    return self;
}

- (void)didLoad
{
    [super didLoad];
    self.layer.borderColor = RGB(218, 218, 218).CGColor;
    self.layer.borderWidth = 0.5;
}

- (void)addSubnodes
{
    NSMutableArray *replyNodeArray = [NSMutableArray array];
    for (NSInteger i = 0; i < _floors.count - 1; i ++) {
        NSString *floor = _floors[i];
        NewsCommentItem *commentItem = _commentItemsDict[floor];
        NewsCommentReplyNode *commentReplyNode = [[NewsCommentReplyNode alloc] initWithcommentItem:commentItem floor:i + 1];
        [self addSubnode:commentReplyNode];
        [replyNodeArray addObject:commentReplyNode];
    }
    _replyNodeArray = [replyNodeArray copy];
}

#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    ASStackLayoutSpec *verLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:_replyNodeArray];
    return verLayout;
}

@end
