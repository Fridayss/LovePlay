//
//  NewsDetailViewController.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailModel.h"
#import "NewsDetailWebCellNode.h"
#import "NewsRelativeCellNode.h"
#import "NewsCommentCellNode.h"
#import "NewsDetailSectionTitleHeaderView.h"
#import "NewsDetailSectionCommentFooterView.h"
#import "NewsCommentViewController.h"

@interface NewsDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
//UI
@property (nonatomic, strong) UITableView *tableNode;
//Data
@property (nonatomic, strong) NewsDetailModel *detailModel;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableNode];
    [self loadData];
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
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",  NewsDetailURL, _newsID];
    NSDictionary *params = @{@"tieVersion":@"v2",@"platform":@"ios",@"width":@(kScreenWidth*2),@"height":@(kScreenHeight*2),@"decimal":@"75"};
    [[HttpRequest sharedInstance] GET:urlString parameters:params success:^(id response) {
        NSLog(@"list-succ : %@", response);
        NewsDetailModel *detailModel = [NewsDetailModel modelWithJSON:response[@"info"]];
        _detailModel = detailModel;
        [_tableNode reloadData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
    }];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return _detailModel.tie.commentIds.count;
            break;
        case 2:
            return _detailModel.article.relative_sys.count;
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
            NewsDetailWebCellNode *cellNode = [NewsDetailWebCellNode cellWithTableView:tableView];
            [cellNode setupHtmlBoby:_detailModel.article.body];
            return cellNode;
        }
            break;
        case 1:
        {
            NSArray *floors = _detailModel.tie.commentIds[indexPath.row];
            NewsCommentCellNode *cellNode = [NewsCommentCellNode cellWithTableView:tableView];
            [cellNode setupCommentItems:_detailModel.tie.comments commmentIds:floors];
            return cellNode;
        }
            break;
        case 2:
        {
            NewsRelativeInfo *relativeInfo = _detailModel.article.relative_sys[indexPath.row];
            NewsRelativeCellNode *cellNode = [[NewsRelativeCellNode alloc] initWithRelativeInfo:relativeInfo];
            return cellNode;
        }
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - tableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NewsDetailSectionTitleHeaderView *headerView = [NewsDetailSectionTitleHeaderView sectionHeaderWithTableView:tableView];
    switch (section) {
        case 1:
        {
            if (_detailModel.tie.comments.count > 0) {
                headerView.title = @"热门跟帖";
            }else{
                return nil;
            }
           
        }
            break;
        case 2:
        {
            if (_detailModel.article.relative_sys.count > 0) {
                headerView.title = @"猜你喜欢";
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NewsDetailSectionCommentFooterView *footerView = [NewsDetailSectionCommentFooterView sectionFooterWithTableView:tableView];
    if (1 == section) {
        if (_detailModel.tie.comments.count > 0) {
            footerView.title = @"查看更多跟帖";
            [footerView commentFooterViewTouchBlock:^{
                NewsCommentViewController *commentViewController = [[NewsCommentViewController alloc] init];
                commentViewController.newsID = _newsID;
                [self.navigationController pushViewController:commentViewController animated:YES];
            }];
            return footerView;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 1:
        {
            if (_detailModel.tie.comments.count > 0) {
               return 30;
            }
        }
            break;
        case 2:
        {
            if (_detailModel.article.relative_sys.count > 0) {
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
    if (1 == section) {
        if (_detailModel.tie.comments.count > 0) {
            return 40;
        }
    }
    return CGFLOAT_MIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
