//
//  ZoneListViewController.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "ZoneListViewController.h"
//M
#import "ZoneListModel.h"
//V
#import "ZoneListCell.h"
#import "ZoneListHeaderView.h"
//C
#import "DiscussListViewController.h"

static NSString *zoneListCell = @"zoneListCell";
static NSString *zoneListHeader = @"zoneListHeader";

@interface ZoneListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//UI
@property (nonatomic, strong) UICollectionView *colletionView;
//Data
@property (nonatomic, strong) NSArray *zoneDatas;
@end

@implementation ZoneListViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCollectionView];
    [self loadData];
}

#pragma mark - init
- (void)addCollectionView
{
    [self.view addSubview:self.colletionView];
}

- (void)loadData
{
    [[HttpRequest sharedInstance] GET:ZoneDiscussURL parameters:nil success:^(id response) {
        NSLog(@"list-succ : %@", response);
        ZoneListModel *listModel = [ZoneListModel modelWithJSON:response[@"info"]];
        _zoneDatas = listModel.discuzList;
        [_colletionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"list-fail : %@", error);
    }];
}

#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _zoneDatas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ZoneDiscussDetail *discussDetail = _zoneDatas[section];
    return discussDetail.detailList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZoneDiscussDetail *discussDetail = _zoneDatas[indexPath.section];
    ZoneDiscussItem *discussItem = discussDetail.detailList[indexPath.row];
    ZoneListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zoneListCell forIndexPath:indexPath];
    cell.discussItem = discussItem;
    return cell;
}

#pragma mark + header and footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZoneDiscussDetail *discussDetail = _zoneDatas[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZoneListHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:zoneListHeader forIndexPath:indexPath];
        headerView.titleName = discussDetail.type.typeName;
        return headerView;
    }
    return nil;
}

#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZoneDiscussDetail *discussDetail = _zoneDatas[indexPath.section];
    ZoneDiscussItem *discussItem = discussDetail.detailList[indexPath.row];
    DiscussListViewController *discussListViewController = [[DiscussListViewController alloc] init];
    discussListViewController.fid = @(discussItem.fid).stringValue;
    [self.navigationController pushViewController:discussListViewController animated:YES];
}

#pragma mark + header and footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 30);
}

#pragma mark - setter / getter
- (UICollectionView *)colletionView
{
    if (!_colletionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        flowLayout.itemSize = CGSizeMake((self.view.bounds.size.width - 1) / 2, 70);
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        collectionView.backgroundColor = RGB(245, 245, 245);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[ZoneListCell class] forCellWithReuseIdentifier:zoneListCell];
        [collectionView registerClass:[ZoneListHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:zoneListHeader];
        _colletionView = collectionView;
    }
    return _colletionView;
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
