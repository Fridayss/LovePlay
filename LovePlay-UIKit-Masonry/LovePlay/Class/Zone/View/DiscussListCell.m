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
        [self mas_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubNodes
{
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.numberOfLines = 2;
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

- (void)mas_autoLayoutSubViews
{
    [_titleTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_descriptionTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleTextNode.mas_bottom).offset(10);
        make.left.right.equalTo(_titleTextNode);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_descriptionTextNode.mas_bottom).offset(10);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

@end
