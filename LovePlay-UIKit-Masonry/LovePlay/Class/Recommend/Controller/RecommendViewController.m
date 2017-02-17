//
//  RecommendViewController.m
//  LovePlay
//
//  Created by weiying on 2017/1/23.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "RecommendViewController.h"
//M
#import "RecommendTopicModel.h"
#import "RecommendImageInfoModel.h"
//V
#import "RecommendTopicCellNode.h"
#import "RecommendImagePagerCellNode.h"
//C
#import "NewsDetailViewController.h"
#import "RecommendGameViewController.h"

@interface RecommendViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//UI
@property (nonatomic, strong) UICollectionView *collectionNode;

//Data
@property (nonatomic, strong) NSArray *topicDatas;
@property (nonatomic, strong) NSArray *imageInfoDatas;
@end

@implementation RecommendViewController

static NSString * const imageCell = @"imageCell";
static NSString * const topicCell = @"topicCell";
static NSString * const footerSection = @"footerSection";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCollectionNode];
    [self loadData];
    //添加横竖屏通知，刷新顶部子view布局
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)addCollectionNode
{
    [self.view addSubview:self.collectionNode];
    
    //使用masonry刷新横竖屏切换布局
    [_collectionNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadData
{
    [self loadTopicData];
}

- (void)loadTopicData
{
    [[HttpRequest sharedInstance] GET:RecommendTopicURL parameters:nil success:^(id response) {
        NSLog(@"response -- %@", response);
        _topicDatas = [NSArray modelArrayWithClass:[RecommendTopicModel class] json:response[@"info"]];
        [self loadImageInfoData];
    } failure:^(NSError *error) {
        NSLog(@"error -- %@", error);
    }];

}

- (void)loadImageInfoData
{
    [[HttpRequest sharedInstance] GET:RecommendImageInfosURL parameters:nil success:^(id response) {
        _imageInfoDatas = [NSArray modelArrayWithClass:[RecommendImageInfoModel class] json:response[@"info"]];
        [_collectionNode reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error -- %@", error);
    }];
}

#pragma mark - collection datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return _topicDatas.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            RecommendImagePagerCellNode *cellNode = [collectionView dequeueReusableCellWithReuseIdentifier:imageCell forIndexPath:indexPath];
            [cellNode setupImageInfoDatas:_imageInfoDatas];
            [cellNode recommendImagePagerSelectedBlock:^(RecommendImageInfoModel *imageInfoModel) {
                NewsDetailViewController *newsDetailViewController = [[NewsDetailViewController alloc] init];
                newsDetailViewController.newsID = imageInfoModel.docid;
                [self.navigationController pushViewController:newsDetailViewController animated:YES];
            }];
            return cellNode;
        }
            break;
        case 1:
        {
            RecommendTopicModel *topicModel = _topicDatas[indexPath.row];
            RecommendTopicCellNode *cellNode = [collectionView dequeueReusableCellWithReuseIdentifier:topicCell forIndexPath:indexPath];
            [cellNode setupTopicModel:topicModel];
            return cellNode;
        }
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark + header and footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *cellNode = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerSection forIndexPath:indexPath];
        cellNode.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        return cellNode;
    }
    return nil;
}

#pragma mark - colleciton delegate
//设定区域内cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(self.view.width, 112);
            break;
        case 1:
            return CGSizeMake(80, 106);
            break;
        default:
            return CGSizeZero;
            break;
    }
}

//设定区域内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(15, 0, 15, 0);
            break;
        case 1:
            return UIEdgeInsetsMake(15, 15, 15, 15);
            break;
        default:
            return UIEdgeInsetsZero;
            break;
    }
}

//设定区域内最小行距（竖直方向）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 35;
            break;
        default:
            return 0;
            break;
    }
}

//设定区域内最小列距（水平方向）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 10;
            break;
        default:
            return 0;
            break;
    }
}

//点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        RecommendTopicModel *topicModel = _topicDatas[indexPath.row];
        RecommendGameViewController *gameViewController = [[RecommendGameViewController alloc] init];
        gameViewController.title = topicModel.topicName;
        gameViewController.sourceType = topicModel.sourceType;
        gameViewController.topicID = topicModel.topicId;
        [self.navigationController pushViewController:gameViewController animated:YES];
    }else{
        NSLog(@"recommend tap");
    }
}


#pragma mark + header and footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.view.frame.size.width, 6);
    }
    return CGSizeZero;
}

#pragma mark - notifi
- (void)changeRotate:(NSNotification*)noti {
    
    [_collectionNode reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

#pragma mark - setter / getter
- (UICollectionView *)collectionNode
{
    if (!_collectionNode) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collectionNode = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        collectionNode.backgroundColor = [UIColor whiteColor];
        collectionNode.delegate = self;
        collectionNode.dataSource = self;
        [collectionNode registerClass:[RecommendTopicCellNode class] forCellWithReuseIdentifier:topicCell];
        [collectionNode registerClass:[RecommendImagePagerCellNode class] forCellWithReuseIdentifier:imageCell];
        [collectionNode registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerSection];
        _collectionNode = collectionNode;
    }
    return _collectionNode;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
