//
//  ViewController.m
//  NSOperationCancelDemo
//
//  Created by amao on 16/8/31.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"


@interface Task : NSOperation
@property (nonatomic,assign)    NSInteger   taskId;
@end

@implementation Task

- (void)main
{
    NSLog(@"task %zd begin",self.taskId);
    
    NSInteger index = 0;
    while (!self.isCancelled) {
        sleep(1);
        index++;
        if (index >= 5)
        {
            break;
        }
         NSLog(@"task %zd is running index is %zd",self.taskId,index);
    }
    
    if (self.isCancelled) {
        NSLog(@"task is cancelled");
    }
    
    NSLog(@"task %zd end",self.taskId);
}

@end


@interface ViewController ()
@property (nonatomic,strong)    NSOperationQueue *queue;
@property (nonatomic,strong)    NSOperation *currentTask;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _queue = [[NSOperationQueue alloc] init];
    [_queue setMaxConcurrentOperationCount:1];
    
    for (NSInteger i = 0; i < 10; i++)
    {
        Task *task = [[Task alloc] init];
        task.taskId = i;
        task.completionBlock = ^(){
            NSLog(@"task %zd completion block is executed isfinished",i);
        };
        
        [_queue addOperation:task];
        
        if (i == 2)
        {
            _currentTask = task;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)cancelOneTask:(id)sender {
    [_currentTask cancel];
}
- (IBAction)cancelAllTask:(id)sender {
    [_queue cancelAllOperations];
}

@end
