//
//  StateDemoViewController.m
//  HTTPDemo
//
//  Created by Netease on 16/8/26.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "AFDemoViewController.h"
#import "AFDemoClient.h"

typedef NS_ENUM(NSInteger, NEDemoType) {
    NEAFDemoMultipartFormDataWithProgress = 1,  // 表单上传进度
    NEAFDemoPostRequest,
    
    // For Charles Test
    NEAFDemoGetRequest,
    NEAFNormalPostRequest,
    NEAFNormalDownloadRequest,
    NEAFNormalHTTPSRequest
};

static NSString * const  kUICellIdentifier = @"AFDemoUICellIdentifier";
NSString * const kPutsreqTestPath = @"xN2udCbDttsRfAsHdLEd";
//NSString * const kPutsreqTestPath = @"0SMBaDzt2mCQn8UHXAir";

@interface AFDemoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataList;

@end

@implementation AFDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    [self.dataList addObject:@{@"tag": @(NEAFDemoMultipartFormDataWithProgress), @"title":@"上传文件"}];
    [self.dataList addObject:@{@"tag": @(NEAFDemoPostRequest), @"title":@"AFNetworkingPOST请求"}];
    
    [self.dataList addObject:@{@"tag": @(NEAFDemoGetRequest), @"title":@"GET请求"}];
    [self.dataList addObject:@{@"tag": @(NEAFNormalPostRequest), @"title":@"POST请求"}];
    [self.dataList addObject:@{@"tag": @(NEAFNormalDownloadRequest), @"title":@"下载文件"}];
    [self.dataList addObject:@{@"tag": @(NEAFNormalHTTPSRequest), @"title":@"HTTPS请求"}];
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
        case NEAFDemoMultipartFormDataWithProgress:
            [self uploadFileWithProgress];
            break;
            
        case NEAFDemoPostRequest:
            [self demoPostWithAFNetworking];
            break;
            
            
        case NEAFDemoGetRequest:
            [self demoGetWithAFNetworking];
            break;
            
        case NEAFNormalPostRequest:
            [self demoSimplePostWithAFNetworking];
            break;
            
        case NEAFNormalDownloadRequest:
            [self demoDownloadFileWithAFNetworking];
            break;
            
        case NEAFNormalHTTPSRequest:
            [self demoHTTPSRequestWithAFNetworking];
            break;
            
        default:
            break;
    }
}

#pragma mark - Demo 1: 上传文件

- (void)uploadFileWithProgress {
    [[AFDemoClient sharedClient] POST:@"http://posttestserver.com/post.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"Panda" withExtension:@"jpg"];
        [formData appendPartWithFileURL:fileURL name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"Upload Progress : %@", @(uploadProgress.fractionCompleted));
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功结果处理
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@ %@", responseObject, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败的结果处理
        if (error) {
            NSLog(@"Task: %@, Error: %@", task, error);
        }
    }];
}

- (void)demoPostWithAFNetworking {
    NSDictionary *parameters = @{@"book": @(17604305), @"title":@"好书", @"comment":@"我觉得这是一本好书", @"rating":@(5)};
    [[AFDemoClient sharedClient] POST:kPutsreqTestPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功结果处理
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@ %@", responseObject, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败的结果处理
        if (error) {
            NSLog(@"Task: %@, Error: %@", task, error);
        }
    }];
}

#pragma mark - For Charles

- (void)demoGetWithAFNetworking {
    [[AFDemoClient sharedClient] GET:@"http://httpbin.org/get" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功结果处理
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@ %@", responseObject, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败的结果处理
        if (error) {
            NSLog(@"Task: %@, Error: %@", task, error);
        }
    }];
    
}

- (void)demoSimplePostWithAFNetworking {
    NSDictionary *parameters = @{@"book": @(17604305), @"title":@"好书", @"comment":@"我觉得这是一本好书", @"rating":@(5)};
    [[AFDemoClient sharedClient] POST:@"http://httpbin.org/post" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功结果处理
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@ %@", responseObject, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败的结果处理
        if (error) {
            NSLog(@"Task: %@, Error: %@", task, error);
        }
    }];
}

- (void)demoDownloadFileWithAFNetworking {
    [[AFDemoClient sharedClient] GET:@"http://posttestserver.com/files/2016/11/27/f_17.43.112127782985" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功结果处理
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@ %@", responseObject, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败的结果处理
        if (error) {
            NSLog(@"Task: %@, Error: %@", task, error);
        }
    }];
}

- (void)demoHTTPSRequestWithAFNetworking {
    [[AFDemoClient sharedClient] GET:@"https://api.douban.com/v2/book/17604305?fields=title,id,url,publisher,author" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功结果处理
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@ %@", responseObject, responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败的结果处理
        if (error) {
            NSLog(@"Task: %@, Error: %@", task, error);
        }
    }];
}

@end
