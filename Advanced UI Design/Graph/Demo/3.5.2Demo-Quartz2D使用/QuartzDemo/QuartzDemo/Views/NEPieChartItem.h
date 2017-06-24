//
//  NEPieChartItem.h
//  QuartzDemo
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NEPieChartItem : NSObject

/**
 *  饼图上显示的名字
 */
@property (nonatomic, copy) NSString *name;

/**
 *  饼图上这一部分的颜色
 */
@property (nonatomic, strong) UIColor *color;

/**
 *  饼图上这一部分所展的值或比例. Demo中总值为100，因此value即为比例.
 *  实际项目中需要计算总的值与每一份所占的比例.
 */
@property (nonatomic, assign) CGFloat value;

/**
 *  饼图上所占比例的起始值与结束值
 */
@property (nonatomic, assign) CGFloat startPercentage;
@property (nonatomic, assign) CGFloat endPercentage;

@end
