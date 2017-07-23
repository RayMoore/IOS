//
//  NECircleChart.h
//  QuartzDemo
//
//  Created by Netease on 16/7/9.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NECircleChart : UIView

- (instancetype)initWithFrame:(CGRect)frame
                        total:(NSNumber *)total
                      current:(NSNumber *)current
                    clockwise:(BOOL)clockwise;

@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *current;
@property (nonatomic, assign) BOOL clockwise;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) NSNumber *lineWidth;
@property (nonatomic, strong) UILabel *valueLabel;

@end
