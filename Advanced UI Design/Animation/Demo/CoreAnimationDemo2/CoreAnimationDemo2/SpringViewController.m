//
//  SpringViewController.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "SpringViewController.h"

@implementation SpringViewController
{
    CALayer *_layer1;
    CALayer *_layer2;
    CALayer *_layer3;
    NSArray *_layers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Spring animation";
    
    _layer1 = [CALayer layer];
    _layer1.backgroundColor = [UIColor orangeColor].CGColor;
    _layer1.frame = CGRectMake(100, 100, 10, 50);
    [self.view.layer addSublayer:_layer1];
    
    _layer2 = [CALayer layer];
    _layer2.backgroundColor = [UIColor yellowColor].CGColor;
    _layer2.frame = CGRectMake(100, 170, 10, 50);
    [self.view.layer addSublayer:_layer2];
    
    _layer3 = [CALayer layer];
    _layer3.backgroundColor = [UIColor purpleColor].CGColor;
    _layer3.frame = CGRectMake(100, 240, 10, 50);
    [self.view.layer addSublayer:_layer3];
    
    _layers = @[_layer1,_layer2,_layer3];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testSpringAnimation];
//    [self damping];
//    [self velocity];
//    [self mass];
//    [self stiffness];
}

- (void)testSpringAnimation
{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"bounds"];
    
    CGRect rect = _layer1.bounds;
    rect.size.width = 10;
    animation.fromValue = [NSValue valueWithCGRect:rect];
    rect.size.width = 100;
    animation.toValue = [NSValue valueWithCGRect:rect];
//    animation.duration = 1;
//    animation.duration = 5;
//    animation.delegate = self;
//    NSLog(@"%lf",animation.settlingDuration);
//    animation.duration = animation.settlingDuration;
    _layer1.bounds = rect;
    
    [_layer1 addAnimation:animation forKey:animation.keyPath];
    NSLog(@"started");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"finished");
}

- (void)damping
{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"bounds"];
    for (CALayer *layer in _layers)
    {
        NSUInteger index = [_layers indexOfObject:layer] + 1;
        animation.damping = 5 * index;
     
        CGRect rect = layer.bounds;
        rect.size.width = 10;
        animation.fromValue = [NSValue valueWithCGRect:rect];
        rect.size.width = 100;
        animation.toValue = [NSValue valueWithCGRect:rect];
        animation.duration = animation.settlingDuration;
        layer.bounds = rect;
        
        [layer addAnimation:animation forKey:animation.keyPath];
    }
}

- (void)velocity
{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"bounds"];
    for (CALayer *layer in _layers)
    {
        NSUInteger index = [_layers indexOfObject:layer] + 1;
        animation.initialVelocity = 5 * index;
     
        CGRect rect = layer.bounds;
        rect.size.width = 10;
        animation.fromValue = [NSValue valueWithCGRect:rect];
        rect.size.width = 100;
        animation.toValue = [NSValue valueWithCGRect:rect];
        animation.duration = 2;
        
        layer.bounds = rect;
        
        [layer addAnimation:animation forKey:animation.keyPath];
    }
}

- (void)stiffness
{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"bounds"];
    for (CALayer *layer in _layers)
    {
        NSUInteger index = [_layers indexOfObject:layer] + 1;
        animation.stiffness = 100 * index;
        
        CGRect rect = layer.bounds;
        rect.size.width = 10;
        animation.fromValue = [NSValue valueWithCGRect:rect];
        rect.size.width = 100;
        animation.toValue = [NSValue valueWithCGRect:rect];
        animation.duration = 2;//animation.settlingDuration;
        
        layer.bounds = rect;
        
        [layer addAnimation:animation forKey:animation.keyPath];
    }
}

- (void)mass
{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"bounds"];
    for (CALayer *layer in _layers)
    {
        NSUInteger index = [_layers indexOfObject:layer] + 1;
        animation.mass = 5 * index;
        
        CGRect rect = layer.bounds;
        rect.size.width = 10;
        animation.fromValue = [NSValue valueWithCGRect:rect];
        rect.size.width = 100;
        animation.toValue = [NSValue valueWithCGRect:rect];
        animation.duration = animation.settlingDuration;
        
        layer.bounds = rect;
        
        [layer addAnimation:animation forKey:animation.keyPath];
    }
}
@end
