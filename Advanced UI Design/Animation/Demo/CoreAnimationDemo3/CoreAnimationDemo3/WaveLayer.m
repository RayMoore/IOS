//
//  WaveLayer.m
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/7/24.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "WaveLayer.h"

@interface WaveLayer ()
{

}
@end

@implementation WaveLayer
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = 2;
    }
    return self;
}

#pragma mark - draw curve
- (void)drawSinCurveWithAmplitude:(CGFloat)amplitude frequency:(CGFloat)frequency phase:(CGFloat)phase
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSUInteger pointCount = self.bounds.size.width;
    for (int x = 0; x <= pointCount; x++)
    {
        //y=Asin(ωx+φ)+k => y = amplitude * sin(frequency * x + phase) + view.Height / 2
        CGFloat y = amplitude * sin(x * frequency + phase) + self.bounds.size.height / 2;
        if (x == 0)
        {
            [path moveToPoint:CGPointMake(x, y)];
        }
        else
        {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    self.path = path.CGPath;
}

#pragma mark - without animation
- (void)layoutSublayers
{
    [super layoutSublayers];
    
    [self drawCurve];
}

- (void)setAmplitude:(CGFloat)amplitude
{
    _amplitude = amplitude;
    [self drawCurve];
}

- (void)setPhase:(CGFloat)phase
{
    _phase = phase;
    [self drawCurve];
}

- (void)setFrequency:(CGFloat)frequency
{
    _frequency = frequency;
    [self drawCurve];
}

- (void)drawCurve
{
    [self drawSinCurveWithAmplitude:_amplitude frequency:_frequency phase:_phase];
}
@end
