//
//  ViewController.m
//  QuartzDemo
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "NEDemoDefinitions.h"
#import "NECircleProgressViewController.h"
#import "NEPieChartViewController.h"
#import "NERoundRectViewController.h"
#import "UIImage+NEKits.h"
#import "NESnapShotController.h"

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
    [self.dataList addObject:@{@"tag": @(NEDemoCircleProgress), @"title":@"进度展示"}];
    [self.dataList addObject:@{@"tag": @(NEDemoPieChart), @"title":@"饼状图"}];
    [self.dataList addObject:@{@"tag": @(NEDemoScreenShot), @"title":@"截屏"}];
    [self.dataList addObject:@{@"tag": @(NEDemoRoundRect), @"title":@"圆角"}];
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
        case NEDemoCircleProgress:
            controller = [[NECircleProgressViewController alloc] init];
            break;
            
        case NEDemoPieChart:
            controller = [[NEPieChartViewController alloc] init];
            break;
            
        case NEDemoScreenShot:
            controller = [[NESnapShotController alloc] init];
            break;
            
        case NEDemoRoundRect:
            controller = [[NERoundRectViewController alloc] init];
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
