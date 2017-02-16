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
@property (nonatomic, assign) CGFloat webViewHeight;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    [self initParams];
    [self addTableNode];
    [self loadData];
    
}

- (void)initParams
{
    _webViewHeight = 0;
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
            if (_webViewHeight <= 0) {
                [cellNode setupHtmlBoby:_detailModel.article.body];
                [cellNode webViewDidFinishLoadBlock:^(CGFloat webViewHeight) {
                    _webViewHeight = webViewHeight;
                    [_tableNode reloadData];
//                    [_tableNode reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                }];
            }
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
            NewsRelativeCellNode *cellNode = [NewsRelativeCellNode cellWithTableView:tableView];
            [cellNode setupRelativeInfo:relativeInfo];
            return cellNode;
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
    if (indexPath.section == 0) {
        return _webViewHeight;
    }
    return UITableViewAutomaticDimension;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        return _webViewHeight;
//    }
//    return UITableViewAutomaticDimension;
//}

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
