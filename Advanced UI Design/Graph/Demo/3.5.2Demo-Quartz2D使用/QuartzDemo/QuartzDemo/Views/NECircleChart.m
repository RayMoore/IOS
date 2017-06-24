//
//  NECircleChart.m
//  QuartzDemo
//
//  Created by Netease on 16/7/9.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NECircleChart.h"

@implementation NECircleChart

- (instancetype)initWithFrame:(CGRect)frame
                        total:(NSNumber *)total
                      current:(NSNumber *)current
                    clockwise:(BOOL)clockwise {
    self = [self initWithFrame:frame];
    if (self) {
        _total = total;
        _current = current;
        _strokeColor = [UIColor orangeColor];
        _clockwise = clockwise;
        _lineWidth = @(8.0);
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    if ([_total integerValue] <= 0) {
        return;
    }
    
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 起始弧度与结束弧度
    CGFloat startAngle = 270.0f;
    CGFloat angleOffset = 360 * ([_current floatValue] / [_total floatValue]);
    CGFloat curEndAngle = _clockwise ? startAngle + angleOffset : startAngle - angleOffset;
    
    // 添加弧线
    // 注意：这里的clockwise有所不同由于坐标系的原因，0才真正表示UIKit里的顺时针
    CGFloat centerX = CGRectGetWidth(self.frame) / 2.0f;
    CGFloat centerY = CGRectGetHeight(self.frame) / 2.0f;
    CGFloat radius = centerX < centerY ? centerX : centerY;
    radius -= ([_lineWidth floatValue] / 2.0f);
    CGContextAddArc(context, centerX, centerY, radius, DEGREES_TO_RADIANS(startAngle), DEGREES_TO_RADIANS(curEndAngle), self.clockwise ? 0 : 1);
    
    // 设置颜色与线条属性.
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetLineWidth(context, [_lineWidth floatValue]);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, _strokeColor.CGColor);
    
    // 绘制弧线
    CGContextStrokePath(context);
    
    // 添加表示当前值的Label
    if (nil == self.valueLabel) {
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0, 50.0)];
        [self.valueLabel setTextAlignment:NSTextAlignmentCenter];
        [self.valueLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [self.valueLabel setTextColor:[UIColor grayColor]];
        [self.valueLabel setBackgroundColor:[UIColor clearColor]];
        [self.valueLabel setCenter:CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f)];
        [self addSubview:self.valueLabel];
    }
    
    CGFloat percentage = 100 * [self.current floatValue] / [self.total floatValue];
    self.valueLabel.text = [NSString stringWithFormat:@"%@%%", @((NSInteger)percentage)];
}

@end
