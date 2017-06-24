//
//  KeyFrameViewController.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "KeyFrameViewController.h"

@implementation KeyFrameViewController
{
    UIView *_square1;
    UIView *_square2;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Key frame animation";
    
    _square1 = [[UIView alloc] init];
    _square1.backgroundColor = [UIColor orangeColor];
    _square1.frame = CGRectMake(100, 100, 50, 50);
    [self.view addSubview:_square1];
    
    _square2 = [[UIView alloc] init];
    _square2.backgroundColor = [UIColor purpleColor];
    _square2.frame = CGRectMake(100, 200, 50, 50);
    [self.view addSubview:_square2];
}

- (void)keyAnimateUIView:(UIView *)square
{
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        double frameDuration = 1.0 / 4;
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:frameDuration animations:^{
            square.center = CGPointMake(square.center.x + 100, square.center.y);
        }];
        [UIView addKeyframeWithRelativeStartTime:frameDuration relativeDuration:frameDuration animations:^{
            square.center = CGPointMake(square.center.x, square.center.y + 100);
        }];
        [UIView addKeyframeWithRelativeStartTime:frameDuration * 2 relativeDuration:frameDuration animations:^{
            square.center = CGPointMake(square.center.x - 100, square.center.y);
        }];
        [UIView addKeyframeWithRelativeStartTime:frameDuration * 3 relativeDuration:frameDuration animations:^{
            square.center = CGPointMake(square.center.x, square.center.y - 100);
        }];
    } completion:nil];
}

- (void)keyAnimateCALayer:(UIView *)square
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 2;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(square.layer.position.x, square.layer.position.y)],
                         [NSValue valueWithCGPoint:CGPointMake(square.layer.position.x + 100, square.layer.position.y)],
                         [NSValue valueWithCGPoint:CGPointMake(square.layer.position.x + 100, square.layer.position.y + 100)],
                         [NSValue valueWithCGPoint:CGPointMake(square.layer.position.x, square.layer.position.y + 100)],
                         [NSValue valueWithCGPoint:CGPointMake(square.layer.position.x, square.layer.position.y)],
                         ];
    
//    animation.values = @[
//                         [NSValue valueWithCGPoint:CGPointMake(0,0)],
//                         [NSValue valueWithCGPoint:CGPointMake(100,0)],
//                         [NSValue valueWithCGPoint:CGPointMake(100,100)],
//                         [NSValue valueWithCGPoint:CGPointMake(0,100)],
//                         [NSValue valueWithCGPoint:CGPointMake(0,0)],
//                         ];
//    animation.additive = YES;
    
    animation.keyTimes = @[
                           @(0),
                           @(0.25),
                           @(0.5),
                           @(0.75),
                           @(1),
                           ];
    
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
//    animation.timingFunctions = @[
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//                                  ];
    
    animation.calculationMode = kCAAnimationCubic;
    
    [square.layer addAnimation:animation forKey:animation.keyPath];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self keyAnimateUIView:_square1];
    [self keyAnimateCALayer:_square2];
}
@end
