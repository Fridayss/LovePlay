//
//  DiscussListCell.m
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListCell.h"
#import "DiscussListModel.h"

@interface DiscussListCell ()
//UI
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASTextNode *descriptionTextNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
//Data
@property (nonatomic, strong) ForumThread *forumThread;
@end

@implementation DiscussListCell

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
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    titleTextNode.maximumNumberOfLines = 2;
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
    
    ASTextNode *descriptionTextNode = [[ASTextNode alloc] init];
    [self addSubnode:descriptionTextNode];
    _descriptionTextNode = descriptionTextNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (void)loadData
{
    NSDictionary *titleAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : RGB(36, 36, 36)};
    _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_forumThread.subject attributes:titleAttribute];
    NSDictionary *descriptionAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : RGB(150, 150, 150)};
    _descriptionTextNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@回复   %@   %@",_forumThread.replies, [_forumThread.lastpost stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""], _forumThread.lastposter] attributes:descriptionAttribute];
}

#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _titleTextNode.style.flexGrow = YES;
    _titleTextNode.style.flexShrink = YES;

    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[_titleTextNode, _descriptionTextNode]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:verContentLayout];
    
    ASStackLayoutSpec *verUnderLineLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[insetLayout, _underLineNode]];
    return verUnderLineLayout;
}


@end
