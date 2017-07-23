//
//  ViewController.m
//  HTTPDemo
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "ProgressDemoViewController.h"
#import "ProgressUploadDemoViewController.h"
#import "StateDemoViewController.h"
#import "ShowStateDemoViewController.h"
#import "TaskIdentifyDemoViewController.h"

typedef NS_ENUM(NSInteger, NEDemoType) {
    NEDemoDownloadFile = 1,             // 普通下载文件
    NEDemoURLSessionDownloadTask,       // 使用NSURLSessionDownloadTask下载文件
    NEDemoDownloadFileProgress,         // 下载进度
    NEDemoUploadFile,                   // 上传文件
    NEDemoMultipartFormData,            // 表单上传
    NEDemoMultipartFormDataProgress,    // 表单上传进度
    NEDemoCancelTask,                   // 取消暂停与恢复
    NEDemoTaskState,                    // Task状态
    NEDemoSessionConfiguration,         // 请求配置
    NEDemoTaskIdentify,                 // Task标识
};

static NSString * const  kUICellIdentifier = @"UICellIdentifier";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataList;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSString *responseString;
@property (nonatomic, strong) id responseInfo;
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong) NSURLSession *session;

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
    [self.dataList addObject:@{@"tag": @(NEDemoDownloadFile), @"title":@"下载文件"}];
    [self.dataList addObject:@{@"tag": @(NEDemoURLSessionDownloadTask), @"title":@"NSURLSessionDownloadTask"}];
    [self.dataList addObject:@{@"tag": @(NEDemoDownloadFileProgress), @"title":@"下载进度"}];
    [self.dataList addObject:@{@"tag": @(NEDemoUploadFile), @"title":@"NSURLSessionUploadTask"}];
    [self.dataList addObject:@{@"tag": @(NEDemoMultipartFormData), @"title":@"Multipart/form-data"}];
    [self.dataList addObject:@{@"tag": @(NEDemoMultipartFormDataProgress), @"title":@"Multipart/form-data 进度展示"}];
    [self.dataList addObject:@{@"tag": @(NEDemoCancelTask), @"title":@"取消、暂停与恢复"}];
//    [self.dataList addObject:@{@"tag": @(NEDemoTaskState), @"title":@"任务状态变化"}];
    [self.dataList addObject:@{@"tag": @(NEDemoSessionConfiguration), @"title":@"请求配置"}];
    [self.dataList addObject:@{@"tag": @(NEDemoTaskIdentify), @"title":@"任务标识"}];
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
        case NEDemoDownloadFile:
            [self testDownloadFile];
            break;
            
        case NEDemoURLSessionDownloadTask:
            [self testURLSessionDownloadTask];
            break;
            
        case NEDemoDownloadFileProgress:
            [self testURLSessionDownloadTaskProgress];
            break;
            
        case NEDemoUploadFile:
            [self testNEDemoUploadTask];
            break;
            
        case NEDemoMultipartFormData:
            [self testUploadMultiPartImage];
            break;
            
        case NEDemoMultipartFormDataProgress:
            [self testUploadMultiPartImageProgress];
            break;
            
        case NEDemoCancelTask:
            [self testSessionTaskCancel];
            break;
            
        case NEDemoTaskState:
            [self testSessionTaskState];
            break;
            
        case NEDemoSessionConfiguration:
            [self testSessionConfiguration];
            break;
            
        case NEDemoTaskIdentify:
            [self testSessionTaskIdentify];
            break;
            
        default:
            break;
    }
}

#pragma mark - Demo 1: 下载文件

- (void)testDownloadFile {
    NSURL *url = [NSURL URLWithString:@"https://codeload.github.com/AFNetworking/AFNetworking/zip/master"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.response = response;
        if (error.code == 0 && nil != data) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *destination = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            [data writeToURL:destination atomically:NO];
        }
    }];
    [task resume];
}

#pragma mark - Demo 2: NSURLSessionDownloadTask

- (void)testURLSessionDownloadTask {
    NSURL *url = [NSURL URLWithString:@"https://codeload.github.com/AFNetworking/AFNetworking/zip/master"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error.code == 0) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *destination = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:destination error:nil];
        }
    }];
    [task resume];
}

#pragma mark - Demo 3: NSURLSessionDownloadTask 进度

- (void)testURLSessionDownloadTaskProgress {
    ProgressDemoViewController *controller = [[ProgressDemoViewController alloc] init];
    if (controller) {
        controller.title = @"下载进度";
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Demo 4 Upload File

- (void)testNEDemoUploadTask {
    NSURL *url = [NSURL URLWithString:@"http://posttestserver.com/post.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"json"];
//    NSData *data = [NSData dataWithContentsOfURL:fileURL];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.response = response;
        if (nil != data) {
            self.responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"resonse String: %@", self.responseString);
        }
    }];
    [task resume];
}

#pragma mark - Demo 5 Upload File with Content-Type multipart/form-data

- (void)testUploadMultiPartImage {
    NSURL *url = [NSURL URLWithString:@"http://posttestserver.com/post.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"jpg"];
    NSData *data = [NSData dataWithContentsOfURL:fileURL];
    
    NSString* stringBoundary = [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
    NSString *bodyPrefixString = [NSString stringWithFormat:@"--%@\r\n", stringBoundary];
    NSString *bodySuffixString = [NSString stringWithFormat:@"\r\n--%@--\r\n", stringBoundary];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[bodyPrefixString dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"test.jpg\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];
    [body appendData:[bodySuffixString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *contentType = [[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", (long)[body length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.response = response;
        if (nil != data) {
            self.responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"resonse String: %@", self.responseString);
        }
    }];
    [task resume];
}


#pragma mark - Demo 6 Upload File with Content-Type multipart/form-data Add Progress

- (void)testUploadMultiPartImageProgress {
    ProgressUploadDemoViewController *controller = [[ProgressUploadDemoViewController alloc] init];
    if (controller) {
        controller.title = @"上传进度";
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Demo 7

- (void)testSessionTaskCancel {
    StateDemoViewController *controller = [[StateDemoViewController alloc] init];
    if (controller) {
        controller.title = @"取消与暂停";
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Demo 8

- (void)testSessionTaskState {
    ShowStateDemoViewController *controller = [[ShowStateDemoViewController alloc] init];
    if (controller) {
        controller.title = @"状态变化";
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Demo 9

- (void)testSessionConfiguration {
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/17604305?fields=title,id,url,publisher,author"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30;
    configuration.allowsCellularAccess = NO;
    configuration.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
    configuration.discretionary = YES;
    configuration.HTTPShouldSetCookies = YES;
    configuration.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
    // 可以设置统一的Header
    configuration.HTTPAdditionalHeaders = @{@"User-Agent": @"myTestDemo"};
    configuration.URLCache = [NSURLCache sharedURLCache];
    configuration.HTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    configuration.URLCredentialStorage = [NSURLCredentialStorage sharedCredentialStorage];
    
    // 注意: sessionWithConfiguration会copy这个configuration.
    //    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    self.session = [NSURLSession sessionWithConfiguration:configuration];
    self.session.configuration.timeoutIntervalForRequest = 20;
    NSURLSessionTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", response);
        self.response = response;
        self.responseData = [NSMutableData dataWithData:data];
        self.responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
        self.responseInfo = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    }];
    [task resume];
}

- (void)testRequestConfiguration {
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/17604305?fields=title,id,url,publisher,author"];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"Netease-HTTPDemo" forHTTPHeaderField:@"User-Agent"];
    request.timeoutInterval = 20;
    request.allowsCellularAccess = NO;
    request.HTTPShouldHandleCookies = NO;
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", response);
        self.response = response;
        self.responseData = [NSMutableData dataWithData:data];
        self.responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
        self.responseInfo = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    }];
    [task resume];
}

#pragma mark - Demo 10

- (void)testSessionTaskIdentify {
    TaskIdentifyDemoViewController *controller = [[TaskIdentifyDemoViewController alloc] init];
    if (controller) {
        controller.title = @"Task标识";
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    self.response = response;
    self.responseData = [NSMutableData data];
    if (completionHandler) {
        completionHandler(NSURLSessionResponseAllow);
    }
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSStringEncoding stringEncoding = NSUTF8StringEncoding;
    if (self.response.textEncodingName) {
        CFStringEncoding IANAEncoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)self.response.textEncodingName);
        if (IANAEncoding != kCFStringEncodingInvalidId) {
            stringEncoding = CFStringConvertEncodingToNSStringEncoding(IANAEncoding);
        }
    }
    
    self.responseString = [[NSString alloc] initWithData:self.responseData encoding:stringEncoding];
    self.responseInfo = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
}

#pragma mark - NSURLSessionDownloadDelegate 

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *destination = [documentsDirectoryURL URLByAppendingPathComponent:[downloadTask.response suggestedFilename]];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:destination error:nil];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"下载进度: %@", downloadTask);
}

@end

