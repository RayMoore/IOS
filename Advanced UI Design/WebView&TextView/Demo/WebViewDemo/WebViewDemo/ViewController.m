//
//  ViewController.m
//  WebViewDemo
//
//  Created by NetEase on 16/7/15.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "NEDemoDefinitions.h"
#import "NEWebViewController.h"
#import "NELocalWebViewController.h"
#import "NEWKWebViewController.h"
#import "NELocalWKWebViewController.h"

static NSString * const  kUICellIdentifier = @"UICellIdentifier";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self loadTableView];
    [self loadData];
}

- (void)loadTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kUICellIdentifier];
    [self.view addSubview:self.tableView];
}

- (void)loadData
{
    self.dataList = [NSMutableArray array];
    [self.dataList addObject:@{@"tag": @(NEDemoWeb), @"title":@"WebView 示例"}];
    [self.dataList addObject:@{@"tag": @(NEDemoLocal), @"title":@"本地页面"}];
    [self.dataList addObject:@{@"tag": @(NEDemoWKWeb), @"title":@"WKWebView 示例"}];
    [self.dataList addObject:@{@"tag": @(NEDemoWKLocal), @"title":@"WKWebView+本地页面"}];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataList[indexPath.row] objectForKey:@"title"];
}

- (NEDemoType)viewTypeAtIndexPath:(NSIndexPath *)indexPath {
    return (NEDemoType)[[self.dataList[indexPath.row] objectForKey:@"tag"] integerValue];
}

#pragma mark - table view datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUICellIdentifier];
    cell.textLabel.text = [self titleAtIndexPath:indexPath];
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NEDemoType demoType = [self viewTypeAtIndexPath:indexPath];
    UIViewController *controller = nil;
    switch (demoType) {
        case NEDemoWeb:
            {
                NEWebViewController *webController = [[NEWebViewController alloc] init];
//                webController.urlString = @"http://study.163.com";
                controller = webController;
            }
            
            break;
           
        case NEDemoLocal:
            {
                NELocalWebViewController *webController = [[NELocalWebViewController alloc] init];
                controller = webController;
            }
            
            break;
            
        case NEDemoWKWeb:
            {
                NEWKWebViewController *webController = [[NEWKWebViewController alloc] init];
                controller = webController;
            }
            
            break;
            
        case NEDemoWKLocal:
            {
                NELocalWKWebViewController *webController = [[NELocalWKWebViewController alloc] init];
                controller = webController;
            }
            
            break;
            
        default:
            break;
    }
    
    if (nil != controller) {
        controller.title = [self titleAtIndexPath:indexPath];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
