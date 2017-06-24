//
//  NEWKWebViewController.m
//  WebViewDemo
//
//  Created by Netease on 16/7/18.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NELocalWKWebViewController.h"

@interface NELocalWKWebViewController () < WKNavigationDelegate>

@end

@implementation NELocalWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCustomView];
}

- (void)loadCustomView {
    self.view.backgroundColor = [UIColor whiteColor];

    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURLRequest *request = navigationAction.request;
    NSString *scheme = request.URL.scheme;
    if ([scheme isEqualToString:@"demo"]) {
        [self callNativeMethodWithHost:request.URL.host path:request.URL.path params:request.URL.parameterString];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark - Calling Native Methods

- (void)callNativeMethodWithHost:(NSString *)host path:(NSString *)path params:(NSString *)params {
    if ([host isEqualToString:@"share"]) {
        [self showAlertMessage:@"UIWebView发起分享请求"];
    } else if ([host isEqualToString:@"login"]) {
        [self showAlertMessage:@"UIWebView发起登录请求"];
    } else if ([host isEqualToString:@"buy"]) {
        [self showAlertMessage:@"UIWebView发起购买请求"];
    } else {
        [self showAlertMessage:@"UIWebView发起其他请求"];
    }
}

- (void)showAlertMessage:(NSString *)message {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
