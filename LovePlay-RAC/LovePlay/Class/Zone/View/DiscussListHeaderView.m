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
//UI
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *titleTextLabel;
@property (nonatomic, strong) UILabel *descriptionTextLabel;
//Data
@property (nonatomic, strong) DiscussImageModel *imageModel;
@end

@implementation DiscussListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubnodes];
        [self mas_subViews];
    }
    return self;
}

- (void)addSubnodes
{
    [self addSubview:self.imageNode];
    
    [self addSubview:self.titleTextLabel];
    
    [self addSubview:self.descriptionTextLabel];
}

- (void)mas_subViews
{
    [_imageNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_descriptionTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.right.equalTo(self).offset(-10);
    }];
    
    [_titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_descriptionTextLabel);
        make.bottom.equalTo(_descriptionTextLabel.mas_top).offset(-5);
    }];
}

#pragma mark - public
- (void)setupImageModel:(DiscussImageModel *)imageModel
{
    _imageModel = imageModel;
    _imageNode.imageURL = [NSURL URLWithString:imageModel.bannerUrl];
    _titleTextLabel.text = imageModel.modelName;
    _descriptionTextLabel.text = [NSString stringWithFormat:@"今日：%@",imageModel.todayPosts];
}

#pragma mark - setter / getter
- (UIImageView *)imageNode
{
    if (!_imageNode) {
        UIImageView *imageNode = [[UIImageView alloc] init];
        imageNode.contentMode = UIViewContentModeScaleAspectFill;
        imageNode.clipsToBounds = YES;
        _imageNode = imageNode;
    }
    return _imageNode;
}


- (UILabel *)titleTextLabel
{
    if (!_titleTextLabel) {
        UILabel *titleTextLabel = [[UILabel alloc] init];
        titleTextLabel.font = [UIFont systemFontOfSize:18];
        titleTextLabel.textColor = [UIColor whiteColor];
        _titleTextLabel = titleTextLabel;
    }
    return _titleTextLabel;
}

- (UILabel *)descriptionTextLabel
{
    if (!_descriptionTextLabel) {
        UILabel *descriptionTextLabel = [[UILabel alloc] init];
        descriptionTextLabel.font = [UIFont systemFontOfSize:12];
        descriptionTextLabel.textColor = [UIColor whiteColor];
        _descriptionTextLabel = descriptionTextLabel;
    }
    return _descriptionTextLabel;
}


@end
