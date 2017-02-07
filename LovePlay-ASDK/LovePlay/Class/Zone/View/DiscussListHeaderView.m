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
@property (nonatomic, strong) UILabel *titleTextLabel;
@property (nonatomic, strong) UILabel *descriptionTextLabel;

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
    
    ASDisplayNode *titleTextNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        UILabel *titleTextLabel = [[UILabel alloc] init];
        titleTextLabel.font = [UIFont systemFontOfSize:18];
        titleTextLabel.textColor = [UIColor whiteColor];
        _titleTextLabel = titleTextLabel;
        return titleTextLabel;
    }];
    [self addSubnode:titleTextNode];
    
    ASDisplayNode *descriptionTextNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        UILabel *descriptionTextLabel = [[UILabel alloc] init];
        descriptionTextLabel.font = [UIFont systemFontOfSize:12];
        descriptionTextLabel.textColor = [UIColor whiteColor];
        _descriptionTextLabel = descriptionTextLabel;
        return descriptionTextLabel;
    }];
    [self addSubnode:descriptionTextNode];
}

- (void)setImageModel:(DiscussImageModel *)imageModel
{
    _imageModel = imageModel;
    _imageNode.URL = [NSURL URLWithString:imageModel.bannerUrl];
    _titleTextLabel.text = imageModel.modelName;
    _descriptionTextLabel.text = [NSString stringWithFormat:@"今日：%@",imageModel.todayPosts];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageNode.frame = self.bounds;
    _titleTextLabel.frame = CGRectMake(10, self.height - 60, self.width - 20, 30);
    _descriptionTextLabel.frame = CGRectMake(10, self.height - 30, self.width - 20, 30);
}

@end
