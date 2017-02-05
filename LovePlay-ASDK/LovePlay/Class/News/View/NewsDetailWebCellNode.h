//
//  NewsDetailWebCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

typedef void (^webViewFinishLoadBlock)();

@interface NewsDetailWebCellNode : ASCellNode

- (instancetype)initWithHtmlBoby:(NSString *)htmlBody;

- (void)webViewDidFinishLoadBlock:(webViewFinishLoadBlock)finishLoadBlock;

@end
