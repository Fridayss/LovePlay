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
@property (nonatomic, strong) UILabel *titleTextNode;
@property (nonatomic, strong) UILabel *descriptionTextNode;
@property (nonatomic, strong) UIView *underLineNode;
@end

@implementation DiscussListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DiscussListCell";
    DiscussListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DiscussListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubNodes];
        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubNodes
{
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.font = [UIFont systemFontOfSize:14];
    titleTextNode.textColor = RGB(36, 36, 36);
    [self.contentView addSubview:titleTextNode];
    _titleTextNode = titleTextNode;
    
    UILabel *descriptionTextNode = [[UILabel alloc] init];
    descriptionTextNode.font = [UIFont systemFontOfSize:10];
    descriptionTextNode.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:descriptionTextNode];
    _descriptionTextNode = descriptionTextNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self.contentView addSubview:underLineNode];
    _underLineNode = underLineNode;
}

- (void)setForumThread:(ForumThread *)forumThread
{
    _forumThread = forumThread;
    _titleTextNode.text = forumThread.subject;
    _descriptionTextNode.text = [NSString stringWithFormat:@"%@回复   %@   %@",forumThread.replies, [forumThread.lastpost stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""], forumThread.lastposter];
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _titleTextNode.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    [_titleTextNode setMaxNumberOfLinesToShow:0];
    
    _descriptionTextNode.sd_layout
    .topSpaceToView(_titleTextNode, 10)
    .leftEqualToView(_titleTextNode)
    .rightEqualToView(_titleTextNode)
    .autoHeightRatio(0);
    [_descriptionTextNode setMaxNumberOfLinesToShow:1];

    _underLineNode.sd_layout
    .heightIs(0.5)
    .topSpaceToView(_descriptionTextNode, 10)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
    [self setupAutoHeightWithBottomView:_underLineNode bottomMargin:0];
}


@end
