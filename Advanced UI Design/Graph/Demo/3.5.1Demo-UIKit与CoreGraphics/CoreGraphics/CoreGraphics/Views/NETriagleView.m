//
//  NETriagleView.m
//  CoreGraphics
//
//  Created by NetEase on 16/7/7.
//  Copyright (c) 2016年 NetEase. All rights reserved.
//

#import "NETriagleView.h"

@implementation NETriagleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
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

@end
