//
//  ViewController.m
//  ThreadCancelDemo
//
//  Created by amao on 16/8/9.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)    NSThread    *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _thread = [[NSThread alloc] initWithTarget:self
                                      selector:@selector(threadFunction:)
                                        object:nil];
    [_thread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender {
    [_thread cancel];
    _thread = nil;
}


- (void)threadFunction:(id)arg
{
    NSLog(@"thread begin");
    for (NSInteger i = 0; i < 100; i++)
    {
        NSLog(@"tick count %zd",i);
        sleep(1);
    }
    NSLog(@"thread end");
}
@end
