//
//  SpringViewController.m
//  UIViewAnimationDemo
//
//  Created by Chengyin on 16/6/26.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "SpringViewController.h"

@implementation SpringViewController
{
    UIView *_v1;
    UIView *_v2;
    UIView *_v3;
    NSArray *_views;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Spring animation";
    
    _v1 = [[UIView alloc] init];
    _v1.backgroundColor = [UIColor orangeColor];
    _v1.frame = CGRectMake(100, 100, 10, 50);
    [self.view addSubview:_v1];
    
    _v2 = [[UIView alloc] init];
    _v2.backgroundColor = [UIColor yellowColor];
    _v2.frame = CGRectMake(100, 170, 10, 50);
    [self.view addSubview:_v2];
    
    _v3 = [[UIView alloc] init];
    _v3.backgroundColor = [UIColor purpleColor];
    _v3.frame = CGRectMake(100, 240, 10, 50);
    [self.view addSubview:_v3];
    
    _views = @[_v1,_v2,_v3];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self damping];
//    [self velocity];
}

- (void)damping
{
    for (UIView *v in _views)
    {
        NSUInteger index = [_views indexOfObject:v] + 1;
        [UIView animateWithDuration:2 delay:index usingSpringWithDamping:(0.3 * index) initialSpringVelocity:0 options:0 animations:^{
            CGRect rect = v.frame;
            rect.size.width = 100;
            v.frame = rect;
        } completion:nil];
    }
}

- (void)velocity
{
    for (UIView *v in _views)
    {
        NSUInteger index = [_views indexOfObject:v] + 1;
        [UIView animateWithDuration:2 delay:index usingSpringWithDamping:1 initialSpringVelocity:5 * index options:0 animations:^{
            CGRect rect = v.frame;
            rect.size.width = 100;
            v.frame = rect;
        } completion:nil];
    }
}
@end
