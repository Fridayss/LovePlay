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
@property (nonatomic, copy) webViewFinishLoadBlock finishLoadBlock;
@end

@implementation DiscussDetailWebCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DiscussDetailWebCell";
    DiscussDetailWebCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DiscussDetailWebCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)webViewDidFinishLoadBlock:(webViewFinishLoadBlock)finishLoadBlock
{
    _finishLoadBlock = finishLoadBlock;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubviews
{
    UIWebView *webView = [[UIWebView alloc] init];
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
    if (htmlBody.length > 0) {
        NSURL *cssURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"News" ofType:@"css"]];
        [_webView loadHTMLString:[self handleWithHtmlBody:htmlBody] baseURL:cssURL];
    }
}

#pragma mark - private
- (NSString *)handleWithHtmlBody:(NSString *)htmlBody
{
    NSString *html = [htmlBody stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSString *cssName = @"News.css";
    NSMutableString *htmlString =[[NSMutableString alloc]initWithString:@"<html>"];
    [htmlString appendString:@"<head><meta charset=\"UTF-8\">"];
    [htmlString appendString:@"<link rel =\"stylesheet\" href = \""];
    [htmlString appendString:cssName];
    [htmlString appendString:@"\" type=\"text/css\" />"];
    [htmlString appendString:@"</head>"];
    [htmlString appendString:@"<body>"];
    [htmlString appendString:html];
    [htmlString appendString:@"</body>"];
    [htmlString appendString:@"</html>"];
    return htmlString;
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _webView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

#pragma mark - webView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue] + 10;
    if (_finishLoadBlock) {
        _finishLoadBlock(webViewHeight);
    }
}

- (void)dealloc
{
    _webView.delegate = nil;
    _webView = nil;
}

@end
