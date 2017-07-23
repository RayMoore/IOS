//
//  ProgressUploadDemoViewController.m
//  HTTPDemo
//
//  Created by Netease on 16/8/26.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ProgressUploadDemoViewController.h"
#import "NECircleChart.h"

@interface ProgressUploadDemoViewController () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) UIButton *uploadBtn;

@property (nonatomic, strong) NECircleChart *circleChart;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSString *responseString;

@end

@implementation ProgressUploadDemoViewController

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
    self.uploadBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 80, 120, 44)];
    [self.uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
    self.uploadBtn.backgroundColor = [UIColor orangeColor];
    [self.uploadBtn addTarget:self action:@selector(uploadFileWithProgress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uploadBtn];
    
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

- (void)uploadFileWithProgress {
    self.circleChart.current = @(0);
    [self.circleChart setNeedsDisplay];
    
    NSURL *url = [NSURL URLWithString:@"http://posttestserver.com/post.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"IMG_2846" withExtension:@"JPG"];
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
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:body];
    [task resume];
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

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    self.circleChart.current = @(totalBytesSent * 100 / totalBytesExpectedToSend);
    NSLog(@"上传进度: %@%%", self.circleChart.current);
    if (self.circleChart.current.integerValue > 0) {
        [self.circleChart setNeedsDisplay];
    }
}

@end
