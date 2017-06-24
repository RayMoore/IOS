//
//  NEWKWebViewController.h
//  WebViewDemo
//
//  Created by Netease on 16/7/18.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface NEWKWebViewController : UIViewController

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *urlString;

@end
