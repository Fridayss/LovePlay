//
//  DiscussListHeaderView.m
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListHeaderView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "DiscussImageModel.h"

@interface DiscussListHeaderView ()
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASTextNode *descriptionTextNode;
@end

@implementation DiscussListHeaderView

- (void)setImageModel:(DiscussImageModel *)imageModel
{
    _imageModel = imageModel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
