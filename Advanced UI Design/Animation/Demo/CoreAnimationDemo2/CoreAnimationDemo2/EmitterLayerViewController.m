//
//  EmitterLayerViewController.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "EmitterLayerViewController.h"

@implementation EmitterLayerViewController
{
    CAEmitterLayer *_emitterLayer;
}

- (UIImage *)emitterCellImage
{
    CGFloat size = 20;
    UIView *view = [[UIView alloc] init];
    view.bounds = CGRectMake(0, 0, size, size);
    view.backgroundColor = [UIColor orangeColor];
    view.layer.cornerRadius = size / 2;
    view.opaque = NO;
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Emitter animation";
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.contents = (id)[self emitterCellImage].CGImage;
    emitterCell.alphaRange = 0.2f;//平均alpha值
    emitterCell.alphaSpeed = -1.0f;//alpha变化速度（每秒变化率）
    emitterCell.lifetime = 0.8f;//每个粒子持续时间
    emitterCell.lifetimeRange = 0.3f;//持续时间变动范围
    emitterCell.birthRate = 500.0f;//每秒生成多少个粒子
    emitterCell.velocity = 35.0;//粒子运动速度
    emitterCell.velocityRange = 5.0;//粒子运动够速度变化范围
    emitterCell.scale = 0.07;//粒子的缩放
    emitterCell.scaleRange  = 0.02;//缩放变化范围
    
    _emitterLayer = [CAEmitterLayer layer];
    _emitterLayer.frame = self.view.bounds;
    _emitterLayer.emitterCells = @[emitterCell];
    _emitterLayer.birthRate = 0;//现在为0，点击后通过动画变为1，和粒子的birthRate相乘为最后的birthRate
    [self.view.layer addSublayer: _emitterLayer];
    
    _emitterLayer.emitterShape = kCAEmitterLayerCircle;//发射源形状
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;//粒子从发射源的轮廓发出
    _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;//粒子越早发出越早渲染
//    _emitterLayer.emitterSize = CGSizeMake(10, 0);//发射源大小
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _emitterLayer.emitterPosition = [touch locationInView:self.view];
    
    CABasicAnimation *birthRateAnimation = [CABasicAnimation animationWithKeyPath:@"birthRate"];
    birthRateAnimation.fromValue = @0;
    birthRateAnimation.toValue = @1;
    birthRateAnimation.fillMode = kCAFillModeForwards;
    birthRateAnimation.removedOnCompletion = NO;
    [_emitterLayer addAnimation:birthRateAnimation forKey:birthRateAnimation.keyPath];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _emitterLayer.emitterPosition = [touch locationInView:self.view];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_emitterLayer removeAllAnimations];
}
@end
