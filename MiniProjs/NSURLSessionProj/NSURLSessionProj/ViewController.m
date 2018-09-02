//
//  ViewController.m
//  NSURLSessionProj
//
//  Created by Ray on 23/07/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSString *responseString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)postSession:(id)sender{
//    NSLog(@"post");
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/post"];
    NSMutableURLRequest *muRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    muRequest.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionTask *task = [session dataTaskWithRequest:muRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error.code != 0){
            [self showMessageWithTitle:@"请求出错" andMessage:@"post error"];
            return;
        }
        self.response = response;
        self.responseData = [NSMutableData dataWithData:data];
        self.responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"返回数据: %@", self.responseString);
    }];
    [task resume];
}

-(IBAction)imageSession:(id)sender{
//    NSLog(@"jpeg");
//    NSString *url = @"http://httpbin.org/image/jpeg";
//    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
//    NSURL *URL = [NSURL URLWithString:url];
    
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/image/jpeg"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session= [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask *downloadTask=[session downloadTaskWithRequest:req completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSLog(@"tmp路径%@",location);//tmp路径
        if (!error) {
            NSError *saveError;
            NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *savePath=[cachePath stringByAppendingPathComponent:@"download.jpeg"];
            NSLog(@"图片下载成功，保存路径为%@",savePath);
            NSURL *saveUrl=[NSURL fileURLWithPath:savePath];
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
            if (saveError) {
                [self showMessageWithTitle:@"保存出错" andMessage:@"saving image error"];
            }
            
        }else{
            [self showMessageWithTitle:@"下载出错" andMessage:@"downloading image error"];
        }
    }];
    [downloadTask resume];
}


- (void)showMessageWithTitle:(NSString*)title andMessage:(NSString*)msg{
    
    UIAlertController *messageAlertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    
    [messageAlertController addAction:cancelAction];
    [messageAlertController addAction:okAction];
    [self presentViewController:messageAlertController animated:YES completion:nil];
}


@end
