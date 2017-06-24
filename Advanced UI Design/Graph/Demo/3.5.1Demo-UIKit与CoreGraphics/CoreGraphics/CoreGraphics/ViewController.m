//
//  ViewController.m
//  CoreGraphics
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "NECoreGraphicsViewController.h"

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
    [self.dataList addObject:@{@"tag": @(NEViewHeader), @"title":@"人脸"}];
    [self.dataList addObject:@{@"tag": @(NEViewEllipse), @"title":@"椭圆"}];
    [self.dataList addObject:@{@"tag": @(NEViewCircle), @"title":@"圆形"}];
    [self.dataList addObject:@{@"tag": @(NEViewTriangle), @"title":@"三角形"}];
    [self.dataList addObject:@{@"tag": @(NEViewRectangle), @"title":@"矩形"}];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataList[indexPath.row] objectForKey:@"title"];
}

- (NEViewType)viewTypeAtIndexPath:(NSIndexPath *)indexPath {
    return (NEViewType)[[self.dataList[indexPath.row] objectForKey:@"tag"] integerValue];
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
    
    NECoreGraphicsViewController *controller = [[NECoreGraphicsViewController alloc] init];
    controller.title = [self titleAtIndexPath:indexPath];
    controller.viewType = [self viewTypeAtIndexPath:indexPath];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
