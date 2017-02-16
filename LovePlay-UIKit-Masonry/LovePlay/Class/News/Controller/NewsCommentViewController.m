//
//  NewsCommentViewController.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentViewController.h"
#import "NewsCommentModel.h"
#import "NewsCommentCellNode.h"
#import "NewsDetailSectionTitleHeaderView.h"

@interface NewsCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
//UI
@property (nonatomic, strong) UITableView *tableNode;
//Data
@property (nonatomic, strong) NewsCommentModel *hotComments;
@property (nonatomic, strong) NewsCommentModel *latestComments;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation NewsCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initParams];
    [self addTableNode];
    [self loadData];
}

- (void)initParams
{
    _pageIndex = 0;
    _pageSize = 10;
}


- (void)addTableNode
{
    [self.view addSubview:self.tableNode];
    //使用masonry刷新横竖屏切换布局
    [_tableNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

- (void)loadData
{
    [self loadHotCommentData];
}

- (void)loadHotCommentData
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/0/10/11/2/2",NewsHotCommentURL, _newsID];
    [[HttpRequest sharedInstance] GET:urlString parameters:nil success:^(id response) {
        NSLog(@"list-succ : %@", response);
        NewsCommentModel *commentModel = [NewsCommentModel modelWithJSON:response];
        _hotComments = commentModel;
        [self loadLatestCommentData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
    }];
}

- (void)loadLatestCommentData
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%ld/%ld/6/2/2",NewsLatestCommentURL, _newsID, _pageIndex * _pageSize, _pageSize];
    [[HttpRequest sharedInstance] GET:urlString parameters:nil success:^(id response) {
        NSLog(@"list-succ : %@", response);
        NewsCommentModel *commentModel = [NewsCommentModel modelWithJSON:response];
        _latestComments = commentModel;
        [_tableNode reloadData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
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
        return _hotComments.commentIds.count;
    }else{
        return _latestComments.commentIds.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCommentCellNode *cell = [NewsCommentCellNode cellWithTableView:tableView];
    if (0 == indexPath.section) {
        [cell setupCommentItems:_hotComments.comments commmentIds:_hotComments.commentIds[indexPath.row]];
    }else{
        [cell setupCommentItems:_latestComments.comments commmentIds:_latestComments.commentIds[indexPath.row]];
    }
    return cell;
}

#pragma mark - tableView delegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [_tableNode cellHeightForIndexPath:indexPath cellClass:[NewsCommentCellNode class] cellContentViewWidth:_tableNode.width cellDataSetting:^(UITableViewCell *cell) {
//        if (0 == indexPath.section) {
//            [(NewsCommentCellNode *)cell setupCommentItems:_hotComments.comments commmentIds:_hotComments.commentIds[indexPath.row]];
//        }else{
//            [(NewsCommentCellNode *)cell setupCommentItems:_latestComments.comments commmentIds:_latestComments.commentIds[indexPath.row]];
//        }
//    }];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NewsDetailSectionTitleHeaderView *headerView = [NewsDetailSectionTitleHeaderView sectionHeaderWithTableView:tableView];

    switch (section) {
        case 0:
        {
            if (_hotComments.comments.count > 0) {
                headerView.title = @"热门跟帖";
            }else{
                return nil;
            }
            
        }
            break;
        case 1:
        {
            if (_latestComments.comments.count > 0) {
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
            if (_hotComments.comments.count > 0) {
                return 30;
            }
        }
            break;
        case 1:
        {
            if (_latestComments.comments.count > 0) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
