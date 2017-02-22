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
//V(C)
#import "DiscussListViewController.h"
//MV
#import "ZoneListViewModel.h"

static NSString *zoneListCell = @"zoneListCell";
static NSString *zoneListHeader = @"zoneListHeader";

@interface ZoneListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//UI
@property (nonatomic, strong) UICollectionView *colletionView;
//Data
//@property (nonatomic, strong) NSArray *zoneDatas;
@property (nonatomic, strong) ZoneListViewModel *listViewModel;
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
    //使用masonry刷新横竖屏切换布局
    [_colletionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadData
{
    [[self.listViewModel.fetchZoneListCommand execute:nil] subscribeNext:^(id x) {
        [_colletionView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.listViewModel.listModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ZoneDiscussDetail *discussDetail = self.listViewModel.listModels[section];
    return discussDetail.detailList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZoneDiscussDetail *discussDetail = self.listViewModel.listModels[indexPath.section];
    ZoneDiscussItem *discussItem = discussDetail.detailList[indexPath.row];
    ZoneListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zoneListCell forIndexPath:indexPath];
    [cell setupDiscussItem:discussItem];
    return cell;
}

#pragma mark + header and footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZoneDiscussDetail *discussDetail = self.listViewModel.listModels[indexPath.section];
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
    ZoneDiscussDetail *discussDetail = self.listViewModel.listModels[indexPath.section];
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

- (ZoneListViewModel *)listViewModel
{
    if (!_listViewModel) {
        ZoneListViewModel *listViewModel = [[ZoneListViewModel alloc] init];
        _listViewModel = listViewModel;
    }
    return _listViewModel;
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
