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

@interface RecommendImagePagerCellNode ()
//<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *imageInfoDatas;
@property (nonatomic, strong) UICollectionView *pagerNode;
@property (nonatomic, copy) imagePagerSelectedBlock selectedBlock;
@end

@implementation RecommendImagePagerCellNode

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        
//        [self addPagerNode];
//        [self sd_layoutSubviews];
    }
    return self;
}

- (void)recommendImagePagerSelectedBlock:(imagePagerSelectedBlock)selectedBlock
{
    _selectedBlock = selectedBlock;
}

- (void)addPagerNode
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    flowLayout.itemSize = CGSizeMake(267, self.height);

    UICollectionView *pagerNode = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    pagerNode.userInteractionEnabled = YES;
    pagerNode.delegate = self;
    pagerNode.dataSource = self;
    pagerNode.pagingEnabled = NO;
    [self.contentView addSubview:pagerNode];
    _pagerNode = pagerNode;
}

- (void)setupImageInfoDatas:(NSArray *)imageInfoDatas
{
    _imageInfoDatas = imageInfoDatas;

}

#pragma mark - layout
//- (void)sd_layoutSubviews
//{
//    _pagerNode.sd_layout.topEqualToView(self.contentView).leftEqualToView(self.contentView).bottomEqualToView(self.contentView).rightEqualToView(self.contentView);
//}

//- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
//{
//    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:_pagerNode];
//    return insetLayout;
//}

#pragma mark - pagerNode datasource

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return _imageInfoDatas.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    RecommendImageInfoModel *imageInfoModel = _imageInfoDatas[indexPath.row];
//    RecommendImageInfoCellNode *cellNode = [[RecommendImageInfoCellNode alloc] initWithImageInfoModel:imageInfoModel];
//    return cellNode;
//}
//
//#pragma mark - pagerNode delegate
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    RecommendImageInfoModel *imageInfoModel = _imageInfoDatas[indexPath.row];
//    NSLog(@"title -- %@", imageInfoModel.title);
//    if (_selectedBlock) {
//        _selectedBlock(imageInfoModel);
//    }
//}

@end
