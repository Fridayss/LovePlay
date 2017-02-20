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

@interface NewsCommentViewController ()<ASTableDelegate, ASTableDataSource>
//UI
@property (nonatomic, strong) ASTableNode *tableNode;
//Data
@property (nonatomic, strong) NewsCommentModel *hotComments;
@property (nonatomic, strong) NewsCommentModel *latestComments;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation NewsCommentViewController

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
        [self initParams];
        [self addTableNode];
    }
    return self;
}

- (void)initParams
{
    _pageIndex = 0;
    _pageSize = 10;
}

- (void)addTableNode
{
    [self.node addSubnode:self.tableNode];
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
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode
{
    return 2;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return _hotComments.commentIds.count;
    }else{
        return _latestComments.commentIds.count;
    }
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASCellNode *(^cellNodeBlock)() = ^ASCellNode *(){
        if (0 == indexPath.section) {
            NewsCommentCellNode *cellNode = [[NewsCommentCellNode alloc] initWithcommentItems:_hotComments.comments commmentIds:_hotComments.commentIds[indexPath.row]];
            return cellNode;
        }else{
            NewsCommentCellNode *cellNode = [[NewsCommentCellNode alloc] initWithcommentItems:_latestComments.comments commmentIds:_latestComments.commentIds[indexPath.row]];
            return cellNode;
        }
    };
    return cellNodeBlock;
}

#pragma mark - tableView delegate
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - setter / getter
- (ASTableNode *)tableNode
{
    if (!_tableNode) {
        ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
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
