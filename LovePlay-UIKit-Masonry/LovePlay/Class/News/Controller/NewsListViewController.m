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

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initParams];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableNode];
    [self loadData];
}

- (void)initParams
{
    _pageIndex = 0;
    //这个数据初始化不能放在viewDidLoad中
    _sourceType = 1;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListInfoModel *listInfoModel = _newsListDatas[indexPath.row];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
