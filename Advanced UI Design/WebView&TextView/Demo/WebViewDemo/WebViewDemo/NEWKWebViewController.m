//
//  NEWKWebViewController.m
//  WebViewDemo
//
//  Created by Netease on 16/7/18.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NEWKWebViewController.h"

@interface NEWKWebViewController () <WKNavigationDelegate>

@end

@implementation NEWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCustomView];
}

- (void)loadCustomView {
    self.view.backgroundColor = [UIColor whiteColor];

    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    NSString *urlString = [self.urlString length] > 0 ? self.urlString : @"http://you.163.com/act/pub/LgXPqEvmf2.html";
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    WKNavigation *navigation = [self.webView loadRequest:request];
    NSLog(@"%@", navigation);
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if ([result isKindOfClass:[NSString class]]) {
            self.navigationItem.title = result;
        }
    }];
}

@end
