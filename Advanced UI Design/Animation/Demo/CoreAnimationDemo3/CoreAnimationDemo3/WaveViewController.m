//
//  WaveViewController.m
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/7/24.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "WaveViewController.h"
#import "RecordWaveView.h"
#import "CPRecordWaveView.h"

@interface WaveViewController ()
{
    CPRecordWaveView *_cpWavView;
    RecordWaveView *_wavView;
    BOOL _animating;
    NSTimer *_recordPowerMockTimer;
}
@end

@implementation WaveViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Wave animation";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _wavView = [[RecordWaveView alloc] init];
    _wavView.color = [UIColor redColor];
    _wavView.bounds = CGRectMake(0, 0, 200, 200);
    _wavView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 100);
    [self.view addSubview:_wavView];
    
    _cpWavView = [[CPRecordWaveView alloc] init];
    _cpWavView.color = [UIColor greenColor];
    _cpWavView.bounds = CGRectMake(0, 0, 200, 200);
    _cpWavView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) + 100);
    [self.view addSubview:_cpWavView];
    
    NSLog(@"position action 1: %@",[_wavView actionForLayer:_wavView.layer forKey:@"position"]);
    
    [UIView animateWithDuration:0 animations:^{
        NSLog(@"position action 2: %@",[_wavView actionForLayer:_wavView.layer forKey:@"position"]);
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_animating)
    {
        _animating = NO;
        [_wavView stop];
        [_cpWavView stop];
        [self stopMock];
    }
    else
    {
        _animating = YES;
        [_wavView start];
        [_cpWavView start];
        [self startMock];
    }
}

- (void)mockPowerInvoke:(NSTimer *)timer
{
    _wavView.power = (arc4random_uniform(20) + 1) * 0.01;
    _cpWavView.power = _wavView.power;
}

- (void)startMock
{
    //由于循环引用所以在退出页面时必须调用-invalidate停止mocktimer
    //因为这个demo是一个单页面的demo所以不存在这个问题，如果是其他页面推出这个页面的话
    //就需要注意在页面推出时停掉timer，例如在viewDidDisappear中
    //除了在viewDidDisappear中停掉timer这个做法之外，还会有更好的做法，可以翻阅相关资料
    _recordPowerMockTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(mockPowerInvoke:) userInfo:nil repeats:YES];
}

- (void)stopMock
{
    [_recordPowerMockTimer invalidate];
}
@end
