//
//  DiscussDetailWebCell.m
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussDetailWebCell.h"

@interface DiscussDetailWebCell ()<UIWebViewDelegate>
//UI
@property (nonatomic, strong) UIWebView *webView;
//Data
@property (nonatomic, strong) NSString *htmlBody;
@property (nonatomic, assign) CGFloat webViewHeight;
@property (nonatomic, copy) webViewFinishLoadBlock finishLoadBlock;
@end

@implementation DiscussDetailWebCell

- (instancetype)initWithHtmlBody:(NSString *)htmlBody
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _htmlBody = htmlBody;
//        [self addSubnodes];
//        [self loadWebHtml];
    }
    return self;
}

- (void)webViewDidFinishLoadBlock:(webViewFinishLoadBlock)finishLoadBlock
{
    _finishLoadBlock = finishLoadBlock;
}

- (void)addSubnodes
{
    UIWebView *webView = [[UIWebView alloc] init];
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

- (void)loadWebHtml
{
    [_webView loadHTMLString:_htmlBody baseURL:nil];
}

- (void)didLoad
{
    [super didLoad];
    
    [self addSubnodes];
    [self loadWebHtml];
}

#pragma mark - webView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue] + 10;
    if (_finishLoadBlock) {
        _finishLoadBlock(webViewHeight);
    }
    _webViewHeight = webViewHeight;
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
