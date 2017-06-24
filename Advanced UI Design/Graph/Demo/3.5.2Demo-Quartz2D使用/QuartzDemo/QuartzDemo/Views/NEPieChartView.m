//
//  NEPieChartView.m
//  QuartzDemo
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NEPieChartView.h"
#import "NEPieChartItem.h"

@interface NEPieChartView()

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation NEPieChartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置默认的属性
        // 半径
        _radius = 100;
        
        // 内圆半径
        _innerRadius = 33;
        
        // 选中后的外圆半径
        _clickedRadius = 110;
        
        // 每项间距
        _sliceSpace = 0;
        
        _selectedIndex = -1;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawData:self.itemList];
}

- (void)drawData:(NSArray<NEPieChartItem *> *)itemList {
    if ([itemList count] == 0) {
        return;
    }
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 半径与圆点
    CGFloat radius = self.radius;
    CGFloat innerRadius = self.innerRadius;
    CGFloat sliceSpace = self.sliceSpace;
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat centerY = CGRectGetMidY(self.bounds);
    CGFloat deg2Rad = (M_PI / 180.0);
    
    // 起始弧度
    CGFloat rotationAngle = 270;
    CGFloat angle = 0.0;
    NSInteger index = 0;
    for (NEPieChartItem * item in itemList) {
        CGFloat value = item.value;
        CGFloat sliceAngle = value * 360.0 / 100;
        if (fabs(value) > 0.000001) {
            // 起始角度与结束角度.
            CGFloat startAngle = rotationAngle + (angle + sliceSpace / 2.0);
            CGFloat sweepAngle = (sliceAngle - sliceSpace / 2.0);
            if (sweepAngle < 0.0) {
                sweepAngle = 0.0;
            }
            CGFloat endAngle = startAngle + sweepAngle;
            
            // 外圆
            CGFloat outRadius = radius;
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, nil, centerX, centerY);
            CGPathAddArc(path, nil, centerX, centerY, outRadius, startAngle * deg2Rad, endAngle * deg2Rad, false);
            CGPathCloseSubpath(path);
            
            // 内圆
            if (innerRadius > 0.0) {
                CGPathMoveToPoint(path, nil, centerX, centerY);
                CGPathAddArc(path, nil, centerX, centerY, innerRadius, startAngle * deg2Rad, endAngle * deg2Rad, false);
                CGPathCloseSubpath(path);
            }
            
            // 绘制
            CGContextBeginPath(context);
            CGContextAddPath(context, path);
            CGContextSetFillColorWithColor(context, item.color.CGColor);
            CGContextEOFillPath(context);
            
            // 画选中部分.
            if (index == self.selectedIndex) {
                CGMutablePathRef path = CGPathCreateMutable();
                CGPathMoveToPoint(path, nil, centerX, centerY);
                CGPathAddArc(path, nil, centerX, centerY, _clickedRadius, startAngle * deg2Rad, endAngle * deg2Rad, false);
                CGPathCloseSubpath(path);
                
                if (innerRadius > 0.0) {
                    CGPathMoveToPoint(path, nil, centerX, centerY);
                    CGPathAddArc(path, nil, centerX, centerY, innerRadius, startAngle * deg2Rad, endAngle * deg2Rad, false);
                    CGPathCloseSubpath(path);
                }
                
                CGContextBeginPath(context);
                CGContextAddPath(context, path);
                CGContextSetFillColorWithColor(context, [item.color colorWithAlphaComponent:0.5].CGColor);
                CGContextEOFillPath(context);
            }
        }
        
        index ++;
        angle += sliceAngle;
    }
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInView:self];
        [self didTouchAt:touchLocation];
    }
}

- (void)didTouchAt:(CGPoint)touchLocation {
    if (self.selectedIndex != -1) {
        self.selectedIndex = -1;
        [self setNeedsDisplay];
        return;
    }
    
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat centerY = CGRectGetMidY(self.bounds);
    CGPoint circleCenter = CGPointMake(centerX, centerY);
    CGFloat distanceFromCenter = sqrtf(powf((touchLocation.y - circleCenter.y),2) + powf((touchLocation.x - circleCenter.x),2));
    
    if (distanceFromCenter < _innerRadius) {
        self.selectedIndex = -1;
    } else {
        CGFloat percentage = [self findPercentageOfAngleInCircle:circleCenter fromPoint:touchLocation];
        
        for (NSInteger index = 0; index < [self.itemList count]; index ++) {
            CGFloat endPercentage = [self.itemList[index] endPercentage];
            if (percentage <= endPercentage) {
                self.selectedIndex = index;
                break;
            }
        }
    }
    
    [self setNeedsDisplay];
}

- (CGFloat)findPercentageOfAngleInCircle:(CGPoint)center fromPoint:(CGPoint)reference {
    CGFloat angleOfLine = atanf((reference.y - center.y) / (reference.x - center.x));
    CGFloat percentage = (angleOfLine + M_PI/2)/(2 * M_PI);
    return (reference.x - center.x) > 0 ? percentage : percentage + .5;
}

@end
