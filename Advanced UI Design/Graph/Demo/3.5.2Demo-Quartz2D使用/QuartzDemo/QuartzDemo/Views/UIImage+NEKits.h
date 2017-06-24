//
//  UIImage+NEKits.h
//  QuartzDemo
//
//  Created by Netease on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NEKits)

// 截屏
+ (UIImage *)imageFromView:(UIView *)view;

// 给图片加圆角
- (UIImage *)imageWithRoundedCorner:(CGFloat)radius
                               size:(CGSize)size;

// 给图片加圆角同时添加边框颜色
- (UIImage *)imageWithRoundedCorner:(CGFloat)radius
                               size:(CGSize)size
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor;

@end
