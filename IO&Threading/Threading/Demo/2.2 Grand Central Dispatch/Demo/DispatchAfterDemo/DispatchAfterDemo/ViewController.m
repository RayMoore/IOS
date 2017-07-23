//
//  ViewController.m
//  DispatchAfterDemo
//
//  Created by amao on 16/8/15.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
- (IBAction)buttonPressed:(id)sender {
    
    NSLog(@"call dispatch after begin");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"run delay task");
    });
    NSLog(@"call dispatch after end");
}

@end
