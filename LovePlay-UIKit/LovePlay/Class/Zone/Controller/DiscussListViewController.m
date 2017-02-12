//
//  DiscussListViewController.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListViewController.h"
#import "DiscussListModel.h"
#import "DiscussImageModel.h"
#import "DiscussListHeaderView.h"
#import "DiscussListCell.h"
#import "DiscussListTopCell.h"
#import "DiscussDetailViewController.h"

@interface DiscussListViewController ()<UITableViewDataSource, UITableViewDelegate>
//UI
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DiscussListHeaderView *headerView;
//Data
@property (nonatomic, strong) NSArray *discussListTopDatas;
@property (nonatomic, strong) NSArray *discussListDatas;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation DiscussListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initParams];
    [self addTableView];
    [self addTableHeaderView];
    [self loadData];
}

- (void)initParams
{
    _pageIndex = 1;
}

- (void)addTableView
{
    [self.view addSubview:self.tableView];
}

- (void)addTableHeaderView
{
    [self.view addSubview:self.headerView];
}

- (void)loadData
{
    [self loadDiscussListData];
}

- (void)loadDiscussListData
{
    NSDictionary *params = @{@"version":@"163",@"module":@"forumdisplay",@"fid":_fid?_fid:@"",@"tpp":@"15",@"charset":@"utf-8",@"page":@(_pageIndex).stringValue};
    [[HttpRequest sharedInstance] GET:DiscussListURL parameters:params success:^(id response) {
        NSLog(@"list-succ : %@", response);
        DiscussListModel *discussListModel = [DiscussListModel modelWithJSON:response[@"Variables"]];
        [self dealWithDiscussList:discussListModel.forum_threadlist];
        
        [self loadDiscussImageData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
    }];
}

- (void)loadDiscussImageData
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", DiscussListImgURL, _fid];
    [[HttpRequest sharedInstance] GET:urlString parameters:nil success:^(id response) {
        NSLog(@"img-suc : %@", response);
        DiscussImageModel *discussImageModel = [DiscussImageModel modelWithJSON:response[@"info"]];
        [self dealWithDiscussHeaderViewWithDiscussImageModel:discussImageModel];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"img-Err : %@", error);
    }];
}

- (void)dealWithDiscussHeaderViewWithDiscussImageModel:(DiscussImageModel *)imageModel
{
    
    self.headerView.imageModel = imageModel;
    self.tableView.tableHeaderView = self.headerView;
}

- (void)dealWithDiscussList:(NSArray *)discussList
{
    NSMutableArray *discussListTops = [NSMutableArray array];
    NSMutableArray *discussLists = [NSMutableArray array];
    
    for (ForumThread *forum in discussList) {
        if (forum.displayorder == 1) {
            [discussListTops addObject:forum];
        }else {
            [discussLists addObject:forum];
        }
    }
    _discussListDatas = [discussLists copy];
    _discussListTopDatas = [discussListTops copy];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _discussListTopDatas.count;
            break;
        case 1:
            return _discussListDatas.count;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            ForumThread *forumThread = _discussListTopDatas[indexPath.row];
            DiscussListTopCell *cell = [DiscussListTopCell cellWithTableView:tableView];
            cell.forumThread = forumThread;
            return cell;
        }
            break;
        case 1:
        {
            ForumThread *forumThread = _discussListDatas[indexPath.row];
            DiscussListCell *cell = [DiscussListCell cellWithTableView:tableView];
            cell.forumThread = forumThread;
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}



#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            ForumThread *forumThread = _discussListTopDatas[indexPath.row];
            return [_tableView cellHeightForIndexPath:indexPath model:forumThread keyPath:@"forumThread" cellClass:[DiscussListTopCell class] contentViewWidth:_tableView.width];
        }
            break;
        case 1:
        {
            ForumThread *forumThread = _discussListDatas[indexPath.row];
            return [_tableView cellHeightForIndexPath:indexPath model:forumThread keyPath:@"forumThread" cellClass:[DiscussListCell class] contentViewWidth:_tableView.width];
        }
            break;
        default:
            return CGFLOAT_MIN;
            break;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForumThread *forumThread = indexPath.section == 0 ? _discussListTopDatas[indexPath.row] : _discussListDatas[indexPath.row];
    DiscussDetailViewController *detailViewController = [[DiscussDetailViewController alloc] init];
    detailViewController.tid = forumThread.tid;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Getter / Setter
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}

- (DiscussListHeaderView *)headerView
{
    if (!_headerView) {
        DiscussListHeaderView *headerView = [[DiscussListHeaderView alloc] init];
        headerView.width = self.tableView.width;
        headerView.height = 150;
        _headerView = headerView;
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
