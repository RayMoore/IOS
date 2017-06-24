//
//  NETriagleView.m
//  UIKitDraw
//
//  Created by NetEase on 16/7/7.
//  Copyright (c) 2016年 NetEase. All rights reserved.
//

#import "NETriagleView.h"

@implementation NETriagleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
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

@end
