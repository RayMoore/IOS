//
//  ViewController.m
//  HTTPDemo
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, NEDemoType) {
    NEDemoConnection = 1,
    NEDemoSession,
    NEDemoSessionDelegate,
    NEDemoPostConnection,
    NEDemoPostSession,
    NEDemoRequest
};

static NSString * const  kUICellIdentifier = @"UICellIdentifier";
NSString * const kPutsreqTestURL = @"http://putsreq.com/xN2udCbDttsRfAsHdLEd";
//NSString * const kPutsreqTestURL = @"http://putsreq.com/0SMBaDzt2mCQn8UHXAir";


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataList;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSString *responseString;
@property (nonatomic, strong) id responseInfo;

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
    [self.dataList addObject:@{@"tag": @(NEDemoRequest), @"title":@"创建请求"}];
    [self.dataList addObject:@{@"tag": @(NEDemoConnection), @"title":@"NSURLConnection"}];
    [self.dataList addObject:@{@"tag": @(NEDemoSession), @"title":@"NSURLSession"}];
    [self.dataList addObject:@{@"tag": @(NEDemoSessionDelegate), @"title":@"NSURLSession delegate"}];
    [self.dataList addObject:@{@"tag": @(NEDemoPostConnection), @"title":@"POST请求"}];
    [self.dataList addObject:@{@"tag": @(NEDemoPostSession), @"title":@"POST请求 NSURLSession"}];
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
        case NEDemoRequest:
            [self testRequest];
            return;
            
        case NEDemoConnection:
            [self testNSURLConnection];
            break;
            
        case NEDemoSession:
            [self testNSURLSession];
            break;
            
        case NEDemoSessionDelegate:
            [self testNSURLSessionWithDelegate];
            break;
            
        case NEDemoPostConnection:
            [self testPostRequestWithNSURLConnection];
            break;
            
        case NEDemoPostSession:
            [self testPostRequestWithNSURLSession];
            break;
            
        default:
            break;
    }
}

#pragma mark - Demo

- (void)testRequest {
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/17604305?fields=title,id,url,publisher,author"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"NETestDemo" forHTTPHeaderField:@"User-Agent"];
}

- (void)testNSURLConnection {
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/17604305?fields=title,id,url,publisher,author"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [connection start];
}

- (void)testNSURLSession {
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/17604305?fields=title,id,url,publisher,author"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", response);
        self.response = response;
        self.responseData = [NSMutableData dataWithData:data];
        self.responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
        self.responseInfo = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
        NSLog(@"返回数据: %@", self.responseString);
    }];
    [task resume];
}

- (void)testNSURLSessionWithDelegate {
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/17604305?fields=title,id,url,publisher,author"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request];
    [task resume];
}

- (void)testPostRequestWithNSURLConnection {
    NSURL *url = [NSURL URLWithString:kPutsreqTestURL];
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    mutableRequest.HTTPMethod = @"POST";
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parameters = @{@"book": @(17604305), @"title":@"好书", @"comment":@"我觉得这是一本好书", @"rating":@(5)};
    NSData *body = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    [mutableRequest setHTTPBody:body];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:mutableRequest delegate:self startImmediately:NO];
    [connection start];
}

- (void)testPostRequestWithNSURLSession {
    NSURL *url = [NSURL URLWithString:kPutsreqTestURL];
    
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    mutableRequest.HTTPMethod = @"POST";
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parameters = @{@"book": @(17604305), @"title":@"好书", @"comment":@"我觉得这是一本好书", @"rating":@(5)};
    NSData *body = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    [mutableRequest setHTTPBody:body];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionTask *task = [session dataTaskWithRequest:mutableRequest];
    [task resume];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%@", response);
    self.response = response;
    self.responseData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"%@", data);
    if (nil != data) {
        [self.responseData appendData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Request %@ failed with error: %@", connection.currentRequest, error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Request %@ finished successfully", connection.currentRequest);
    NSStringEncoding stringEncoding = NSUTF8StringEncoding;
    self.responseString = [[NSString alloc] initWithData:self.responseData encoding:stringEncoding];
    self.responseInfo = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    NSLog(@"返回数据: %@", self.responseString);
}

#pragma mark - NSURLSessionDataDelegate

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
    NSLog(@"返回数据: %@", self.responseString);
    
    self.responseInfo = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
}

@end
