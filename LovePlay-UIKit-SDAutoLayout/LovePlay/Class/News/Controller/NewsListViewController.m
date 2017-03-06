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
//C
#import "NewsDetailViewController.h"

@interface NewsListViewController ()<UITableViewDelegate, UITableViewDataSource>
//UI
@property (nonatomic, strong) UITableView *tableNode;
//Data
@property (nonatomic, strong) NSArray *newsListDatas;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initParams];
    [self addTableNode];
    [self loadData];
}

#pragma mark - init
- (void)initParams
{
    _pageIndex = 0;
    _sourceType = 1;
}

- (void)addTableNode
{
    UITableView *tableNode = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableNode.backgroundColor = [UIColor whiteColor];
    tableNode.delegate = self;
    tableNode.dataSource = self;
    tableNode.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableNode];
    _tableNode = tableNode;
}

- (void)loadData
{
    NSInteger pageCount = 30;
    NSString *urlString = [NSString stringWithFormat:@"%@/%ld/%ld", NewsListURL, _pageIndex * pageCount, pageCount];
    if (_topicID != nil) {
        urlString = [NSString stringWithFormat:@"%@/%@/%ld/%ld", NewsListURL, _topicID, _pageIndex * pageCount, pageCount];
    }
    [[HttpRequest sharedInstance] GET:urlString parameters:nil success:^(id response) {
        NSLog(@"response -- %@", response);
        _newsListDatas = [NSArray modelArrayWithClass:[NewsListInfoModel class] json:response[@"info"]];
        [_tableNode reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error -- %@", error);
    }];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsListDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListInfoModel *listInfoModel = _newsListDatas[indexPath.row];
    if (_sourceType == 0) {
        NewsImageTitleCellNode *cellNode = [NewsImageTitleCellNode cellWithTableView:tableView];
        cellNode.listInfoModel = listInfoModel;
        return cellNode;
    }else{
        switch (listInfoModel.showType) {
            case 2:
            {
                NewsTitleImageCellNode *cellNode = [NewsTitleImageCellNode cellWithTableView:tableView];
                cellNode.listInfoModel = listInfoModel;
                return cellNode;
            }
                break;
                
            default:
            {
                NewsNormalCellNode *cellNode = [NewsNormalCellNode cellWithTableView:tableView];
                cellNode.listInfoModel = listInfoModel;
                return cellNode;
            }
                break;
        }
    }
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListInfoModel *listInfoModel = _newsListDatas[indexPath.row];
    Class currentClass = [NewsNormalCellNode class];
    if (_sourceType == 0) {
        currentClass = [NewsImageTitleCellNode class];
    }else{
        switch (listInfoModel.showType) {
            case 2:
                currentClass = [NewsTitleImageCellNode class];
                break;
            default:
                currentClass = [NewsNormalCellNode class];
                break;
        }
    }
    
    return [self.tableNode cellHeightForIndexPath:indexPath model:listInfoModel keyPath:@"listInfoModel" cellClass:currentClass contentViewWidth:self.tableNode.width];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListInfoModel *listInfoModel = _newsListDatas[indexPath.row];
    NewsDetailViewController *detailViewController = [[NewsDetailViewController alloc] init];
    detailViewController.newsID = listInfoModel.docid;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
