//
//  NECircleChart.h
//  QuartzDemo
//
//  Created by Netease on 16/7/9.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NEDemoDefinitions.h"

@interface NECircleChart : UIView

- (instancetype)initWithFrame:(CGRect)frame
                        total:(NSNumber *)total
                      current:(NSNumber *)current
                    clockwise:(BOOL)clockwise;

/**
 *  定义总的值，当前的值以及是否顺时针.
 */
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *current;
@property (nonatomic, assign) BOOL clockwise;

/**
 *  线条颜色，宽度以及显示比例信息的Label.
 */
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) NSNumber *lineWidth;
@property (nonatomic, strong) UILabel *valueLabel;

@end
