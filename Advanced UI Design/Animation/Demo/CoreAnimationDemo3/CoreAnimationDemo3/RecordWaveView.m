//
//  RecordWaveView.m
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/7/24.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "RecordWaveView.h"
#import "WaveLayer.h"

static const NSTimeInterval durationForPowerAnimation = 0.25;

@interface RecordWaveView ()
{
    NSArray *_waves;
    CADisplayLink *_displayLink;
    
    float _currentPower;
    float _powerIncreasePerSecond;
}
@end

@implementation RecordWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        WaveLayer *wave1 = [WaveLayer layer];
        wave1.frequency = 0.15;
        [self.layer addSublayer:wave1];
        
        WaveLayer *wave2 = [WaveLayer layer];
        wave2.frequency = 0.05;
        wave2.phase = M_PI;
        [self.layer addSublayer:wave2];
        
        WaveLayer *wave3 = [WaveLayer layer];
        wave3.frequency = 0.05;
        wave3.phase = M_PI_2;
        [self.layer addSublayer:wave3];
        
        _waves = @[wave1,wave2,wave3];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (CALayer *wave in _waves)
    {
        wave.frame = self.bounds;
    }
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    for (WaveLayer *layer in _waves)
    {
        NSUInteger index = [_waves indexOfObject:layer] + 1;
        layer.strokeColor = [_color colorWithAlphaComponent:1.0f / index].CGColor;
    }
}

- (void)setPower:(float)power
{
    if (_displayLink)
    {
        _power = MAX(MIN(power, 1), 0);
        _powerIncreasePerSecond = (_power - _currentPower) / durationForPowerAnimation;
    }
    else
    {
        [self setPowerInternal:power];
    }
}

- (void)setPowerInternal:(float)power
{
    for (WaveLayer *wave in _waves)
    {
        NSUInteger index = [_waves indexOfObject:wave] + 1;
        wave.amplitude = index * 30 * power;
    }
}

- (void)displayLinkInvoke:(CADisplayLink *)displayLink
{
    _currentPower += displayLink.duration * _powerIncreasePerSecond;
    if (_powerIncreasePerSecond > 0 && _currentPower >= _power)
    {
        _currentPower = _power;
    }
    else if (_powerIncreasePerSecond < 0 && _currentPower <= _power)
    {
        _currentPower = _power;
    }
    [self setPowerInternal:_currentPower];
    
    
    for (WaveLayer *wave in _waves)
    {
        NSUInteger index = [_waves indexOfObject:wave] + 1;
        wave.phase = wave.phase - index * 0.1;
    }
}

- (void)start
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkInvoke:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop
{
    [_displayLink invalidate];
    _displayLink = nil;
    self.power = 0;
}
@end
