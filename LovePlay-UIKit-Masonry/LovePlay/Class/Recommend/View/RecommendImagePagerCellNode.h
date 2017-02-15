//
//  RecommendImagePagerCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecommendImageInfoModel;

typedef void (^imagePagerSelectedBlock)(RecommendImageInfoModel *imageInfoModel);

@interface RecommendImagePagerCellNode : UICollectionViewCell

- (void)setupImageInfoDatas:(NSArray *)imageInfoDatas;

- (void)recommendImagePagerSelectedBlock:(imagePagerSelectedBlock)selectedBlock;

@end
