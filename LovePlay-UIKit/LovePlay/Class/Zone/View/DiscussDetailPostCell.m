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
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *nameTextNode;
@property (nonatomic, strong) UILabel *timeTextNode;
@property (nonatomic, strong) UILabel *floorTextNode;
@property (nonatomic, strong) UILabel *contentTextNode;
@property (nonatomic, strong) UIView *underLineNode;
//Data
@property (nonatomic, strong) DiscuzPost *post;
@property (nonatomic, assign) NSInteger floor;
@end

@implementation DiscussDetailPostCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DiscussDetailPostCell";
    DiscussDetailPostCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DiscussDetailPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubnodes];
        [self mas_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UIImageView *imageNode = [[UIImageView alloc] init];
    imageNode.image = [UIImage imageNamed:@"defult_pho"];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *nameTextNode = [[UILabel alloc] init];
    nameTextNode.font = [UIFont systemFontOfSize:14];
    nameTextNode.textColor = RGB(186, 177, 161);
    [self.contentView addSubview:nameTextNode];
    _nameTextNode = nameTextNode;
    
    UILabel *timeTextNode = [[UILabel alloc] init];
    timeTextNode.font = [UIFont systemFontOfSize:12];
    timeTextNode.textColor = RGB(163, 163, 163);
    [self.contentView addSubview:timeTextNode];
    _timeTextNode = timeTextNode;
    
    UILabel *floorTextNode = [[UILabel alloc] init];
    floorTextNode.font = [UIFont systemFontOfSize:12];
    floorTextNode.textColor = RGB(163, 163, 163);
    floorTextNode.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:floorTextNode];
    _floorTextNode = floorTextNode;
    
    UILabel *contentTextNode = [[UILabel alloc] init];
    contentTextNode.numberOfLines = 0;
    contentTextNode.font = [UIFont systemFontOfSize:14];
    contentTextNode.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:contentTextNode];
    _contentTextNode = contentTextNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self.contentView addSubview:underLineNode];
    _underLineNode = underLineNode;
    
//    nameTextNode.backgroundColor = RandomRGB;
//    timeTextNode.backgroundColor = RandomRGB;
//    floorTextNode.backgroundColor = RandomRGB;
}

- (void)setupPost:(DiscuzPost *)post floor:(NSInteger)floor
{
    _post = post;
    _floor = floor;
    _nameTextNode.text = post.author;
    _timeTextNode.text = [post.dateline stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    _floorTextNode.text = [NSString stringWithFormat:@"%@#", @(floor).stringValue];
    _contentTextNode.text = post.message;
}

#pragma mark - layout
- (void)mas_autoLayoutSubViews
{
    [_imageNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.top.left.equalTo(self.contentView).offset(10);
    }];
    
    [_floorTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(_imageNode);
    }];

    [_nameTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageNode.mas_right).offset(10);
        make.centerY.equalTo(_imageNode);
    }];
    
    //放在name和floor之间，设置左右位置，并控制优先级
    [_timeTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameTextNode.mas_right).offset(10).priorityMedium();
        make.right.equalTo(_floorTextNode.mas_left).offset(-10).priorityLow();
        make.centerY.equalTo(_imageNode);
    }];
    
    [_contentTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageNode.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_contentTextNode.mas_bottom).offset(10);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

@end
