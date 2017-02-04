//
//  NewsDetailViewController.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailModel.h"

@interface NewsDetailViewController ()<ASTableDelegate, ASTableDataSource>
//UI
@property (nonatomic, strong) ASTableNode *tableNode;
//Data

@end

@implementation NewsDetailViewController

- (instancetype)init
{
    self = [super initWithNode:[ASDisplayNode new]];
    if (self) {
        [self addTableNode];
    }
    return self;
}

- (void)addTableNode
{
    ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStyleGrouped];
    tableNode.backgroundColor = [UIColor whiteColor];
    tableNode.delegate = self;
    tableNode.dataSource = self;
    [self.node addSubnode:tableNode];
    _tableNode = tableNode;
}

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

- (void)loadData
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",  NewsDetailURL, _newsID];
    NSDictionary *params = @{@"tieVersion":@"v2",@"platform":@"ios",@"width":@(kScreenWidth*2),@"height":@(kScreenHeight*2),@"decimal":@"75"};
    [[HttpRequest sharedInstance] GET:urlString parameters:params success:^(id response) {
        NSLog(@"list-succ : %@", response);
        NewsDetailModel *detailModel = [NewsDetailModel modelWithJSON:response[@"info"]];
        [_tableNode reloadData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
    }];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode
{
    return 1;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASCellNode * (^cellNodeBlock)() = ^ASCellNode * (){
        ASCellNode *cellNode = [[ASCellNode alloc] init];
        return cellNode;
    };
    return cellNodeBlock;
}

#pragma mark - tableView dataSource

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
