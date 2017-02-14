//
//  DiscussDetailPostCell.m
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussDetailPostCell.h"
#import "DiscussDetailModel.h"

@interface DiscussDetailPostCell ()
//UI
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *nameTextNode;
@property (nonatomic, strong) ASTextNode *timeTextNode;
@property (nonatomic, strong) ASTextNode *floorTextNode;
@property (nonatomic, strong) ASTextNode *contentTextNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
//Data
@property (nonatomic, strong) DiscuzPost *post;
@property (nonatomic, assign) NSInteger floor;
@end

@implementation DiscussDetailPostCell

- (instancetype)initWithPost:(DiscuzPost *)post floor:(NSInteger)floor
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _post = post;
        _floor = floor;
        [self addSubnodes];
        [self loadData];
    }
    return self;
}

- (void)addSubnodes
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.image = [UIImage imageNamed:@"defult_pho"];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
    
    ASTextNode *nameTextNode = [[ASTextNode alloc] init];
    [self addSubnode:nameTextNode];
    _nameTextNode = nameTextNode;
    
    ASTextNode *timeTextNode = [[ASTextNode alloc] init];
    [self addSubnode:timeTextNode];
    _timeTextNode = timeTextNode;
    
    ASTextNode *floorTextNode = [[ASTextNode alloc] init];
    [self addSubnode:floorTextNode];
    _floorTextNode = floorTextNode;
    
    ASTextNode *contentTextNode = [[ASTextNode alloc] init];
    contentTextNode.maximumNumberOfLines = 0;
    [self addSubnode:contentTextNode];
    _contentTextNode = contentTextNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (void)loadData
{
    NSDictionary *nameAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: RGB(186, 177, 161)};
    _nameTextNode.attributedText = [[NSAttributedString alloc] initWithString:_post.author attributes:nameAttribute];
    NSDictionary *timeAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: RGB(163, 163, 163)};
    _timeTextNode.attributedText = [[NSAttributedString alloc] initWithString:[_post.dateline stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] attributes:timeAttribute];
    NSDictionary *floorAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: RGB(163, 163, 163)};
    _floorTextNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@#", @(_floor).stringValue] attributes:floorAttribute];
    NSDictionary *contentAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: RGB(50, 50, 50)};
    _contentTextNode.attributedText = [[NSAttributedString alloc] initWithString:_post.message attributes:contentAttribute];
}

#pragma mark - layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.style.preferredSize = CGSizeMake(30, 30);
    _contentTextNode.style.flexGrow = YES;
    _contentTextNode.style.flexShrink = YES;
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    ASStackLayoutSpec *horUserLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_imageNode, _nameTextNode, _timeTextNode]];
    
    ASStackLayoutSpec *horTopLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsCenter children:@[horUserLayout, _floorTextNode]];
    
    ASStackLayoutSpec *verContentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[horTopLayout, _contentTextNode]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:verContentLayout];
    
    ASStackLayoutSpec *verUnderLindeLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[insetLayout, _underLineNode]];
    
    return verUnderLindeLayout;
}

@end
