//
//  SLDownloadProgressView.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/19.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "SLDownloadProgressView.h"

static const NSTimeInterval totalProgressDuration = 0.5;
static const NSTimeInterval singleMarkLineDuration = 0.25;

@interface SLDownloadProgressView ()
{
    UILabel *_label;
    CAShapeLayer *_progressShapeLayer;
    CAShapeLayer *_completeShapeLayer;
    CGFloat _size;
    CGRect _markRect;
    
    UIBezierPath *_successPath;
    UIBezierPath *_failPath;
}
@end

@implementation SLDownloadProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _size = -1;
        _markRect = CGRectZero;
        
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"start";
        [self addSubview:_label];
        
        _progressShapeLayer = [CAShapeLayer layer];
        _progressShapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        _progressShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _progressShapeLayer.strokeEnd = 0;
        _progressShapeLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:_progressShapeLayer];
        
        _completeShapeLayer = [CAShapeLayer layer];
        _completeShapeLayer.strokeColor = _progressShapeLayer.strokeColor;
        _completeShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _completeShapeLayer.strokeEnd = 0;
        _completeShapeLayer.lineCap = _progressShapeLayer.lineCap;
        _completeShapeLayer.lineJoin = kCALineJoinRound;
        [self.layer addSublayer:_completeShapeLayer];
    }
    return self;
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat size = MIN(self.bounds.size.width, self.bounds.size.height);
    _label.bounds = CGRectMake(0, 0, size, size);
    _label.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _progressShapeLayer.frame = _label.frame;
    _completeShapeLayer.frame = _label.frame;
    
    BOOL sizeChanged = _size < 0 || fabs(_size - size) > DBL_EPSILON;
    if (sizeChanged)
    {
        _size = size;
        [self configLayers];
        [self configCompleteMarkPath];
    }
}

- (void)configLayers
{
    _progressShapeLayer.lineWidth = _size / 20;
    _completeShapeLayer.lineWidth = _progressShapeLayer.lineWidth;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_size / 2, _progressShapeLayer.lineWidth / 2)];
    [path addArcWithCenter:CGPointMake(_size / 2, _size / 2) radius:_size / 2 - _progressShapeLayer.lineWidth / 2 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    [path closePath];

    _progressShapeLayer.path = path.CGPath;
}

- (void)configCompleteMarkPath
{
    CGFloat markSize = _size / sqrt(2);
    _markRect = CGRectMake((_size - markSize) / 2, (_size - markSize) / 2, markSize, markSize);
    _successPath = nil;
    _failPath = nil;
}

#pragma mark - animation
- (UIBezierPath *)successPath
{
    if (!_successPath)
    {
        _successPath = [UIBezierPath bezierPath];
        [_successPath moveToPoint:CGPointMake(CGRectGetMinX(_markRect) + 0.27083 * CGRectGetWidth(_markRect),
                                              CGRectGetMinY(_markRect) + 0.54167 * CGRectGetHeight(_markRect))];
        [_successPath addLineToPoint:CGPointMake(CGRectGetMinX(_markRect) + 0.41667 * CGRectGetWidth(_markRect),
                                                 CGRectGetMinY(_markRect) + 0.68750 * CGRectGetHeight(_markRect))];
        [_successPath addLineToPoint:CGPointMake(CGRectGetMinX(_markRect) + 0.75000 * CGRectGetWidth(_markRect),
                                                 CGRectGetMinY(_markRect) + 0.35417 * CGRectGetHeight(_markRect))];
    }
    return _successPath;
}

- (UIBezierPath *)failPath
{
    if (!_failPath)
    {
        CGFloat crossSize = _markRect.size.width * 0.4;
        CGFloat margin = (_markRect.size.width - crossSize) / 2;
        
        _failPath = [UIBezierPath bezierPath];
        [_failPath moveToPoint:CGPointMake(CGRectGetMinX(_markRect) + margin, CGRectGetMinY(_markRect) + margin)];
        [_failPath addLineToPoint:CGPointMake(CGRectGetMaxX(_markRect) - margin, CGRectGetMaxY(_markRect) - margin)];
        [_failPath moveToPoint:CGPointMake(CGRectGetMaxX(_markRect) - margin, CGRectGetMinY(_markRect) + margin)];
        [_failPath addLineToPoint:CGPointMake(CGRectGetMinX(_markRect) + margin, CGRectGetMaxY(_markRect) - margin)];
    }
    return _failPath;
}

- (void)showCompleteAnimationWithPath:(UIBezierPath *)path duration:(NSTimeInterval)duration
{
    _finished = YES;
    [UIView animateWithDuration:0.1 animations:^{
        _label.alpha = 0;
    } completion:^(BOOL finished) {
        _completeShapeLayer.path = path.CGPath;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(0);
        animation.toValue = @(1);
        animation.duration = duration;
        animation.beginTime = [_completeShapeLayer convertTime:CACurrentMediaTime() fromLayer:nil] + 0.1;
        animation.fillMode = kCAFillModeBackwards;
        animation.removedOnCompletion = NO;
        [_completeShapeLayer addAnimation:animation forKey:animation.keyPath];
    }];
}

#pragma mark - actions
- (void)reset
{
    [self setProgress:0 animated:NO finished:nil];
    [_progressShapeLayer removeAllAnimations];
    _completeShapeLayer.strokeEnd = 0;
    [_completeShapeLayer removeAllAnimations];
    _label.alpha = 1;
    _label.text = @"start";
    _finished = NO;
}

- (void)failed
{
    self.progress = 1;
    [self showCompleteAnimationWithPath:[self failPath] duration:singleMarkLineDuration * 2];
}

- (void)succeed
{
    [self showCompleteAnimationWithPath:[self successPath] duration:singleMarkLineDuration];
}

#pragma mark - progress
- (void)setProgress:(float)progress
{
    __weak typeof(self)weakSelf = self;
    [self setProgress:progress animated:YES finished:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.progress >= 1 && !_finished)
        {
            [strongSelf succeed];
        }
    }];
}

- (void)setProgress:(float)progress animated:(BOOL)animated finished:(void(^)(void))finished
{
    _progress = MIN(progress, 1);
    _label.text = [NSString stringWithFormat:@"%.0f",_progress * 100];
    if (animated)
    {
        [CATransaction begin];
        [CATransaction setCompletionBlock:finished];
        
        CGFloat lastValue = ((CAShapeLayer *)[_progressShapeLayer presentationLayer]).strokeEnd;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(lastValue);
        animation.toValue = @(_progress);
        animation.duration = (_progress - lastValue) * totalProgressDuration;
        _progressShapeLayer.strokeEnd = _progress;
        [_progressShapeLayer addAnimation:animation forKey:animation.keyPath];
        
        [CATransaction commit];
    }
    else
    {
        _progressShapeLayer.strokeEnd = _progress;
        if (finished)
        {
            finished();
        }
    }
}
@end
