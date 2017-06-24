//
//  NECircleView.m
//  CoreGraphics
//
//  Created by NetEase on 16/7/7.
//  Copyright (c) 2016年 NetEase. All rights reserved.
//

#import "NECircleView.h"

@implementation NECircleView

- (void)drawRect:(CGRect)rect {
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 圆心与半径
    CGFloat centerX = 120;
    CGFloat centerY = 100;
    CGFloat radius = 20.0;
    
    // 绘制圆形
    CGContextAddArc(context, centerX, centerY, radius, 0, 2 * M_PI, 1);
    
    // 设置线条颜色与宽度
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
