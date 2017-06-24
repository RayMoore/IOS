//
//  RLActivityIndicatorView.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/18.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "RLActivityIndicatorView.h"
#import "CALayer+AnimationControl.h"

static const NSUInteger instanceCount = 12;
static const CGFloat initialOpacity = 0.2;
static const NSTimeInterval duration = 1.25;
static NSString *const animationKeyPath = @"IndicatorAnimation";

@interface RLActivityIndicatorView ()
{
@private
    BOOL _animating;
    CALayer *_replicator;
    CAAnimationGroup *_animation;
}
@end

@implementation RLActivityIndicatorView

+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _color = [UIColor grayColor];
        
        _replicator = [CALayer layer];
        _replicator.backgroundColor = _color.CGColor;
        _replicator.allowsEdgeAntialiasing = YES;
        _replicator.opacity = initialOpacity;
        [self.layer addSublayer:_replicator];
        
        CAReplicatorLayer *replicatorLayer = (CAReplicatorLayer *)self.layer;
        replicatorLayer.instanceCount = instanceCount;
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(2 * M_PI / instanceCount, 0, 0, 1);
        replicatorLayer.instanceDelay = duration / instanceCount;
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @(initialOpacity);
        opacityAnimation.toValue = @(1);
        opacityAnimation.duration = replicatorLayer.instanceDelay * 1.5;
        opacityAnimation.autoreverses = YES;
        
        _animation = [CAAnimationGroup animation];
        _animation.animations = @[opacityAnimation];
        _animation.repeatCount = HUGE_VALF;
        _animation.duration = duration;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat size = MIN(self.bounds.size.width,self.bounds.size.height);
    CGFloat centerRadius = size / 4;
    CGFloat replicatorHeight = size / 2  - centerRadius;
    CGFloat replicatorWidth = size / 10;
    _replicator.frame = CGRectMake((CGRectGetWidth(self.bounds) - replicatorWidth) / 2, (CGRectGetHeight(self.bounds) - size) / 2, replicatorWidth, replicatorHeight);
    _replicator.cornerRadius = replicatorWidth / 2;
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    _replicator.backgroundColor = _color.CGColor;
}

- (void)startAnimating
{
    if ([_replicator animationForKey:animationKeyPath])
    {
        [self.layer ac_resume];
    }
    else
    {
        [_replicator addAnimation:_animation forKey:animationKeyPath];
    }
    _animating = YES;
}

- (void)stopAnimating
{
    _animating = NO;
    [self.layer ac_pause];
}

- (BOOL)isAnimating
{
    return _animating;
}
@end
