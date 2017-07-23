//
//  StateDemoViewController.m
//  HTTPDemo
//
//  Created by Netease on 16/8/26.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "StateDemoViewController.h"
#import "NECircleChart.h"

@interface StateDemoViewController () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) UIButton *resumeBtn;
@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) NECircleChart *circleChart;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSString *responseString;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation StateDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self loadSubviews];
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

- (void)loadSubviews {
    self.downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 80, 44)];
    [self.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    self.downloadBtn.backgroundColor = [UIColor orangeColor];
    [self.downloadBtn addTarget:self action:@selector(downloadFileWithProgress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadBtn];
    
    self.pauseBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 80, 80, 44)];
    [self.pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [self.pauseBtn addTarget:self action:@selector(suspendTask) forControlEvents:UIControlEventTouchUpInside];
    self.pauseBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.pauseBtn];
    
    self.resumeBtn = [[UIButton alloc] initWithFrame:CGRectMake(190, 80, 80, 44)];
    [self.resumeBtn setTitle:@"继续" forState:UIControlStateNormal];
    [self.resumeBtn addTarget:self action:@selector(resumeTask) forControlEvents:UIControlEventTouchUpInside];
    self.resumeBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.resumeBtn];
    
    self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 80, 80, 44)];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelTask) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.cancelBtn];
    
    CGRect rect = CGRectMake(0, 150.0, CGRectGetWidth(self.view.frame), 200.0);
    self.circleChart = [[NECircleChart alloc] initWithFrame:rect
                                                      total:@100
                                                    current:@(0)
                                                  clockwise:YES];
    self.circleChart.backgroundColor = [UIColor clearColor];
    [self.circleChart setStrokeColor:[UIColor orangeColor]];
    [self.view addSubview:self.circleChart];
}

#pragma mark - Test

- (void)downloadFileWithProgress {
    self.circleChart.current = @(0);
    [self.circleChart setNeedsDisplay];
    
    NSURL *url = [NSURL URLWithString:@"https://codeload.github.com/AFNetworking/AFNetworking/zip/master"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.downloadTask = [session downloadTaskWithRequest:request];
    [self.downloadTask resume];
}

- (void)resumeTask {
    [self.downloadTask resume];
}

- (void)suspendTask {
    [self.downloadTask suspend];
}

- (void)cancelTask {
    [self.downloadTask cancel];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSStringEncoding stringEncoding = NSUTF8StringEncoding;
    self.responseString = [[NSString alloc] initWithData:self.
                           responseData encoding:stringEncoding];
    NSLog(@"%@", self.responseString);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    if (nil != data) {
        [self.responseData appendData:data];
    }
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

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *destination = [documentsDirectoryURL URLByAppendingPathComponent:[downloadTask.response suggestedFilename]];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:destination error:nil];
    
    self.circleChart.current = @(100);
    [self.circleChart setNeedsDisplay];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    self.circleChart.current = @(totalBytesWritten * 100 / totalBytesExpectedToWrite);
    NSLog(@"下载进度: %@%%", self.circleChart.current);
    if (self.circleChart.current.integerValue > 1) {
        [self.circleChart setNeedsDisplay];
    }
}

@end
