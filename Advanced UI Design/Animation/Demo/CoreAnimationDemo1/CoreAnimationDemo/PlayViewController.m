//
//  PlayViewController.m
//  CoreAnimationDemo
//
//  Created by Chengyin on 16/7/3.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "PlayViewController.h"
#import "CALayer+AnimationControl.h"

static const CGFloat coverSize = 150.0f;

static const CGFloat diskSize = 238.0f;
static const NSTimeInterval diskAnimationDuration = 20;

static const CGFloat needleWidth = 162.0f;
static const CGFloat needleHeight = 306.0f;
static const NSTimeInterval needleAnimationDuration = 0.3;
static const CGFloat needleRotationDegree = -M_PI_4 / 1.5;

@interface PlayViewController ()
{
@private
    UIImageView *_needleView;
    UIImageView *_diskImageView;
    UIImageView *_coverimageView;
    
    BOOL _playing;
    BOOL _animating;
    BOOL _started;
}
@end

@implementation PlayViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Play animation";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _coverimageView = [[UIImageView alloc] init];
    _coverimageView.image = [UIImage imageNamed:@"Cover.jpg"];
    [self.view addSubview:_coverimageView];
    
    _diskImageView = [[UIImageView alloc] init];
    _diskImageView.image = [UIImage imageNamed:@"Disk.png"];
    [self.view addSubview:_diskImageView];
    
    _needleView = [[UIImageView alloc] init];
    _needleView.image = [UIImage imageNamed:@"Needle.png"];
    [self.view addSubview:_needleView];
    
    _needleView.transform = CGAffineTransformMakeRotation(needleRotationDegree);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _needleView.bounds = CGRectMake(0, 0, needleWidth, needleHeight);
    _needleView.center = CGPointMake(CGRectGetMidX(self.view.bounds), 64);
    
    _diskImageView.bounds = CGRectMake(0, 0, diskSize, diskSize);
    _diskImageView.center = CGPointMake(CGRectGetMidX(self.view.bounds), 64 + 80 + diskSize / 2);
    
    _coverimageView.bounds = CGRectMake(0, 0, coverSize, coverSize);
    _coverimageView.center = _diskImageView.center;
}

#pragma mark - needle
- (void)toggleNeedle:(void (^)(BOOL finished))completion
{
    _animating = YES;
    _playing = !_playing;
    [UIView animateWithDuration:needleAnimationDuration animations:^{
        _needleView.transform = _playing ? CGAffineTransformIdentity : CGAffineTransformMakeRotation(needleRotationDegree);
    } completion:^(BOOL finished) {
        _animating = NO;
        if (completion)
        {
            completion(finished);
        }
    }];
}

#pragma mark - play & stop
- (void)play
{
    if (_playing || _animating)
    {
        return;
    }
    
    [self toggleNeedle:^(BOOL finished) {
        [self startRotation];
    }];
}

- (void)stop
{
    if (!_playing || _animating)
    {
        return;
    }
    
    [self toggleNeedle:nil];
    [self stopRotation];
}

- (void)startRotation
{
//    [UIView animateKeyframesWithDuration:diskAnimationDuration delay:0 options:UIViewKeyframeAnimationOptionRepeat|UIViewAnimationOptionCurveLinear animations:^{
//        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
//            _diskImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
//            _coverimageView.transform = _diskImageView.transform;
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
//            _diskImageView.transform = CGAffineTransformMakeRotation(M_PI);
//            _coverimageView.transform = _diskImageView.transform;
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
//            _diskImageView.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
//            _coverimageView.transform = _diskImageView.transform;
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
//            _diskImageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
//            _coverimageView.transform = _diskImageView.transform;
//        }];
//    } completion:nil];
    
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = @(0);
    rotate.toValue = @(M_PI_2);
    rotate.duration = diskAnimationDuration / 4;
    rotate.cumulative = YES;
    rotate.repeatCount = 4;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_diskImageView.layer addAnimation:rotate forKey:@"transform"];
    [_coverimageView.layer addAnimation:rotate forKey:@"transform"];
}

- (void)stopRotation
{
//    [UIView animateWithDuration:0 animations:^{
//        _diskImageView.transform = CGAffineTransformIdentity;
//        _coverimageView.transform = _diskImageView.transform;
//    }];
    
    [_diskImageView.layer removeAllAnimations];
    [_coverimageView.layer removeAllAnimations];
}

#pragma mark - pause & resume
- (void)pause
{
    if (!_playing || _animating)
    {
        return;
    }
    
    [self toggleNeedle:nil];
    [self pauseRotation];
}

- (void)resume
{
    if (_playing || _animating)
    {
        return;
    }
    
    [self toggleNeedle:^(BOOL finished) {
        [self resumeRotation];
    }];
}

- (void)pauseRotation
{
    [_diskImageView.layer ac_pause];
    [_coverimageView.layer ac_pause];
}

- (void)resumeRotation
{
    [_diskImageView.layer ac_resume];
    [_coverimageView.layer ac_resume];
}

#pragma mark - touch
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_started)
    {
        [self play];
        _started = YES;
    }
    else
    {
        if (_playing)
        {
            [self pause];
        }
        else
        {
            [self resume];
        }
    }
}
@end
