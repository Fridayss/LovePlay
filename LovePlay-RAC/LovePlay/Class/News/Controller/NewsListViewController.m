//
//  NewsListViewController.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsListViewController.h"
//M
#import "NewsListInfoModel.h"
//V
#import "NewsNormalCellNode.h"
#import "NewsTitleImageCellNode.h"
#import "NewsImageTitleCellNode.h"
//V(C)
#import "NewsDetailViewController.h"
//VM
#import "NewsListViewModel.h"

@interface NewsListViewController ()<UITableViewDelegate, UITableViewDataSource>
//UI
@property (nonatomic, strong) UITableView *tableNode;
//Data
@property (nonatomic, strong) NewsListViewModel *listViewModel;
@end

@implementation NewsListViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableNode];
    [self loadData];
}

#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initParams];
    }
    return self;
}

- (void)initParams
{
    //这个数据初始化不能放在viewDidLoad中
    _sourceType = 1;
}

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
    [[self.listViewModel.fetchNewsListCommand execute:_topicID] subscribeNext:^(id x) {
        [_tableNode reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listViewModel.listModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListInfoModel *listInfoModel = self.listViewModel.listModels[indexPath.row];
    if (_sourceType == 0) {
        NewsImageTitleCellNode *cellNode = [NewsImageTitleCellNode cellWithTableView:tableView];
        [cellNode setupListInfoModel:listInfoModel];
        return cellNode;
    }else{
        switch (listInfoModel.showType) {
            case 2:
            {
                NewsTitleImageCellNode *cellNode = [NewsTitleImageCellNode cellWithTableView:tableView];
                [cellNode setupListInfoModel:listInfoModel];
                return cellNode;
            }
                break;
                
            default:
            {
                NewsNormalCellNode *cellNode = [NewsNormalCellNode cellWithTableView:tableView];
                [cellNode setupListInfoModel:listInfoModel];
                return cellNode;
            }
                break;
        }
    }
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListInfoModel *listInfoModel = self.listViewModel.listModels[indexPath.row];
    NewsDetailViewController *detailViewController = [[NewsDetailViewController alloc] init];
    detailViewController.newsID = listInfoModel.docid;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - setter / getter
- (UITableView *)tableNode
{
    if (!_tableNode) {
        UITableView *tableNode = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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

- (NewsListViewModel *)listViewModel
{
    if (!_listViewModel) {
        NewsListViewModel *listViewModel = [[NewsListViewModel alloc] init];
        _listViewModel = listViewModel;
    }
    return _listViewModel;
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
