//
//  RecommendImageInfoCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
@class RecommendImageInfoModel;

@interface RecommendImageInfoCellNode : ASCellNode

- (instancetype)initWithImageInfoModel:(RecommendImageInfoModel *)imageInfoModel;

@end
