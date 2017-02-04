//
//  RecommendTopicCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
@class RecommendTopicModel;

@interface RecommendTopicCellNode : ASCellNode

- (instancetype)initWithTopicModel:(RecommendTopicModel *)topicModel;

@end
