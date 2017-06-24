//
//  BasicAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by Chengyin on 16/7/10.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "BasicAnimationViewController.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
@interface BasicAnimationViewController ()<CAAnimationDelegate>
#else
@interface BasicAnimationViewController ()
#endif
{
    CALayer *_myLayer;
    CALayer *_myAnotherLayer;
}
@end

@implementation BasicAnimationViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Basic animation";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myLayer = [CALayer layer];
    _myLayer.frame = CGRectMake(50, 100, 50, 50);
    _myLayer.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:_myLayer];
    
    _myAnotherLayer = [CALayer layer];
    _myAnotherLayer.frame = CGRectMake(50, 200, 50, 50);
    _myAnotherLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:_myAnotherLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testAddAnimation];
//    [self testAddAnimationCopy];
//    [self testAnimationDurationRepeat];
//    [self testAnimationStay];
//    [self testAnimationTimingFunction];
//    [self testAnimationDelegate];
//    [self testAnimationStay2];
}

- (void)testAddAnimation
{
    //添加一个最基本的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.fromValue = @(_myLayer.position.x);
    animation.toValue = @(_myLayer.position.x + 100);
    [_myLayer addAnimation:animation forKey:@"position"];
}

- (void)testAddAnimationCopy
{
    //animation在add后被copy到了layer上
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.fromValue = @(_myLayer.position.x);
    animation.toValue = @(_myLayer.position.x + 100);
    [_myLayer addAnimation:animation forKey:@"position"];
    
    animation.fromValue = @(_myAnotherLayer.position.x);
    animation.toValue = @(_myAnotherLayer.position.x + 50);
    [_myAnotherLayer addAnimation:animation forKey:@"position"];
}

- (void)testAnimationDurationRepeat
{
    //animation的duration和repeat
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.fromValue = @(_myLayer.position.x);
    animation.toValue = @(_myLayer.position.x + 100);
    animation.duration = 2;
    animation.repeatCount = 2;
//    animation.autoreverses = YES;
//    animation.repeatDuration = 6;
    [_myLayer addAnimation:animation forKey:@"position"];
}

- (void)testAnimationStay
{
    //animation停留在最终状态
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.fromValue = @(_myLayer.position.x);
    animation.toValue = @(_myLayer.position.x + 100);
    animation.duration = 2;
    _myLayer.position = CGPointMake(_myLayer.position.x + 100, _myLayer.position.y);
    [_myLayer addAnimation:animation forKey:@"position"];
}

- (void)testAnimationTimingFunction
{
    //timing function
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.byValue = @(100);
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.458 : 0.132 : 0.319 : 0.722];
    [_myLayer addAnimation:animation forKey:@"position"];
}

- (void)testAnimationDelegate
{
    //layer的delegate属性和remove
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.byValue = @(100);
    animation.delegate = self;
//    animation.removedOnCompletion = NO;
    [_myLayer addAnimation:animation forKey:@"position"];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"layer animation started.");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"layer animation stopped.");
    CAAnimation *animation = [_myLayer animationForKey:@"position"];
    if (animation)
    {
        NSLog(@"animation not removed after stopped.");
    }
    else
    {
        NSLog(@"animation removed after stopped.");
    }
}

- (void)testAnimationStay2
{
    //animation停留在最终状态的第二种实现方法
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.byValue = @(100);
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [_myLayer addAnimation:animation forKey:@"position"];
}
@end
