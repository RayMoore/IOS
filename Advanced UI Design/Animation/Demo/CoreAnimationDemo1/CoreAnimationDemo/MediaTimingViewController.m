//
//  MediaTimingViewController.m
//  CoreAnimationDemo
//
//  Created by Chengyin on 16/7/11.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "MediaTimingViewController.h"

@interface MediaTimingViewController ()
{
    CALayer *_myLayer;
}
@end

@implementation MediaTimingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Media timing";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%lf",CACurrentMediaTime());
    _myLayer = [CALayer layer];
    NSLog(@"%lf",[_myLayer convertTime:CACurrentMediaTime() fromLayer:nil]);
    _myLayer.frame = CGRectMake(50, 100, 50, 50);
    _myLayer.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:_myLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testMediaTiming];
}

- (void)testMediaTiming
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.fromValue = @(_myLayer.position.x);
    animation.toValue = @(_myLayer.position.x + 100);
    animation.duration = 2;
    animation.speed = 2;
    animation.timeOffset = 1;
    animation.beginTime = [_myLayer convertTime:CACurrentMediaTime() fromLayer:nil] + 0.5;
    [_myLayer addAnimation:animation forKey:@"position"];
}
@end