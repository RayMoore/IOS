//
//  ViewController.m
//  NSOperationWaitDemo
//
//  Created by amao on 16/8/31.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSOperationQueue *uploadQueue = [[NSOperationQueue alloc] init];
    [uploadQueue setMaxConcurrentOperationCount:5];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    for (NSInteger i = 0; i < 5; i++)
    {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"task %zd begin",i);
            sleep(5);
            NSLog(@"task %zd end",i);
        }];
        [uploadQueue addOperation:op];
    }
    
    
    NSBlockOperation *finalOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"final task begin");
        [uploadQueue waitUntilAllOperationsAreFinished];
        NSLog(@"final task end");
    }];
    
    [queue addOperation:finalOperation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
