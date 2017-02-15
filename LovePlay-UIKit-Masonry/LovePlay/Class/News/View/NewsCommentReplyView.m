//
//  NewsCommentReplyView.m
//  LovePlay
//
//  Created by weiying on 2017/2/14.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentReplyView.h"
#import "NewsCommentReplyCell.h"

@interface NewsCommentReplyView ()<UITableViewDelegate, UITableViewDataSource>
//UI
@property (nonatomic, strong) UITableView *tableView;
//Data
@property (nonatomic, strong) NSDictionary *commentItemsDict;
@property (nonatomic, strong) NSArray *floors;
@end

@implementation NewsCommentReplyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(248, 249, 241);
        self.layer.borderColor = RGB(218, 218, 218).CGColor;
        self.layer.borderWidth = 0.5;
        [self addSubview:self.tableView];
//        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.width = self.width;
}

- (void)setupCommentItems:(NSDictionary *)commentItems floors:(NSArray *)floors didReloadBlock:(replyTableViewDidReload)reloadBlock
{
    _commentItemsDict = commentItems;
    _floors = floors;
    [_tableView reloadData];
    NSLog(@"tableHeight -- %@", NSStringFromCGRect(_tableView.frame));
//    self.sd_layout.maxHeightIs(_tableView.height);
    NSLog(@"contentSize.height -- %@",NSStringFromCGSize(_tableView.contentSize));
    self.height = _tableView.contentSize.height;
    if (reloadBlock) {
        reloadBlock(_tableView.contentSize.height);
    }
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _floors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *floor = _floors[indexPath.row];
    NewsCommentItem *commentItem = _commentItemsDict[floor];
    NewsCommentReplyCell *cell = [NewsCommentReplyCell cellWithTableView:tableView];
    [cell setupCommentItem:commentItem floor:indexPath.row];
    return cell;
}
#pragma mark - tableView dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *floor = _floors[indexPath.row];
    NewsCommentItem *commentItem = _commentItemsDict[floor];
    return [_tableView cellHeightForIndexPath:indexPath cellClass:[NewsCommentReplyCell class] cellContentViewWidth:_tableView.width cellDataSetting:^(UITableViewCell *cell) {
        [(NewsCommentReplyCell *)cell setupCommentItem:commentItem floor:indexPath.row];
    }];
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
//    [self setupAutoHeightWithBottomView:_tableView bottomMargin:0];
    _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView = tableView;
    }
    return _tableView;
}

@end
