//
//  NEWebViewController.m
//  WebViewDemo
//
//  Created by NetEase on 16/7/15.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NEWebViewController.h"

@interface NEWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIView *controlBar;
@property (nonatomic, strong) UIButton *prevButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation NEWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCustomView];
    [self loadControlBar];
}

- (void)loadCustomView {
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = self.view.frame;
    frame.size.height -= 50.0;
    _webView = [[UIWebView alloc]initWithFrame:frame];
    [self.view addSubview:_webView];
    
    NSString *urlString = [self.urlString length] > 0 ? self.urlString : @"http://you.163.com/act/pub/LgXPqEvmf2.html";
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

- (void)loadControlBar {
    CGFloat controlBarHeight = 50.0;
    CGFloat totalWidth = CGRectGetWidth(self.view.frame);
    CGFloat totalHeight = CGRectGetHeight(self.view.frame);
    CGFloat webViewHeight = CGRectGetHeight(self.view.frame) - controlBarHeight;
    _controlBar  = [[UIView alloc] initWithFrame:CGRectMake(0, webViewHeight, totalWidth, totalHeight)];
    _controlBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_controlBar];
    _controlBar.userInteractionEnabled = YES;
    
    CGFloat buttonWidth   = 80;
    CGFloat buttonSpace = (totalWidth - 4 * buttonWidth) / 5;
    _prevButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonSpace, 0, buttonWidth, controlBarHeight)];
    [_prevButton setTitle:@"上一页" forState:UIControlStateNormal];
    _prevButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_prevButton addTarget:self action:@selector(preAction:) forControlEvents:UIControlEventTouchUpInside];
    [_controlBar addSubview:_prevButton];
    
    _nextButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonSpace * 2 + buttonWidth, 0, buttonWidth, controlBarHeight)];
    [_nextButton setTitle:@"下一页" forState:UIControlStateNormal];
    _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [_controlBar addSubview:_nextButton];
    
    _refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonSpace * 3 + buttonWidth * 2, 0, buttonWidth, controlBarHeight)];
    [_refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    _refreshButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_refreshButton addTarget:self action:@selector(refreshWebView:) forControlEvents:UIControlEventTouchUpInside];
    [_controlBar addSubview:_refreshButton];
    
    _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonSpace * 4 + buttonWidth * 3, 0, buttonWidth, controlBarHeight)];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_controlBar addSubview:_cancelButton];
    [_cancelButton addTarget:self action:@selector(cancelLoadingView:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions

- (IBAction)preAction:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self showAlertMessage:@"当前页面不可后退"];
    }
}

- (IBAction)nextAction:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    } else {
        [self showAlertMessage:@"当前页面不可前进"];
    }
}

- (IBAction)refreshWebView:(id)sender {
    if ([self.webView isLoading]) {
        [self showAlertMessage:@"当前页面未加载完成"];
    } else {
        [self.webView reload];
    }
}

- (IBAction)cancelLoadingView:(id)sender {
    if ([self.webView isLoading]) {
        [self.webView stopLoading];
    } else {
        [self showAlertMessage:@"当前页面已加载完成，不能取消"];
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark - Show Alert Messages

- (void)showAlertMessage:(NSString *)message {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
