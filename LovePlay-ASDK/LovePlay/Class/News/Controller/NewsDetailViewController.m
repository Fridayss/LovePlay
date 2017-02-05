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

@interface NewsDetailViewController ()<ASTableDelegate, ASTableDataSource>
//UI
@property (nonatomic, strong) ASTableNode *tableNode;
//Data
@property (nonatomic, strong) NewsDetailModel *detailModel;
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
    tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        _detailModel = detailModel;
        [_tableNode reloadData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
    }];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode
{
    return 3;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
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

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASCellNode * (^cellNodeBlock)() = ^ASCellNode * (){
        switch (indexPath.section) {
            case 0:
            {
                NewsDetailWebCellNode *cellNode = [[NewsDetailWebCellNode alloc] initWithHtmlBoby:_detailModel.article.body];
                return cellNode;
            }
                break;
            case 1:
            {
                NSArray *floors = _detailModel.tie.commentIds[indexPath.row];
                NSString *key = floors.firstObject;
                NewsCommentItem *commentItem = _detailModel.tie.comments[key];
                NewsCommentCellNode *cellNode = [[NewsCommentCellNode alloc] initWithcommentItem:commentItem];
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
    };
    return cellNodeBlock;
    
}

#pragma mark - tableView dataSource

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
