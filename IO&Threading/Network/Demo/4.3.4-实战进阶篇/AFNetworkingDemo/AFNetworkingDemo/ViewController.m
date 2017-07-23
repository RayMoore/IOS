//
//  ViewController.m
//  AFNetworkingDemo
//
//  Created by NetEase on 16/8/30.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "AFDemoViewController.h"

typedef NS_ENUM(NSInteger, NEDemoType) {
    NEDemoMultipartFormData = 1,        // 表单上传
    NEDemoMultipartFormDataWithProgress,  // 表单上传进度
    NEDemoDownloadFile, // 下载文件
    NEDemoPostRequest,  // 普通POST请求
    NEDemoAFNetworkingUseage,           // AFNetworking用法; 包括单例的用法
};


static NSString * const  kUICellIdentifier = @"UICellIdentifier";
NSString * const kPutsreqTestURL = @"http://putsreq.com/xN2udCbDttsRfAsHdLEd";
//NSString * const kPutsreqTestURL = @"http://putsreq.com/0SMBaDzt2mCQn8UHXAir";

NSString * const kImageFileURL = @"http://posttestserver.com/files/2016/11/27/f_17.43.112127782985";

//NSString * const kImageFileURL = @"http://posttestserver.com/files/2016/08/31/f_00.54.121088832015";

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
    [self.dataList addObject:@{@"tag": @(NEDemoMultipartFormData), @"title":@"上传文件"}];
    [self.dataList addObject:@{@"tag": @(NEDemoMultipartFormDataWithProgress), @"title":@"上传文件进度"}];
    [self.dataList addObject:@{@"tag": @(NEDemoDownloadFile), @"title":@"下载文件"}];
    [self.dataList addObject:@{@"tag": @(NEDemoPostRequest), @"title":@"AFNetworking请求"}];
    [self.dataList addObject:@{@"tag": @(NEDemoAFNetworkingUseage), @"title":@"AFNetworking使用"}];
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
        case NEDemoMultipartFormData:
            [self uploadFile];
            break;
            
        case NEDemoMultipartFormDataWithProgress:
            [self uploadFileWithProgress];
            break;
            
        case NEDemoDownloadFile:
            [self demoDownloadFile];
            break;
    
        case NEDemoPostRequest:
            [self demoPostWithAFNetworking];
            break;
            
        case NEDemoAFNetworkingUseage:
            [self demoAFNetworking];
            break;
            
        default:
            break;
    }
}

#pragma mark - Demo 1: 上传文件

- (void)uploadFile {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://posttestserver.com/post.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"jpg"];
        [formData appendPartWithFileURL:fileURL name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
          if (error) {
              NSLog(@"Error: %@", error);
          } else {
              NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              NSLog(@"%@ %@ %@", response, responseObject, responseString);
          }
    }];
    
    [uploadTask resume];
}

- (void)uploadFileWithProgress {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://posttestserver.com/post.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"Panda" withExtension:@"jpg"];
        [formData appendPartWithFileURL:fileURL name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"Upload Progress : %@", @(uploadProgress.fractionCompleted));
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@ %@ %@", response, responseObject, responseString);
        }
    }];
    
    [uploadTask resume];
}

- (void)demoDownloadFile {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:kImageFileURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"download progress : %@", @(downloadProgress.fractionCompleted));
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        return [documentsDirectoryURL URLByAppendingPathComponent:@"panda.jpg"];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

- (void)demoPostWithAFNetworking {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *URLString = kPutsreqTestURL;
    NSDictionary *parameters = @{@"book": @(17604305), @"title":@"好书", @"comment":@"我觉得这是一本好书", @"rating":@(5)};
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@ %@ %@", response, responseObject, responseString);
        }
    }];
    [dataTask resume];
}

- (void)demoAFNetworking {
    AFDemoViewController *controller = [[AFDemoViewController alloc] init];
    controller.title = @"AFNetworking使用";
    [self.navigationController pushViewController:controller animated:YES];
}

@end
