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
@property (nonatomic, copy) imagePagerSelectedBlock selectedBlock;
@end

@implementation RecommendImagePagerCellNode

- (instancetype)initWithImageInfoDatas:(NSArray *)imageInfoDatas
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        _imageInfoDatas = imageInfoDatas;
        self.userInteractionEnabled = YES;
        [self addPagerNode];
    }
    return self;
}

- (void)recommendImagePagerSelectedBlock:(imagePagerSelectedBlock)selectedBlock
{
    _selectedBlock = selectedBlock;
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
    NSLog(@"enable -- %d, allow -- %d", _pagerNode.view.pagingEnabled, _pagerNode.view.allowsSelection);
    _pagerNode.view.pagingEnabled = NO;
    _pagerNode.view.allowsSelection = YES;
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
     return ASSizeRangeMake(CGSizeMake(267, self.view.height),CGSizeMake(267, self.view.height));
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendImageInfoModel *imageInfoModel = _imageInfoDatas[indexPath.row];
    NSLog(@"title -- %@", imageInfoModel.title);
    if (_selectedBlock) {
        _selectedBlock(imageInfoModel);
    }
}

@end
