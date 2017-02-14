//
//  DiscussListHeaderView.m
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListHeaderView.h"
#import "DiscussImageModel.h"

@interface DiscussListHeaderView ()

@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASTextNode *descriptionTextNode;

@end

@implementation DiscussListHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubnodes];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *titleTextNode = [[ASTextNode alloc] init];
    [self addSubnode:titleTextNode];
    _titleTextNode = titleTextNode;
    
    ASTextNode *descriptionTextNode = [[ASTextNode alloc] init];
    [self addSubnode:descriptionTextNode];
    _descriptionTextNode = descriptionTextNode;
}

- (void)setImageModel:(DiscussImageModel *)imageModel
{
    _imageModel = imageModel;
    _imageNode.URL = [NSURL URLWithString:imageModel.bannerUrl];
    NSDictionary *titleAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSDictionary *descriptionAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor whiteColor]};
    _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:imageModel.modelName attributes:titleAttribute];
    _descriptionTextNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"今日：%@",imageModel.todayPosts] attributes:descriptionAttribute];
}

#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 150);
    
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsStart children:@[_titleTextNode, _descriptionTextNode]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(INFINITY, 10, 10, 10) child:verContentLayout];
    
    ASOverlayLayoutSpec *contentOverLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_imageNode overlay:insetLayout];
    
    return contentOverLayout;
}

@end
