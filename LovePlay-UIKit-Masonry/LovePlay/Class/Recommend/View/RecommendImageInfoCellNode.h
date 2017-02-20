//
//  RecommendImageInfoCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendImageInfoModel;

@interface RecommendImageInfoCellNode : UICollectionViewCell

#pragma mark - interface
- (void)setupImageInfoModel:(RecommendImageInfoModel *)imageInfoModel;

@end
