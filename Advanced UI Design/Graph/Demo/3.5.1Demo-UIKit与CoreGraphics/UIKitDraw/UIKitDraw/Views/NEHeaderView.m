//
//  NEHeaderView.h
//  UIKitDraw
//
//  Created by NetEase on 16/7/7.
//  Copyright (c) 2016年 NetEase. All rights reserved.
//

#import "NEHeaderView.h"

@implementation NEHeaderView

- (void)drawRect:(CGRect)rect {
    // 绘制椭圆作为头部
    [self drawEllipse];
    
    // 绘制圆形作为眼睛
    [self drawLeftEye];
    [self drawRightEye];
    
    // 绘制矩形作为嘴
    [self drawRectangle];
    
    // 绘制三角形作为鼻子
    [self drawTriangle];
}

// 绘制椭圆
- (void)drawEllipse {
    // 定义矩形的rect
    CGRect rectangle = CGRectMake(20, 30, 280, 260);
    
    // 创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rectangle];
    
    // 设置填充色
    [[UIColor orangeColor] setFill];
    
    // 填充
    [path fill];
}

#pragma mark -

// 绘制矩形
- (void)drawRectangle {
    // 定义矩形的rect
    CGRect rectangle = CGRectMake(100, 225, 120, 15);
    
    // 创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rectangle];
    
    // 设置填充色
    [[UIColor redColor] setFill];
    
    // 填充
    [path fill];
}

// 绘制三角形
- (void)drawTriangle {
    // 创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 起始点
    [path moveToPoint:CGPointMake(160, 140)];
    
    // 添加线条
    [path addLineToPoint:CGPointMake(190, 190)];
    [path addLineToPoint:CGPointMake(130, 190)];
    
    // 关闭路径
    [path closePath];
    
    // 设置填充色
    [[UIColor brownColor] setFill];
    
    // 填充
    [path fill];
}

- (void)drawLeftEye {
    // 创建UIBezierPath对象
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 80, 40, 40)];
    
    // 设置线条颜色
    [[UIColor blueColor] setStroke];
    
    // 设置线条宽度
    [path setLineWidth:3.0];
    
    // 绘制
    [path stroke];
    
    UIBezierPath *centerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(110, 90, 20, 20)];
    
    // 设置填充颜色
    [[UIColor blackColor] setFill];
    
    // 填充
    [centerPath fill];
}

- (void)drawRightEye {
    // 创建UIBezierPath对象
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(180, 80, 40, 40)];
    
    // 设置线条颜色
    [[UIColor blueColor] setStroke];
    
    // 设置线条宽度
    [path setLineWidth:3.0];
    
    // 绘制
    [path stroke];
    
    UIBezierPath *centerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(190, 90, 20, 20)];
    
    // 设置填充颜色
    [[UIColor blackColor] setFill];
    
    // 填充
    [centerPath fill];
}

@end
