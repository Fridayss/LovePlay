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

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsDetailWebCellNode";
    NewsDetailWebCellNode *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsDetailWebCellNode alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
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
    [self.contentView addSubview:webView];
    _webView = webView;
}

- (void)setupHtmlBoby:(NSString *)htmlBody
{
    _htmlBody = htmlBody;
    [_webView loadHTMLString:_htmlBody baseURL:nil];
}

#pragma mark - webView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    _webViewHeight = webViewHeight;
    
    if (_finishLoadBlock) {
        _finishLoadBlock(webViewHeight);
    }
}


#pragma mark - layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    if (_webViewHeight > 0) {
        _webView.height = _webViewHeight;
    }
    
}

- (void)dealloc
{
    _webView.delegate = nil;
    _webView = nil;
}

@end
