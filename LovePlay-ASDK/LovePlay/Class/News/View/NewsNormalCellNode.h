//
//  NewsNormalCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/30.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
@class NewsListInfoModel;

@interface NewsNormalCellNode : ASCellNode

- (instancetype)initWithListInfoModel:(NewsListInfoModel *)listInfoModel;


@end
