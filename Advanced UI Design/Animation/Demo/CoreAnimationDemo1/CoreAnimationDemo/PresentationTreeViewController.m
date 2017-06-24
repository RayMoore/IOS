//
//  PresentationTreeViewController.m
//  CoreAnimationDemo
//
//  Created by Chengyin on 16/7/10.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "PresentationTreeViewController.h"

@interface PresentationTreeViewController ()
{
    UIView *_myView;
    NSTimer *_timer;
}
@end

@implementation PresentationTreeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Presentation Layer Tree";
    self.view.backgroundColor = [UIColor whiteColor];

    _myView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    _myView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_myView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testPresentationTree];
}

- (void)testPresentationTree
{
    [UIView animateWithDuration:1 animations:^{
        _myView.center = CGPointMake(_myView.center.x + 100, _myView.center.y);
    } completion:^(BOOL finished) {
        [self stopTimer];
    }];
    [self startTimer];
}

- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)stopTimer
{
    [_timer invalidate];
}

- (void)timer:(NSTimer *)timer
{
    CGFloat currentValue = ((CALayer *)[_myView.layer presentationLayer]).position.x;
    NSLog(@"presentation layer value = %lf, model layer value = %f",currentValue,((CALayer *)[_myView.layer modelLayer]).position.x);
}
@end
