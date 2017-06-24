//
//  ViewAnimationViewController.m
//  UIViewAnimationDemo
//
//  Created by Chengyin on 16/7/1.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewAnimationViewController.h"

@implementation ViewAnimationViewController
{
    UIView *_square;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"View animation";
    
    _square = [[UIView alloc] init];
    _square.backgroundColor = [UIColor orangeColor];
    _square.bounds = CGRectMake(0, 0, 50, 50);
    _square.center = CGPointMake(CGRectGetMidX(self.view.bounds) - 100, CGRectGetMidY(self.view.bounds));
    [self.view addSubview:_square];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     _square.center = CGPointMake(CGRectGetMidX(self.view.bounds) - 100, CGRectGetMidY(self.view.bounds));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self startAnimating];
//    [self startBlockAnimating];
}

- (void)startAnimating
{
    [UIView beginAnimations:@"squareAnimation" context:(__bridge void *)(self)];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationRepeatCount:2];
    [UIView setAnimationRepeatAutoreverses:YES];
    _square.center = CGPointMake(_square.center.x + 100, _square.center.y);
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animID finished:(NSNumber *)finished context:(void *)ctx
{
    _square.center = CGPointMake(_square.center.x - 100, _square.center.y);
}

- (void)startBlockAnimating
{
    UIViewAnimationOptions options = UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat;
    
    [UIView animateWithDuration:0.4 delay:0 options:options animations:^{
        [UIView setAnimationRepeatCount:2];
        _square.center = CGPointMake(_square.center.x + 100, _square.center.y);
    } completion:^(BOOL finished) {
        _square.center = CGPointMake(_square.center.x - 100, _square.center.y);
    }];
}
@end
