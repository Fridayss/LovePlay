//
//  DiscussListTopCell.m
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListTopCell.h"
#import "DiscussListModel.h"

@interface DiscussListTopCell ()
//UI
@property (nonatomic, strong) ASButtonNode *topBtnNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
//Data
@property (nonatomic, strong) ForumThread *forumThread;
@end

@implementation DiscussListTopCell

- (instancetype)initWithForumThread:(ForumThread *)forumThread
{
    self = [super init];
    if (self) {
        _forumThread = forumThread;
        [self addSubnodes];
        [self loadData];
    }
    return self;
}

- (void)addSubnodes
{
    ASButtonNode *topBtnNode = [[ASButtonNode alloc] init];
    topBtnNode.cornerRadius = 5;
    topBtnNode.clipsToBounds = YES;
    topBtnNode.borderWidth = 1;
    topBtnNode.borderColor = RGB(236, 126, 150).CGColor;
    [self addSubnode:topBtnNode];
    _topBtnNode = topBtnNode;
    
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (void)loadData
{
    [_topBtnNode setTitle:@"置顶帖" withFont:[UIFont systemFontOfSize:12] withColor:RGB(236, 126, 150) forState:ASControlStateNormal];
    NSDictionary *titleAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : RGB(36, 36, 36)};
    _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_forumThread.subject attributes:titleAttribute];
}

#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _topBtnNode.style.preferredSize = CGSizeMake(45, 25);
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    ASStackLayoutSpec *horContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_topBtnNode, _titleTextNode]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:horContentLayout];
    
    ASStackLayoutSpec *verUnderLineLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[insetLayout, _underLineNode]];
    return verUnderLineLayout;
}
@end
