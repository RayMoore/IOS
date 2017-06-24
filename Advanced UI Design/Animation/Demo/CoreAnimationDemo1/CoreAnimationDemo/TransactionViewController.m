//
//  TransactionViewController.m
//  CoreAnimationDemo
//
//  Created by Chengyin on 16/7/10.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TransactionViewController.h"

@interface TransactionViewController ()
{
    CALayer *_myLayer;
}
@end

@implementation TransactionViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Trasaction";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myLayer = [CALayer layer];
    _myLayer.frame = CGRectMake(50, 100, 50, 50);
    _myLayer.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:_myLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testTransaction];
//    [self disableAnimation];
}

- (void)testTransaction
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        NSLog(@"Set position animation completed.");
    }];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:1];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    _myLayer.position = CGPointMake(_myLayer.position.x + 100, _myLayer.position.y);
    [CATransaction commit];
}

- (void)disableAnimation
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _myLayer.position = CGPointMake(_myLayer.position.x + 100, _myLayer.position.y);
    [CATransaction commit];
}
@end
