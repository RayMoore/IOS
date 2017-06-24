//
//  FillModeViewController.m
//  CoreAnimationDemo
//
//  Created by Chengyin on 16/7/11.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "FillModeViewController.h"

@interface FillModeViewController ()
{
    CALayer *_myLayer;
}
@end

@implementation FillModeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Fill mode";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myLayer = [CALayer layer];
    _myLayer.frame = CGRectMake(50, 100, 50, 50);
    _myLayer.borderColor = [UIColor blackColor].CGColor;
    _myLayer.borderWidth = 1;
    [self.view.layer addSublayer:_myLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"clicked.");
    [self changeColor];
}

- (void)changeColor
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = (id)[UIColor yellowColor].CGColor;
    animation.toValue = (id)[UIColor orangeColor].CGColor;
    animation.duration = 2;
    animation.beginTime = [_myLayer convertTime:CACurrentMediaTime() fromLayer:nil] + 1;
    animation.fillMode = kCAFillModeBoth;
    animation.removedOnCompletion = NO;
    [_myLayer addAnimation:animation forKey:@"changeColor"];
}
@end
