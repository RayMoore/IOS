//
//  NEHeaderView.h
//  CoreGraphics
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
    
    // 绘制三角形作为鼻子
    [self drawTriangle];
    
    // 绘制矩形作为嘴
    [self drawRectangle];
}

// 绘制椭圆
- (void)drawEllipse {
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 定义矩形的rect
    CGRect rectangle = CGRectMake(20, 30, 280, 260);
    
    // 在当前路径下添加一个椭圆形
    CGContextAddEllipseInRect(context, rectangle);
    
    // 设置当前填充色
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    
    // 绘制当前路径区域.
    CGContextFillPath(context);
}

#pragma mark -

// 绘制矩形
- (void)drawRectangle {
    // 获取当前绘图的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 定义矩形的rect
    CGRect rectangle = CGRectMake(100, 225, 120, 15);
    
    // 在当前路径下添加一个矩形路径
    CGContextAddRect(context, rectangle);
    
    // 设置当前填充色
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    // 绘制当前路径
    CGContextFillPath(context);
}

// 绘制三角形
- (void)drawTriangle {
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 创建一个新的路径
    CGContextBeginPath(context);
    
    // 起始点
    CGContextMoveToPoint(context, 160, 140);
    
    // 添加线条
    CGContextAddLineToPoint(context, 190, 190);
    CGContextAddLineToPoint(context, 130, 190);
    
    // 关闭并终止当前路径的子路径
    CGContextClosePath(context);
    
    // 设置当前视图填充色
    CGContextSetFillColorWithColor(context, [UIColor brownColor].CGColor);
    
    // 绘制当前路径
    CGContextFillPath(context);
}

- (void)drawLeftEye {
    [self drawCycleAtCenter:CGPointMake(120, 100)];
}

- (void)drawRightEye {
    [self drawCycleAtCenter:CGPointMake(200, 100)];
}

- (void)drawCycleAtCenter:(CGPoint)center {
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 圆心
    CGFloat centerX = center.x;
    CGFloat centerY = center.y;
    
    // 半径
    CGFloat radius = 20.0;
    
    // 绘制圆形
    CGContextAddArc(context, centerX, centerY, radius, 0, 2 * M_PI, 1);
    
    // 设置线条颜色
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextSetLineWidth(context, 3.0);
    
    // 绘制
    CGContextStrokePath(context);
    
    // 半径
    CGFloat centerRadius = 10.0;
    
    // 绘制圆形
    CGContextAddArc(context, centerX, centerY, centerRadius, 0, 2 * M_PI, 1);
    
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    
    // 填充
    CGContextFillPath(context);
}

@end
