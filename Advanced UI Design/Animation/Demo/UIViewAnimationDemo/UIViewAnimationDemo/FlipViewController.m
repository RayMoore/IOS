//
//  FlipViewController.m
//  UIViewAnimationDemo
//
//  Created by Chengyin on 16/7/1.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "FlipViewController.h"

@implementation FlipViewController
{
    UIView *_rootView;
    UIView *_square1;
    UIView *_square2;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Flip animation";
    
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
    [self startFliping];
//    [self startBlockFliping1];
//    [self startBlockFliping2];
}

- (void)startFliping
{
    [UIView beginAnimations:@"squareAnimation" context:(__bridge void *)(self)];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_rootView cache:YES];
    _square1.hidden = !_square1.hidden;
    _square2.hidden = !_square2.hidden;
    [UIView commitAnimations];
}

- (void)startBlockFliping1
{
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromLeft
                                /* | UIViewAnimationOptionAllowAnimatedContent */;
    [UIView transitionWithView:_rootView duration:1 options:options animations:^{
        _square1.hidden = !_square1.hidden;
        _square2.hidden = !_square2.hidden;
    } completion:nil];
}

- (void)startBlockFliping2
{
    UIView *fromView = _square1.hidden ? _square2 : _square1;
    UIView *toView = _square1.hidden ? _square1 : _square2;
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromLeft
                                   | UIViewAnimationOptionShowHideTransitionViews
                                /* | UIViewAnimationOptionAllowAnimatedContent */;
    [UIView transitionFromView:fromView toView:toView duration:1 options:options completion:nil];
}
@end