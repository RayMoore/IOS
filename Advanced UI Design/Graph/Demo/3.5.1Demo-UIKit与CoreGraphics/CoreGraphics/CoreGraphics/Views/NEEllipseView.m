//
//  NEEllipseView.m
//  CoreGraphics
//
//  Created by NetEase on 16/7/7.
//  Copyright (c) 2016年 NetEase. All rights reserved.
//

#import "NEEllipseView.h"

@implementation NEEllipseView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 下面的代码也可以用来设置View的背景色
    // CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    // CGContextFillRect(context, rect);
    
    // 定义矩形的rect
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGRect rectangle = CGRectMake((viewWidth - 280) / 2, 30, 280, 260);
    
    // 在当前路径下添加一个椭圆形
    CGContextAddEllipseInRect(context, rectangle);
    
    // 设置当前填充色
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    
    // 绘制当前路径区域.
    CGContextFillPath(context);
}

@end
