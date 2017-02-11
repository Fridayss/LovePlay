//
//  RecommendImageInfoCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "RecommendImageInfoCellNode.h"
#import "RecommendImageInfoModel.h"

@interface RecommendImageInfoCellNode ()
@property (nonatomic, strong) RecommendImageInfoModel *imageInfoModel;
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *titleTextNode;
@end

@implementation RecommendImageInfoCellNode

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubnodes];
        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UIImageView *imageNode = [[UIImageView alloc] init];
    imageNode.userInteractionEnabled = NO;
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [self.contentView addSubview:titleTextNode];
    _titleTextNode = titleTextNode;
}

- (void)setupImageInfoModel:(RecommendImageInfoModel *)imageInfoModel
{
    _imageInfoModel = imageInfoModel;
    _imageNode.imageURL = [NSURL URLWithString:_imageInfoModel.imgUrl];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setAlignment:NSTextAlignmentCenter];
    NSDictionary *attri = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraph};
    _titleTextNode.attributedText = [[NSAttributedString alloc] initWithString:_imageInfoModel.title attributes:attri];
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _imageNode.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    _titleTextNode.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .autoHeightRatio(0);
    [_titleTextNode setMaxNumberOfLinesToShow:1];
}

//- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
//{
//    _imageNode.style.preferredSize = CGSizeMake(267, constrainedSize.max.width);
//    _titleTextNode.style.flexShrink = 1.0;
//    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsStretch children:@[_titleTextNode]];
//    ASOverlayLayoutSpec *overlayLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_imageNode overlay:verStackLayout];
//    return overlayLayout;
//}

@end
