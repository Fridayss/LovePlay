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
//UI
@property (nonatomic, strong) UILabel *topTextNode;
@property (nonatomic, strong) UILabel *titleTextNode;
@property (nonatomic, strong) UIView *underLineNode;
//Data
@property (nonatomic, strong) ForumThread *forumThread;
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
        [self mas_subViews];
    }
    return self;
}

#pragma mark - private
- (void)addSubNodes
{
    [self.contentView addSubview:self.topTextNode];

    [self.contentView addSubview:self.titleTextNode];

    [self.contentView addSubview:self.underLineNode];
}

- (void)mas_subViews
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

#pragma mark - public
- (void)setupForumThread:(ForumThread *)forumThread
{
    _forumThread = forumThread;
    _titleTextNode.text = forumThread.subject;
}

#pragma mark - setter / getter
- (UILabel *)topTextNode
{
    if (!_topTextNode) {
        UILabel *topTextNode = [[UILabel alloc] init];
        topTextNode.font = [UIFont systemFontOfSize:12];
        topTextNode.textAlignment = NSTextAlignmentCenter;
        topTextNode.textColor = RGB(236, 126, 150);
        topTextNode.layer.cornerRadius = 5;
        topTextNode.layer.masksToBounds = YES;
        topTextNode.layer.borderWidth = 1;
        topTextNode.layer.borderColor = RGB(236, 126, 150).CGColor;
        topTextNode.text = @"置顶帖";
        _topTextNode = topTextNode;
    }
    return _topTextNode;
}

- (UILabel *)titleTextNode
{
    if (!_titleTextNode) {
        UILabel *titleTextNode = [[UILabel alloc] init];
        titleTextNode.font = [UIFont systemFontOfSize:14];
        titleTextNode.textColor = RGB(36, 36, 36);
        _titleTextNode = titleTextNode;
    }
    return _titleTextNode;
}

- (UIView *)underLineNode
{
    if (!_underLineNode) {
        UIView *underLineNode = [[UIView alloc] init];
        underLineNode.backgroundColor = RGB(222, 222, 222);
        _underLineNode = underLineNode;
    }
    return _underLineNode;
}

@end
