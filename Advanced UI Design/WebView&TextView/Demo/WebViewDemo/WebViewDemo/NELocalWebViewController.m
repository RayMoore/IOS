//
//  NELocalWebViewController.m
//  WebViewDemo
//
//  Created by NetEase on 16/7/15.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NELocalWebViewController.h"

@interface NELocalWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation NELocalWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCustomView];
}

- (void)loadCustomView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
    
//    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];

    [self.view addSubview:_webView];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *scheme = request.URL.scheme;
    if ([scheme isEqualToString:@"demo"]) {
        [self callNativeMethodWithHost:request.URL.host path:request.URL.path params:request.URL.parameterString];
        return NO;
    }
    
    return YES;
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
