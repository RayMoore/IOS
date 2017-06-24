//
//  KeyFrameViewController.m
//  UIViewAnimationDemo
//
//  Created by Chengyin on 16/6/28.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "KeyFrameViewController.h"

@implementation KeyFrameViewController
{
    UIView *_square;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Key frame animation";
    
    _square = [[UIView alloc] init];
    _square.backgroundColor = [UIColor orangeColor];
    _square.frame = CGRectMake(100, 100, 50, 50);
    [self.view addSubview:_square];
}

- (void)animateView:(UIView *)square
{
    [UIView animateWithDuration:0.5 animations:^{
        square.center = CGPointMake(square.center.x + 100, square.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            square.center = CGPointMake(square.center.x, square.center.y + 100);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                square.center = CGPointMake(square.center.x - 100, square.center.y);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    square.center = CGPointMake(square.center.x, square.center.y - 100);
                }];
            }];
        }];
    }];

}

- (void)keyAnimateView:(UIView *)square
{
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
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

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self animateView:_square];
    [self keyAnimateView:_square];
}
@end
