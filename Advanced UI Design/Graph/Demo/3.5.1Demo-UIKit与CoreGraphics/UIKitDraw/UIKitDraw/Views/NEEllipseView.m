//
//  NEEllipseView.m
//  UIKitDraw
//
//  Created by NetEase on 16/7/7.
//  Copyright (c) 2016年 NetEase. All rights reserved.
//

#import "NEEllipseView.h"

@implementation NEEllipseView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 定义矩形的rect
    CGRect rectangle = CGRectMake(20, 30, 280, 260);
    
    // 创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rectangle];
    
    // 设置填充色
    [[UIColor orangeColor] setFill];
    
    // 填充
    [path fill];
}

@end
