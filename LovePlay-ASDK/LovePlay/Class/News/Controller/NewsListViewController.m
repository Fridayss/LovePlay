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

@interface NewsListViewController ()<ASTableDelegate, ASTableDataSource>
//UI
@property (nonatomic, strong) ASTableNode *tableNode;
//Data
@property (nonatomic, strong) NSArray *newsListDatas;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation NewsListViewController

#pragma mark - life cycle
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tableNode.frame = self.node.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
}

#pragma mark - init
- (instancetype)init
{
    self = [super initWithNode:[ASDisplayNode new]];
    if (self) {
        [self addTableNode];
        [self initParams];
    }
    return self;
}

- (void)initParams
{
    _pageIndex = 0;
    _sourceType = 1;
}

- (void)addTableNode
{
    [self.node addSubnode:self.tableNode];
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

#pragma mark - tableView dataSource
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
    return _newsListDatas.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListInfoModel *listInfoModel = _newsListDatas[indexPath.row];
    ASCellNode *(^cellNodeBlock)() = ^ASCellNode *(){
        ASCellNode *cellNode = nil;
        if (_sourceType == 0) {
            cellNode = [[NewsImageTitleCellNode alloc] initWithListInfoModel:listInfoModel];
        }else{
            switch (listInfoModel.showType) {
                case 2:
                    cellNode = [[NewsTitleImageCellNode alloc] initWithListInfoModel:listInfoModel];
                    break;
                    
                default:
                    cellNode = [[NewsNormalCellNode alloc] initWithListInfoModel:listInfoModel];
                    
                    break;
            }
        }
        
        return cellNode;
    };
    return cellNodeBlock;
}

#pragma mark - tableView delegate
- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListInfoModel *listInfoModel = _newsListDatas[indexPath.row];
    NewsDetailViewController *detailViewController = [[NewsDetailViewController alloc] init];
    detailViewController.newsID = listInfoModel.docid;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - setter / getter
- (ASTableNode *)tableNode
{
    if (!_tableNode) {
        ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        //    tableNode.frame = self.view.bounds;
        tableNode.backgroundColor = [UIColor whiteColor];
        tableNode.delegate = self;
        tableNode.dataSource = self;
        tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableNode = tableNode;
    }
    return _tableNode;
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
