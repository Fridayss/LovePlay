//
//  RecommendImagePagerCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class RecommendImageInfoModel;

typedef void (^imagePagerSelectedBlock)(RecommendImageInfoModel *imageInfoModel);

@interface RecommendImagePagerCellNode : ASCellNode

- (instancetype)initWithImageInfoDatas:(NSArray *)imageInfoDatas;

- (void)recommendImagePagerSelectedBlock:(imagePagerSelectedBlock)selectedBlock;

@end
