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
        [self sd_autoLayoutSubViews];
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
    contentTextNode.font = [UIFont systemFontOfSize:14];
    contentTextNode.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:contentTextNode];
    _contentTextNode = contentTextNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self.contentView addSubview:underLineNode];
    _underLineNode = underLineNode;
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
- (void)sd_autoLayoutSubViews
{
    _imageNode.sd_layout
    .widthIs(30)
    .heightIs(30)
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10);
    
    _floorTextNode.sd_layout
//    .widthIs(30) //可以使用setSingleLineAutoResizeWithMaxWidth，代替label写死的宽度
    .rightSpaceToView(self.contentView, 10)
    .centerYEqualToView(_imageNode)
    .autoHeightRatio(0);
    [_floorTextNode setMaxNumberOfLinesToShow:1];
    [_floorTextNode setSingleLineAutoResizeWithMaxWidth:50];
    
    _nameTextNode.sd_layout
    .leftSpaceToView(_imageNode, 10)
//    .rightSpaceToView(_timeTextNode, 10)
    .centerYEqualToView(_imageNode) //想要centerY生效，必须调用autoHeightRatio获取label高度
    .autoHeightRatio(0);
    [_nameTextNode setMaxNumberOfLinesToShow:1];
    [_nameTextNode setSingleLineAutoResizeWithMaxWidth:180];

    _timeTextNode.sd_layout
    .leftSpaceToView(_nameTextNode, 10)
    .rightSpaceToView(_floorTextNode, 10)
    .centerYEqualToView(_imageNode)
    .autoHeightRatio(0);
    [_timeTextNode setMaxNumberOfLinesToShow:1];

    _contentTextNode.sd_layout
    .topSpaceToView(_imageNode, 10)
    .leftSpaceToView(self.contentView , 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_contentTextNode setMaxNumberOfLinesToShow:0];
    
    _underLineNode.sd_layout
    .heightIs(0.5)
    .topSpaceToView(_contentTextNode, 10)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
    [self setupAutoHeightWithBottomView:_underLineNode bottomMargin:0];
}

@end
