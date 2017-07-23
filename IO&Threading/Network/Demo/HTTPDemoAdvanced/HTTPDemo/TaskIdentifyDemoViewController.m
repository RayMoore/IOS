//
//  TaskIdentifyDemoViewController.m
//  HTTPDemo
//
//  Created by Netease on 16/8/26.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TaskIdentifyDemoViewController.h"
#import "NECircleChart.h"

@interface TaskIdentifyDemoViewController () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) UIButton *testBtn;
@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) NSMutableDictionary *taskResponseObject;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSString *responseString;

@end

@implementation TaskIdentifyDemoViewController

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
    self.testBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 160, 44)];
    [self.testBtn setTitle:@"测试Task标识" forState:UIControlStateNormal];
    self.testBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.testBtn.backgroundColor = [UIColor orangeColor];
    [self.testBtn addTarget:self action:@selector(testTaskIdentify) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testBtn];
}

#pragma mark - Test

- (void)testTaskIdentify {
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    for (int i = 0; i < 10; i++) {
        NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/17604305?fields=title,id,url,publisher,author"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
        [task resume];
    }
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"Task %@ finished", @(task.taskIdentifier));
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    //
}

@end
