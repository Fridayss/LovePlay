//
//  DiscussDetailViewController.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussDetailViewController.h"
//M
#import "DiscussDetailModel.h"
//V
#import "DiscussDetailWebCell.h"
#import "DiscussDetailPostCell.h"

@interface DiscussDetailViewController ()<ASTableDelegate, ASTableDataSource>
//UI
@property (nonatomic, strong) ASTableNode *tableNode;
//Data
@property (nonatomic, strong) NSArray *discussPostDatas;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation DiscussDetailViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initParams];
    [self addTableView];
    [self loadData];
}

#pragma mark - init
- (void)initParams
{
    _pageIndex = 1;
    _pageSize = 10;
}

- (void)addTableView
{
    [self.view addSubnode:self.tableNode];
}

- (void)loadData
{
    NSDictionary *params = @{@"version":@"163",@"module":@"viewthread",@"tid": _tid?_tid:@"",@"ppp":@(_pageSize).stringValue,@"charset":@"utf-8",@"page":@(_pageIndex).stringValue};
    [[HttpRequest sharedInstance] GET:DiscussDetailURL parameters:params success:^(id response) {
        NSLog(@"list-succ : %@", response);
        DiscussDetailModel *detailModel = [DiscussDetailModel modelWithJSON:response[@"Variables"]];
        _discussPostDatas = detailModel.postlist;
        [_tableNode reloadData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
    }];
}

#pragma mark - tableView dataSource
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
    return _discussPostDatas.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscuzPost *post = _discussPostDatas[indexPath.row];
    ASCellNode * (^cellNodeBlock)() = ^ASCellNode *(){
        if (indexPath.row == 0) {
            DiscussDetailWebCell *cellNode = [[DiscussDetailWebCell alloc] initWithHtmlBody:post.message];
            return cellNode;
        }else{
            DiscussDetailPostCell *cellNode = [[DiscussDetailPostCell alloc] initWithPost:post floor:indexPath.row];
            return cellNode;
        }
    };
    return cellNodeBlock;
}

#pragma mark - tableView delegate

#pragma mark - setter / getter
- (ASTableNode *)tableNode
{
    if (!_tableNode) {
        ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        tableNode.delegate = self;
        tableNode.dataSource = self;
        tableNode.frame = self.view.bounds;
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
