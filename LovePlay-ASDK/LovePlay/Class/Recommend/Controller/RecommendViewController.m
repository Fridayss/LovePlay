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

@interface RecommendViewController ()<ASCollectionDelegate, ASCollectionDataSource, UICollectionViewDelegateFlowLayout>
//UI
@property (nonatomic, strong) ASCollectionNode *collectionNode;
//Data
@property (nonatomic, strong) NSArray *topicDatas;
@property (nonatomic, strong) NSArray *imageInfoDatas;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCollectionNode];
    [self loadData];
    
}

- (void)addCollectionNode
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    ASCollectionNode *collectionNode = [[ASCollectionNode alloc] initWithCollectionViewLayout:flowLayout];
    collectionNode.delegate = self;
    collectionNode.dataSource = self;
    collectionNode.frame = self.view.bounds;
    [collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionFooter];
    [self.view addSubnode:collectionNode];
    _collectionNode = collectionNode;
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
- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode
{
    return 2;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section
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

- (ASCellNodeBlock)collectionView:(ASCollectionView *)collectionView nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            ASCellNode *(^cellNodeBlock)() = ^ASCellNode *(){
                RecommendImagePagerCellNode *cellNode = [[RecommendImagePagerCellNode alloc] initWithImageInfoDatas:_imageInfoDatas];
                [cellNode recommendImagePagerSelectedBlock:^(RecommendImageInfoModel *imageInfoModel) {
                    NewsDetailViewController *newsDetailViewController = [[NewsDetailViewController alloc] init];
                    newsDetailViewController.newsID = imageInfoModel.docid;
                    [self.navigationController pushViewController:newsDetailViewController animated:YES];
                }];
                return cellNode;
            };
            return cellNodeBlock;
        }
            break;
        case 1:
        {
            RecommendTopicModel *topicModel = _topicDatas[indexPath.row];
            ASCellNode *(^cellNodeBlock)() = ^ASCellNode *(){
                RecommendTopicCellNode *cellNode = [[RecommendTopicCellNode alloc] initWithTopicModel:topicModel];
                return cellNode;
            };
            return cellNodeBlock;
        }
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark + header and footer
- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ASCellNode *cellNode = [[ASCellNode alloc] init];
        cellNode.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        return cellNode;
    }
    return nil;
}

#pragma mark - colleciton delegate
//设定区域内cell的尺寸
- (ASSizeRange)collectionView:(ASCollectionView *)collectionView constrainedSizeForNodeAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return ASSizeRangeMake(CGSizeMake(self.view.frame.size.width, 112), CGSizeMake(self.view.frame.size.width, 112));
            break;
        case 1:
            return ASSizeRangeMake(CGSizeMake(80, 106), CGSizeMake(80, 106));
            break;
        default:
            return ASSizeRangeMake(CGSizeZero, CGSizeZero);
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
- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
