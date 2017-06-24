//
//  NECircleView.m
//  UIKitDraw
//
//  Created by NetEase on 16/7/7.
//  Copyright (c) 2016年 NetEase. All rights reserved.
//

#import "NECircleView.h"

@implementation NECircleView

- (void)drawRect:(CGRect)rect {
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

@end
