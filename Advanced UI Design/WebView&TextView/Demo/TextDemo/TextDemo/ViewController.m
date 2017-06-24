//
//  ViewController.m
//  TextDemo
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "NETextViewController.h"
#import "NERichTextViewController.h"
#import "NELoginViewController.h"
#import "NELoginInputViewController.h"

typedef NS_ENUM(NSInteger, NEDemoType) {
    NEDemoLogin = 1,
    NEDemoLoginInputView,
    NEDemoTextView,
    NEDemoRichText,
};

static NSString * const  kUICellIdentifier = @"UICellIdentifier";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.dataList addObject:@{@"tag": @(NEDemoLogin), @"title":@"登录界面"}];
    [self.dataList addObject:@{@"tag": @(NEDemoLoginInputView), @"title":@"更改InputView"}];
    [self.dataList addObject:@{@"tag": @(NEDemoTextView), @"title":@"UITextView"}];
    [self.dataList addObject:@{@"tag": @(NEDemoRichText), @"title":@"富文本"}];
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
        case NEDemoTextView:
            controller = [[NETextViewController alloc] init];
            break;
            
        case NEDemoRichText:
            controller = [[NERichTextViewController alloc] init];
            break;
            
        case NEDemoLogin:
            controller = [[NELoginViewController alloc] init];
            break;
            
        case NEDemoLoginInputView:
            controller = [[NELoginInputViewController alloc] init];
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
