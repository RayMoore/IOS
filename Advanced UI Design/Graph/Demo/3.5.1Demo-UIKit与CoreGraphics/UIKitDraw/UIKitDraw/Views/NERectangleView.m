//
//  NERectTangleView.m
//  UIKitDraw
//
//  Created by NetEase on 16/7/7.
//  Copyright (c) 2016年 NetEase. All rights reserved.
//

#import "NERectangleView.h"

@implementation NERectangleView

- (void)drawRect:(CGRect)rect {
    // 定义矩形的rect
    CGRect rectangle = CGRectMake(100, 225, 120, 15);
    
    // 创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rectangle];
    
    // 设置填充色
    [[UIColor redColor] setFill];
    
    // 填充
    [path fill];
}

@end
