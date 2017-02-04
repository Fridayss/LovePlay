//
//  NewsDetailWebCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailWebCellNode.h"

@interface NewsDetailWebCellNode ()<UIWebViewDelegate>
//UI
@property (nonatomic, strong) UIWebView *webView;
//Data
@property (nonatomic, strong) NSString *htmlBody;
@end

@implementation NewsDetailWebCellNode

- (instancetype)initWithHtmlBoby:(NSString *)htmlBody
{
    self = [super init];
    if (self) {
        _htmlBody = htmlBody;
    }
    return self;
}

- (void)addSubviews
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scalesPageToFit = NO;
    webView.delegate = self;
    webView.scrollView.bounces = NO;
//    [webView setAutoresizingMask:UIViewAutoresizingNone];
    [webView.scrollView setScrollEnabled:NO];
    [webView.scrollView setScrollsToTop:NO];
    [self.view addSubview:webView];
    _webView = webView;
}

#pragma mark - webView delegate

@end
