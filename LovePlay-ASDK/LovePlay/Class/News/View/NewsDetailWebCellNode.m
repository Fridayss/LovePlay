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
@property (nonatomic, assign) CGFloat webViewHeight;
@property (nonatomic, copy) webViewFinishLoadBlock finishLoadBlock;
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

- (void)webViewDidFinishLoadBlock:(webViewFinishLoadBlock)finishLoadBlock
{
    _finishLoadBlock = finishLoadBlock;
}

- (void)addSubviews
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scalesPageToFit = NO;
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    [webView setAutoresizingMask:UIViewAutoresizingNone];
    [webView.scrollView setScrollEnabled:NO];
    [webView.scrollView setScrollsToTop:NO];
    [self.view addSubview:webView];
    _webView = webView;
}

- (void)didLoad
{
    [super didLoad];
    
    [self addSubviews];
    
    [self loadWebHtml];
}

- (void)loadWebHtml
{
    [_webView loadHTMLString:_htmlBody baseURL:nil];
}

#pragma mark - webView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue] + 12;
    if (_finishLoadBlock) {
        _finishLoadBlock();
    }
    [self setNeedsLayout];
}

#pragma mark - layout
- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
    return CGSizeMake(constrainedSize.width, _webViewHeight);
}

- (void)layout
{
    [super layout];
    _webView.frame = CGRectMake(0, 0, self.calculatedSize.width, _webViewHeight);
}

- (void)dealloc
{
    _webView.delegate = nil;
    _webView = nil;
}

@end
