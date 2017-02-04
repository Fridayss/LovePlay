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

@interface RecommendImagePagerCellNode ()<ASPagerDelegate, ASPagerDataSource>
@property (nonatomic, strong) NSArray *imageInfoDatas;
@property (nonatomic, strong) ASPagerNode *pagerNode;
@end

@implementation RecommendImagePagerCellNode

- (instancetype)initWithImageInfoDatas:(NSArray *)imageInfoDatas
{
    self = [super init];
    if (self) {
        
        _imageInfoDatas = imageInfoDatas;
        self.userInteractionEnabled = YES;
        [self addPagerNode];
    }
    return self;
}

- (void)addPagerNode
{
    ASPagerFlowLayout *flowLayout = [[ASPagerFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);

    ASPagerNode *pagerNode = [[ASPagerNode alloc] initWithCollectionViewLayout:flowLayout];
    pagerNode.userInteractionEnabled = YES;
    pagerNode.delegate = self;
    pagerNode.dataSource = self;
//    pagerNode.view.pagingEnabled = NO;
    [self addSubnode:pagerNode];
    _pagerNode = pagerNode;
}

- (void)didLoad
{
    [super didLoad];
    _pagerNode.view.pagingEnabled = NO;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:_pagerNode];
    return insetLayout;
}

#pragma mark - pagerNode datasource
- (NSInteger)numberOfPagesInPagerNode:(ASPagerNode *)pagerNode
{
    return _imageInfoDatas.count;
}

- (ASCellNodeBlock)pagerNode:(ASPagerNode *)pagerNode nodeBlockAtIndex:(NSInteger)index
{
    RecommendImageInfoModel *imageInfoModel = _imageInfoDatas[index];
    ASCellNode *(^cellNodeBlock)() = ^ASCellNode *(){
        RecommendImageInfoCellNode *cellNode = [[RecommendImageInfoCellNode alloc] initWithImageInfoModel:imageInfoModel];
        return cellNode;
    };
    return cellNodeBlock;
}

#pragma mark - pagerNode delegate
- (ASSizeRange)pagerNode:(ASPagerNode *)pagerNode constrainedSizeForNodeAtIndex:(NSInteger)index
{
     return ASSizeRangeMake(CGSizeMake(267, 100),CGSizeMake(267, 100));
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendImageInfoModel *imageInfoModel = _imageInfoDatas[indexPath.row];
    NSLog(@"title -- %@", imageInfoModel.title);
}

@end
