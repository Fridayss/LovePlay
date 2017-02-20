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

@interface DiscussDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
//UI
@property (nonatomic, strong) UITableView *tableView;
//Data
@property (nonatomic, strong) NSArray *discussPostDatas;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) CGFloat webViewHeight;
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
    _pageSize = 16;
    _webViewHeight = 0;
}

- (void)addTableView
{
    [self.view addSubview:self.tableView];
    //使用masonry刷新横竖屏切换布局
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadData
{
    NSDictionary *params = @{@"version":@"163",@"module":@"viewthread",@"tid": _tid?_tid:@"",@"ppp":@(_pageSize).stringValue,@"charset":@"utf-8",@"page":@(_pageIndex).stringValue};
    [[HttpRequest sharedInstance] GET:DiscussDetailURL parameters:params success:^(id response) {
        NSLog(@"list-succ : %@", response);
        DiscussDetailModel *detailModel = [DiscussDetailModel modelWithJSON:response[@"Variables"]];
        _discussPostDatas = detailModel.postlist;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
    }];
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _discussPostDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscuzPost *post = _discussPostDatas[indexPath.row];
    if (indexPath.row == 0) {
        DiscussDetailWebCell *cell = [DiscussDetailWebCell cellWithTableView:tableView];
        if (_webViewHeight <= 0) {
            [cell setupHtmlBoby:post.message];
            [cell webViewDidFinishLoadBlock:^(CGFloat webViewHeight) {
                _webViewHeight = webViewHeight;
                [_tableView reloadData];
            }];
        }
        return cell;
    }else{
        DiscussDetailPostCell *cell = [DiscussDetailPostCell cellWithTableView:tableView];
        [cell setupPost:post floor:indexPath.row];
        return cell;
    }
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return _webViewHeight;
    }
    return UITableViewAutomaticDimension;
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellEditingStyleNone;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 100;
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
