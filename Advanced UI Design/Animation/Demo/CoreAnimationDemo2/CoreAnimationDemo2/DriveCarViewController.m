//
//  DriveCarViewController.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "DriveCarViewController.h"

static const CGFloat moonSize = 240;
static const CGFloat carWidth = 60;
static const CGFloat carHeight = 30;

@implementation DriveCarViewController
{
    UIImageView *_moon;
    UIImageView *_car;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Drive car animation";
    
    _moon = [[UIImageView alloc] init];
    _moon.image = [UIImage imageNamed:@"moon.png"];
    _moon.frame = CGRectMake((self.view.bounds.size.width - moonSize) / 2, 200, moonSize, moonSize);
    [self.view addSubview:_moon];
    
    _car = [[UIImageView alloc] init];
    _car.image = [UIImage imageNamed:@"car.png"];
    _car.frame = CGRectMake((self.view.bounds.size.width - carWidth) / 2, CGRectGetMinY(_moon.frame) - carHeight + 13, carWidth, carHeight);
    [self.view addSubview:_car];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self drive];
}

- (void)drive
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addArcWithCenter:CGPointMake(0, moonSize/2) radius:moonSize/2 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    [path closePath];
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-moonSize/2, 0, moonSize, moonSize)];
//    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, moonSize/2);
//    transform = CGAffineTransformRotate(transform, -M_PI_2);
//    transform = CGAffineTransformTranslate(transform, 0, -moonSize/2);
//    [path applyTransform:transform];
    
    CAKeyframeAnimation *driveCar = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    driveCar.path = path.CGPath;
    driveCar.duration = 4;
    driveCar.additive = YES;
    driveCar.repeatCount = HUGE_VALF;
//    driveCar.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    driveCar.calculationMode = kCAAnimationPaced;
    driveCar.rotationMode = kCAAnimationRotateAuto;
    [_car.layer addAnimation:driveCar forKey:driveCar.keyPath];
}
@end
