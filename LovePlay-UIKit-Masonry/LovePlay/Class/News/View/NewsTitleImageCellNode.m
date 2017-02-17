//
//  NewsTitleImageCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsTitleImageCellNode.h"
#import "NewsListInfoModel.h"

@interface NewsTitleImageCellNode ()
//UI
@property (nonatomic, strong) UILabel *titleTextNode;
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UIView *underLineNode;
@end

@implementation NewsTitleImageCellNode

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsTitleImageCellNode";
    NewsTitleImageCellNode *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsTitleImageCellNode alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubnodes];
//        [self sd_autoLayoutSubViews];
        [self mas_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.numberOfLines = 2;
    titleTextNode.font = [UIFont systemFontOfSize:16];
    titleTextNode.textColor = RGB(36, 36, 36);
    [self.contentView addSubview:titleTextNode];
    _titleTextNode = titleTextNode;
    
    UIImageView *imageNode = [[UIImageView alloc] init];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self.contentView addSubview:underLineNode];
    _underLineNode = underLineNode;

}

- (void)setListInfoModel:(NewsListInfoModel *)listInfoModel
{
    _listInfoModel = listInfoModel;
    _imageNode.imageURL = [NSURL URLWithString:listInfoModel.imgsrc.firstObject];
    _titleTextNode.text = listInfoModel.title;
}

#pragma mark - layout
- (void)mas_autoLayoutSubViews
{
    [_titleTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_imageNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(120);
        make.top.equalTo(_titleTextNode.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_imageNode.mas_bottom).offset(10);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}


@end
