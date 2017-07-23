//
//  ViewController.m
//  NSOperationPriorityDemo
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
    [queue setMaxConcurrentOperationCount:1];
    
    for (NSInteger i = 0; i < 3; i++)
    {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"task begin %zd",i);
            sleep(5);
            NSLog(@"task end %zd",i);
        }];
        
        if (i == 2)
        {
            op.queuePriority = NSOperationQueuePriorityHigh;
        }
        [queue addOperation:op];
        sleep(1);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
