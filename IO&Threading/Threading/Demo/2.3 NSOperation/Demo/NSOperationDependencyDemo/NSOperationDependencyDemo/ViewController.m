//
//  ViewController.m
//  NSOperationDependencyDemo
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
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:10];
    
    NSOperationQueue *addQueue = [[NSOperationQueue alloc] init];
    [addQueue setMaxConcurrentOperationCount:10];

    
    NSBlockOperation *finalOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"final task");
    }];
    
    
    for (NSInteger i = 0; i < 5; i++)
    {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            sleep(5);
            NSLog(@"task %zd is running",i);

        }];
        [finalOperation addDependency:op];
        [queue addOperation:op];
    }
    
    [addQueue addOperation:finalOperation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
