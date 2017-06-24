//
//  CPWaveLayer.m
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/7/24.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "CPWaveLayer.h"

static NSString * const kAmplitudeKey = @"amplitude";
static NSString * const kFrequencyKey = @"frequency";
static NSString * const kPhaseKey = @"phase";

@implementation CPWaveLayer
@dynamic amplitude;
@dynamic frequency;
@dynamic phase;

+ (NSArray *)customKeys
{
    static NSArray *__customKeys = nil;
    if (!__customKeys)
    {
        __customKeys = @[kAmplitudeKey,kFrequencyKey,kPhaseKey];
    }
    return __customKeys;
}

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

#pragma mark - property animation
- (id<CAAction>)actionForKey:(NSString *)event
{
    if ([[[self class] customKeys] containsObject:event])
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.fromValue = [[self presentationLayer] valueForKey:event];
        return animation;
    }
    return [super actionForKey:event];
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([[self customKeys] containsObject:key])
    {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)display
{
    CGFloat amplitude = [(CPWaveLayer *)[self presentationLayer] amplitude];
    CGFloat phase = [(CPWaveLayer *)[self presentationLayer] phase];
    CGFloat frequency = [(CPWaveLayer *)[self presentationLayer] frequency];
    
    [self drawSinCurveWithAmplitude:amplitude frequency:frequency phase:phase];
}
@end
