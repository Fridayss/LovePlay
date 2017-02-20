//
//  NewsImageTitleCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
@class NewsListInfoModel;

@interface NewsImageTitleCellNode : ASCellNode

#pragma mark - interface
- (instancetype)initWithListInfoModel:(NewsListInfoModel *)listInfoModel;

@end
