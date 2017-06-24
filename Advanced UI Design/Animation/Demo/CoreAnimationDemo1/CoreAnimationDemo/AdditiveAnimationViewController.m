//
//  AdditiveAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by Chengyin on 16/7/10.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "AdditiveAnimationViewController.h"

@interface AdditiveAnimationViewController ()
{
    UIView *_myView;
}
@end

@implementation AdditiveAnimationViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Additive animation";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myView = [[UIView alloc] init];
    _myView.frame = CGRectMake(50, 100, 50, 50);
    _myView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_myView];
    
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
        _myView.center = CGPointMake(_myView.center.x + 150, _myView.center.y + 150);
    } completion:nil];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testAdditiveAnimation];
}

- (void)testAdditiveAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.additive = YES;
    animation.fromValue = @(0);
    animation.toValue = @(100);
    //不能只指定byValue一个值，因为只指定byValue相当于currentValue ~ currentValue + byValue
    //叠加上additive，会让currentValue叠加两次
//    animation.byValue = @(100);
    animation.autoreverses = YES;
    animation.duration = 0.25;
    [_myView.layer addAnimation:animation forKey:@"additivePosition"];
}
@end
