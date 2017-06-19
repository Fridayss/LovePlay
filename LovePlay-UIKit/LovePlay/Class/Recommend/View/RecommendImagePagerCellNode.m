//
//  RecommendImagePagerCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "RecommendImagePagerCellNode.h"
#import "RecommendImageInfoModel.h"
#import "RecommendImageInfoCellNode.h"

@interface RecommendImagePagerCellNode ()<UICollectionViewDelegate, UICollectionViewDataSource>
//UI
@property (nonatomic, strong) UICollectionView *pagerNode;
//Data
@property (nonatomic, strong) NSArray *imageInfoDatas;
@property (nonatomic, copy) imagePagerSelectedBlock selectedBlock;
@end

@implementation RecommendImagePagerCellNode

static NSString * const imageInfoCell = @"imageInfoCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addPagerNode];
        [self mas_subViews];
    }
    return self;
}

#pragma mark - private
- (void)addPagerNode
{
    [self.contentView addSubview:self.pagerNode];
}

- (void)mas_subViews
{
    [_pagerNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - public
- (void)recommendImagePagerSelectedBlock:(imagePagerSelectedBlock)selectedBlock
{
    _selectedBlock = selectedBlock;
}

- (void)setupImageInfoDatas:(NSArray *)imageInfoDatas
{
    _imageInfoDatas = imageInfoDatas;
    [_pagerNode reloadData];
}

#pragma mark - pagerNode datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageInfoDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendImageInfoModel *imageInfoModel = _imageInfoDatas[indexPath.row];
    RecommendImageInfoCellNode *cellNode = [collectionView dequeueReusableCellWithReuseIdentifier:imageInfoCell forIndexPath:indexPath];
    [cellNode setupImageInfoModel:imageInfoModel];
    return cellNode;
}

#pragma mark - pagerNode delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendImageInfoModel *imageInfoModel = _imageInfoDatas[indexPath.row];
    NSLog(@"title -- %@", imageInfoModel.title);
    if (_selectedBlock) {
        _selectedBlock(imageInfoModel);
    }
}


#pragma mark - setter / getter
- (UICollectionView *)pagerNode
{
    if (!_pagerNode) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        flowLayout.itemSize = CGSizeMake(267, self.contentView.height);
        
        UICollectionView *pagerNode = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:flowLayout];
        pagerNode.backgroundColor = [UIColor whiteColor];
        pagerNode.delegate = self;
        pagerNode.dataSource = self;
        pagerNode.pagingEnabled = NO;
        pagerNode.showsHorizontalScrollIndicator = NO;
        [pagerNode registerClass:[RecommendImageInfoCellNode class] forCellWithReuseIdentifier:imageInfoCell];
        _pagerNode = pagerNode;
    }
    return _pagerNode;
}


@end
