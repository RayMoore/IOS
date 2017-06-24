//
//  ImplicitAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by Chengyin on 16/7/10.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ImplicitAnimationViewController.h"

@interface ImplicitAnimationViewController ()
{
    UIView *_myView;
    CALayer *_myLayer;
}
@end

@implementation ImplicitAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Implicit animation";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    _myView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_myView];
    
    _myLayer = [CALayer layer];
    _myLayer.frame = CGRectMake(50, 200, 50, 50);
    _myLayer.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:_myLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint(_myView.frame, [touch locationInView:self.view]))
    {
        [self testImplicitAnimationUIView];
    }
    if (CGRectContainsPoint(_myLayer.frame, [touch locationInView:self.view]))
    {
        [self testImplicitAnimationCALayer];
    }
}

- (void)testImplicitAnimationUIView
{
    _myView.alpha = _myView.alpha < 1 ? 1 : 0.2;
    NSLog(@"%lf",_myView.layer.opacity);
}

- (void)testImplicitAnimationCALayer
{
    _myLayer.opacity = _myLayer.opacity < 1 ? 1 : 0.2;
}
@end
