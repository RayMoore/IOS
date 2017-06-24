//
//  TransitionViewController.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "TransitionViewController.h"

@implementation TransitionViewController
{
    UIView *_rootView;
    UIView *_square1;
    UIView *_square2;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Transition animation";
    
    _rootView = [[UIView alloc] init];
    _rootView.bounds = CGRectMake(0, 0, 50, 50);
    _rootView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    _rootView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_rootView];
    
    _square1 = [[UIView alloc] init];
    _square1.backgroundColor = [UIColor orangeColor];
    _square1.frame = _rootView.bounds;
    [_rootView addSubview:_square1];
    
    _square2 = [[UIView alloc] init];
    _square2.backgroundColor = [UIColor yellowColor];
    _square2.frame = _square1.frame;
    _square2.hidden = YES;
    [_rootView addSubview:_square2];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self startTransition];
}

- (void)startTransition
{
//    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromLeft;
//    [UIView transitionWithView:_rootView duration:1 options:options animations:^{
//        _square1.hidden = !_square1.hidden;
//        _square2.hidden = !_square2.hidden;
//    } completion:nil];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromLeft;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.startProgress = 0.5;
//    transition.endProgress = 0.5;
    [_rootView.layer addAnimation:transition forKey:@"myTrans"];
    _square1.hidden = !_square1.hidden;
    _square2.hidden = !_square2.hidden;
    
//    CAAnimation *animation = [_rootView.layer animationForKey:@"myTrans"];
//    CAAnimation *animation1 = [_rootView.layer animationForKey:kCATransition];
//    NSLog(@"%@ %@",animation,animation1);
}
@end