//
//  DiscussListViewController.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListViewController.h"
//M
#import "DiscussListModel.h"
#import "DiscussImageModel.h"
//V
#import "DiscussListHeaderView.h"
#import "DiscussListCell.h"
#import "DiscussListTopCell.h"
//C
#import "DiscussDetailViewController.h"

@interface DiscussListViewController ()<ASTableDelegate, ASTableDataSource>
//UI
@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) DiscussListHeaderView *headerView;
//Data
@property (nonatomic, strong) NSArray *discussListTopDatas;
@property (nonatomic, strong) NSArray *discussListDatas;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation DiscussListViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initParams];
    [self addTableView];
    [self loadData];
}

#pragma mark - init
- (void)initParams
{
    _pageIndex = 1;
}

- (void)addTableView
{
    [self.view addSubnode:self.tableNode];
}

- (void)loadData
{
    [self loadDiscussListData];
}

- (void)loadDiscussListData
{
    NSDictionary *params = @{@"version":@"163",@"module":@"forumdisplay",@"fid":_fid?_fid:@"",@"tpp":@"15",@"charset":@"utf-8",@"page":@(_pageIndex).stringValue};
    [[HttpRequest sharedInstance] GET:DiscussListURL parameters:params success:^(id response) {
        NSLog(@"list-succ : %@", response);
        DiscussListModel *discussListModel = [DiscussListModel modelWithJSON:response[@"Variables"]];
        [self dealWithDiscussList:discussListModel.forum_threadlist];
        
        [self loadDiscussImageData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
    }];
}

- (void)loadDiscussImageData
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", DiscussListImgURL, _fid];
    [[HttpRequest sharedInstance] GET:urlString parameters:nil success:^(id response) {
        NSLog(@"img-suc : %@", response);
        DiscussImageModel *discussImageModel = [DiscussImageModel modelWithJSON:response[@"info"]];
        [self dealWithDiscussHeaderViewWithDiscussImageModel:discussImageModel];
        [_tableNode reloadData];
    } failure:^(NSError *error) {
        NSLog(@"img-Err : %@", error);
    }];
}

#pragma mark - private
- (void)dealWithDiscussHeaderViewWithDiscussImageModel:(DiscussImageModel *)imageModel
{
    self.headerView.imageModel = imageModel;
    self.tableNode.view.tableHeaderView = self.headerView.view;
}

- (void)dealWithDiscussList:(NSArray *)discussList
{
    NSMutableArray *discussListTops = [NSMutableArray array];
    NSMutableArray *discussLists = [NSMutableArray array];
    
    for (ForumThread *forum in discussList) {
        if (forum.displayorder == 1) {
            [discussListTops addObject:forum];
        }else {
            [discussLists addObject:forum];
        }
    }
    _discussListDatas = [discussLists copy];
    _discussListTopDatas = [discussListTops copy];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode
{
    return 2;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _discussListTopDatas.count;
            break;
        case 1:
            return _discussListDatas.count;
            break;
            
        default:
            return 0;
            break;
    }
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASCellNode * (^cellNodeBlock)() = ^ASCellNode *(){
        switch (indexPath.section) {
            case 0:
            {
                ForumThread *forumThread = _discussListTopDatas[indexPath.row];
                DiscussListTopCell *cell = [[DiscussListTopCell alloc] initWithForumThread:forumThread];
                return cell;
            }
                break;
            case 1:
            {
                ForumThread *forumThread = _discussListDatas[indexPath.row];
                DiscussListCell *cell = [[DiscussListCell alloc] initWithForumThread:forumThread];
                return cell;
            }
                break;
                
            default:
                return nil;
                break;
        }
    };
    return cellNodeBlock;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForumThread *forumThread = indexPath.section == 0 ? _discussListTopDatas[indexPath.row] : _discussListDatas[indexPath.row];
    DiscussDetailViewController *detailViewController = [[DiscussDetailViewController alloc] init];
    detailViewController.tid = forumThread.tid;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

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

- (DiscussListHeaderView *)headerView
{
    if (!_headerView) {
        DiscussListHeaderView *headerView = [[DiscussListHeaderView alloc] init];
        headerView.view.size = CGSizeMake(self.tableNode.view.width, 150);
        _headerView = headerView;
    }
    return _headerView;
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
