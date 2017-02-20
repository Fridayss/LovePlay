//
//  RecommendTopicCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecommendTopicModel;

@interface RecommendTopicCellNode : UICollectionViewCell

#pragma mark - interface
- (void)setupTopicModel:(RecommendTopicModel *)topicModel;

@end
