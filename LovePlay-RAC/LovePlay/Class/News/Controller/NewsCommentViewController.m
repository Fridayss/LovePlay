//
//  NewsCommentViewController.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentViewController.h"
//M
#import "NewsCommentModel.h"
//V
#import "NewsCommentCellNode.h"
#import "NewsDetailSectionTitleHeaderView.h"
//VM
#import "NewsCommentViewModel.h"

@interface NewsCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
//UI
@property (nonatomic, strong) UITableView *tableNode;
//Data
@property (nonatomic, strong) NewsCommentViewModel *commentViewModel;
@end

@implementation NewsCommentViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableNode];
    [self loadData];
}

#pragma mark - init

- (void)addTableNode
{
    [self.view addSubview:self.tableNode];
    //使用masonry刷新横竖屏切换布局
    [_tableNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadData
{
    [[self.commentViewModel.fetchNewsCommentCommand execute:_newsID] subscribeNext:^(id x) {
        [_tableNode reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return self.commentViewModel.hotComments.commentIds.count;
    }else{
        return self.commentViewModel.latestComments.commentIds.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCommentCellNode *cell = [NewsCommentCellNode cellWithTableView:tableView];
    if (0 == indexPath.section) {
        [cell setupCommentItems:self.commentViewModel.hotComments.comments commmentIds:self.commentViewModel.hotComments.commentIds[indexPath.row]];
    }else{
        [cell setupCommentItems:self.commentViewModel.latestComments.comments commmentIds:self.commentViewModel.latestComments.commentIds[indexPath.row]];
    }
    return cell;
}

#pragma mark - tableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NewsDetailSectionTitleHeaderView *headerView = [NewsDetailSectionTitleHeaderView sectionHeaderWithTableView:tableView];

    switch (section) {
        case 0:
        {
            if (self.commentViewModel.hotComments.comments.count > 0) {
                headerView.title = @"热门跟帖";
            }else{
                return nil;
            }
            
        }
            break;
        case 1:
        {
            if (self.commentViewModel.latestComments.comments.count > 0) {
                headerView.title = @"最新跟帖";
            }else{
                return nil;
            }
        }
            break;
        default:
            return nil;
            break;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            if (self.commentViewModel.hotComments.comments.count > 0) {
                return 30;
            }
        }
            break;
        case 1:
        {
            if (self.commentViewModel.latestComments.comments.count > 0) {
                return 30;
            }
        }
            break;
        default:
            return CGFLOAT_MIN;
            break;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark -  setter / getter
- (UITableView *)tableNode
{
    if (!_tableNode) {
        UITableView *tableNode = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableNode.backgroundColor = [UIColor whiteColor];
        tableNode.delegate = self;
        tableNode.dataSource = self;
        tableNode.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableNode.rowHeight = UITableViewAutomaticDimension;
        tableNode.estimatedRowHeight = 100;
        _tableNode = tableNode;
    }
    return _tableNode;
}

- (NewsCommentViewModel *)commentViewModel
{
    if (!_commentViewModel) {
        NewsCommentViewModel *commentViewModel = [[NewsCommentViewModel alloc] init];
        _commentViewModel = commentViewModel;
    }
    return _commentViewModel;
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
