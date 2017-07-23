//
//  ViewController.m
//  SDWebImageDemo
//
//  Created by NetEase on 16/8/31.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "SDWebImageDemoController.h"
#import "SDWebImage/SDImageCache.h"
#import "SDWebImage/SDWebImageManager.h"
#import "SDWebImage/SDWebImageDownloader.h"

typedef NS_ENUM(NSInteger, NEDemoType) {
    NEDemoSDWebImage = 1,      // 基本用法
    NEDemoDownloadFile,        // 下载文件
    NEDemoGetCacheSize,        // 获取缓存大小
    NEDemoClearCache,          // 清除缓存
};

static NSString * const  kUICellIdentifier = @"UICellIdentifier";
NSString * const kDownloadImageFileURL = @"http://posttestserver.com/files/2016/11/27/f_17.43.112127782985";
//NSString * const kDownloadImageFileURL = @"http://posttestserver.com/files/2016/08/30/f_21.48.332024410400";

//NSString * const kDownloadImageFileURL = @"http://posttestserver.com/files/2016/11/27/f_17.28.182134603247";


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.dataList addObject:@{@"tag": @(NEDemoSDWebImage), @"title":@"SDWebImage使用"}];
    [self.dataList addObject:@{@"tag": @(NEDemoDownloadFile), @"title":@"SDWebImage下载文件"}];
    [self.dataList addObject:@{@"tag": @(NEDemoGetCacheSize), @"title":@"获取缓存Size"}];
    [self.dataList addObject:@{@"tag": @(NEDemoClearCache), @"title":@"清除缓存"}];
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
    switch (demoType) {
        case NEDemoSDWebImage:
            [self demoSDWebImage];
            break;
            
        case NEDemoDownloadFile:
            [self demoDownloadFile];
            break;
            
        case NEDemoGetCacheSize:
            [self demoGetCacheSize];
            break;
            
        case NEDemoClearCache:
            [self demoClearCache];
            
        default:
            break;
    }
}

#pragma mark - Demos

- (void)demoSDWebImage {
    SDWebImageDemoController *controller = [[SDWebImageDemoController alloc] init];
    controller.title = @"SDWebImage基本使用";
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)demoDownloadFile {
    NSURL *imageURL = [NSURL URLWithString:kDownloadImageFileURL];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:imageURL
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // 进度处理
                             NSLog(@"receivedSize: %@, total Size : %@, progress : %@", @(receivedSize), @(expectedSize), expectedSize != 0 ? @(100.0 * receivedSize / expectedSize) : @(100));
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                // 图片处理
                            }
                        }];
}

- (void)demoGetCacheSize {
    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        NSString *message = [NSString stringWithFormat:@"Total Cache Size: %@, file Count: %@", @(totalSize), @(fileCount)];
        [self showAlertMessage:message];
    }];
    
//    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
}

- (void)demoClearCache {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self showAlertMessage:@"缓存已清除"];
    }];
    
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)showAlertMessage:(NSString *)message {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
