//
//  UIImage+NEKits.m
//  QuartzDemo
//
//  Created by Netease on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "UIImage+NEKits.h"

@implementation UIImage (NEKits)

#pragma mark - 截屏

+ (UIImage *)imageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 给图片加圆角

- (UIImage *)imageWithRoundedCorner:(CGFloat)radius
                               size:(CGSize)size {
    return [self imageWithRoundedCorner:radius size:size borderWidth:0 borderColor:nil];
}

- (UIImage *)imageWithRoundedCorner:(CGFloat)radius
                               size:(CGSize)size
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    // 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 切圆角 Path
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    [path closePath];
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 添加边框
    if (borderColor != nil) {
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
        [borderPath setLineWidth:borderWidth];
        [borderColor setStroke];
        [borderPath stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
