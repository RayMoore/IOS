//
//  GroupViewController.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "GroupViewController.h"

@implementation GroupViewController
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

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testGroup];
//    [self testGroupBeginTime];
//    [self testGroupSpeed];
}

- (void)testGroup
{
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    positionAnimation.fromValue = @(125);
    positionAnimation.toValue = @(225);
    positionAnimation.duration = 2;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.2);
    opacityAnimation.duration = 1;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = @[positionAnimation,opacityAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [_square.layer addAnimation:group forKey:@"group"];
}

- (void)testGroupBeginTime
{
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    positionAnimation.fromValue = @(125);
    positionAnimation.toValue = @(225);
    positionAnimation.duration = 2;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.2);
    opacityAnimation.duration = 1;
    opacityAnimation.beginTime = 1;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = @[positionAnimation,opacityAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.beginTime = [_square.layer convertTime:CACurrentMediaTime() fromLayer:nil] + 1;
    [_square.layer addAnimation:group forKey:@"group"];
}

- (void)testGroupSpeed
{
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    positionAnimation.fromValue = @(125);
    positionAnimation.toValue = @(225);
    positionAnimation.duration = 4;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.2);
    opacityAnimation.duration = 4;
    opacityAnimation.speed = 2;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 4;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = @[positionAnimation,opacityAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.speed = 2;
    [_square.layer addAnimation:group forKey:@"group"];
}
@end
