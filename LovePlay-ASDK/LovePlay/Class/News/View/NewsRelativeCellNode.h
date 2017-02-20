//
//  NewsRelativeCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class NewsRelativeInfo;
@interface NewsRelativeCellNode : ASCellNode

#pragma mark - interface
- (instancetype)initWithRelativeInfo:(NewsRelativeInfo *)relativeInfo;

@end
