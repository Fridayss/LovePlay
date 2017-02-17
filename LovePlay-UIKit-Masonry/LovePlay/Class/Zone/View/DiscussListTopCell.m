//
//  DiscussListTopCell.m
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListTopCell.h"
#import "DiscussListModel.h"

@interface DiscussListTopCell ()
@property (nonatomic, strong) UILabel *topTextNode;
@property (nonatomic, strong) UILabel *titleTextNode;
@property (nonatomic, strong) UIView *underLineNode;
@end

@implementation DiscussListTopCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DiscussListTopCell";
    DiscussListTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DiscussListTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    UILabel *topTextNode = [[UILabel alloc] init];
    topTextNode.font = [UIFont systemFontOfSize:12];
    topTextNode.textAlignment = NSTextAlignmentCenter;
    topTextNode.textColor = RGB(236, 126, 150);
    topTextNode.layer.cornerRadius = 5;
    topTextNode.layer.masksToBounds = YES;
    topTextNode.layer.borderWidth = 1;
    topTextNode.layer.borderColor = RGB(236, 126, 150).CGColor;
    topTextNode.text = @"置顶帖";
    [self.contentView addSubview:topTextNode];
    _topTextNode = topTextNode;
    
    UILabel *titleTextNode = [[UILabel alloc] init];
    titleTextNode.font = [UIFont systemFontOfSize:14];
    titleTextNode.textColor = RGB(36, 36, 36);
    [self.contentView addSubview:titleTextNode];
    _titleTextNode = titleTextNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = RGB(222, 222, 222);
    [self.contentView addSubview:underLineNode];
    _underLineNode = underLineNode;

}

- (void)setForumThread:(ForumThread *)forumThread
{
    _forumThread = forumThread;
    _titleTextNode.text = forumThread.subject;
}

#pragma mark - layout

- (void)mas_autoLayoutSubViews
{
    [_topTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(25);
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [_titleTextNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topTextNode.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(_topTextNode);
    }];
    
    [_underLineNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_topTextNode.mas_bottom).offset(10);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}
@end
