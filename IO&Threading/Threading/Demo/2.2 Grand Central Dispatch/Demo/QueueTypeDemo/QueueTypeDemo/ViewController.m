//
//  ViewController.m
//  QueueTypeDemo
//
//  Created by amao on 16/8/15.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)    dispatch_queue_t serialQueue;
@property (nonatomic,strong)    dispatch_queue_t concurrentQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _serialQueue = dispatch_queue_create("com.netease.study.serial", DISPATCH_QUEUE_SERIAL);
    
    _concurrentQueue = dispatch_queue_create("com.netease.study.concurrent", DISPATCH_QUEUE_CONCURRENT);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)serialQueueButtonPressed:(id)sender {
    
    dispatch_async(_serialQueue, ^{
        NSLog(@"task1 begin");
        sleep(3);
        NSLog(@"task1 end");
    });
    
    dispatch_async(_serialQueue, ^{
        NSLog(@"task2 begin");
        sleep(2);
        NSLog(@"task2 end");
    });
    
    dispatch_async(_serialQueue, ^{
        NSLog(@"task3 begin");
        sleep(1);
        NSLog(@"task3 end");
    });
}


- (IBAction)concurrentQueueButtonPressed:(id)sender {
    
    dispatch_async(_concurrentQueue, ^{
        NSLog(@"task1 begin");
        sleep(3);
        NSLog(@"task1 end");
    });
    
    dispatch_async(_concurrentQueue, ^{
        NSLog(@"task2 begin");
        sleep(2);
        NSLog(@"task2 end");
    });
    
    dispatch_async(_concurrentQueue, ^{
        NSLog(@"task3 begin");
        sleep(1);
        NSLog(@"task3 end");
    });
}
@end
