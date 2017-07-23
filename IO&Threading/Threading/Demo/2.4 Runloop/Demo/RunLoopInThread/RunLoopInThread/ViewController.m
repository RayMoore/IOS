//
//  ViewController.m
//  RunLoopInThread
//
//  Created by amao on 16/9/20.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)    NSThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _thread = [[NSThread alloc] initWithTarget:self
                                      selector:@selector(threadFunction:) object:nil];
    [_thread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)onFire:(id)sender {
    [self performSelector:@selector(fireSelector:)
                 onThread:_thread
               withObject:nil
            waitUntilDone:NO];
}

- (void)threadFunction:(id)arg
{
    NSLog(@"thread begin");
    
    NSPort *port = [NSMachPort port];
    [[NSRunLoop currentRunLoop] addPort:port
                                forMode:NSDefaultRunLoopMode];
    
    while (![[NSThread currentThread] isCancelled])
    {
        NSLog(@"runloop begin");
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"runloop end");
    }
    
    NSLog(@"thread end");
}

- (void)fireSelector:(id)arg
{
    NSLog(@"fire in the hole");
}
@end
