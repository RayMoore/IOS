//
//  NERectTangleView.m
//  CoreGraphics
//
//  Created by NetEase on 16/7/7.
//  Copyright (c) 2016年 NetEase. All rights reserved.
//

#import "NERectangleView.h"

@implementation NERectangleView

- (void)drawRect:(CGRect)rect {
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

@end
