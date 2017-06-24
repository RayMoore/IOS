//
//  ShapeLayerViewController.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "ShapeLayerViewController.h"
#import "SLDownloadProgressView.h"

@interface ShapeLayerViewController ()
{
    CAShapeLayer *_cycleLayer;
    
    UIBezierPath *_path1;
    UIBezierPath *_path2;
    
    CAShapeLayer *_lineLayer;
    
    SLDownloadProgressView *_progressView;
    NSTimer *_timer;
}
@end

@implementation ShapeLayerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Shape layer animation";
    
    _cycleLayer = [CAShapeLayer layer];
    _cycleLayer.frame = CGRectMake(150, 150, 100, 100);
    _cycleLayer.strokeColor = [UIColor redColor].CGColor;
//    _cycleLayer.strokeStart = 0.2;
//    _cycleLayer.strokeEnd = 0.5;
    _cycleLayer.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_cycleLayer];
    
    _path1 = [UIBezierPath bezierPathWithOvalInRect:_cycleLayer.bounds];
    _path2 = [UIBezierPath bezierPathWithRect:_cycleLayer.bounds];
    _cycleLayer.path = _path1.CGPath;
    
    _lineLayer = [CAShapeLayer layer];
    _lineLayer.frame = CGRectMake(100, 500, 200, 100);
    _lineLayer.strokeColor = [UIColor orangeColor].CGColor;
    _lineLayer.lineWidth = 2;
    _lineLayer.fillColor = [UIColor clearColor].CGColor;
    _lineLayer.borderColor = [UIColor blackColor].CGColor;
    _lineLayer.borderWidth = 1;
    _lineLayer.lineCap = kCALineCapRound;
    _lineLayer.lineJoin = kCALineJoinBevel;
    _lineLayer.lineDashPhase = 5;
    _lineLayer.lineDashPattern = @[@10,@10];
    [self.view.layer addSublayer:_lineLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(_lineLayer.bounds.size.width / 2, _lineLayer.bounds.size.height)];
    [path addLineToPoint:CGPointMake(_lineLayer.bounds.size.width, 0)];
    _lineLayer.path = path.CGPath;
    
    _progressView = [[SLDownloadProgressView alloc] init];
    _progressView.bounds = CGRectMake(0, 0, 80, 80);
    _progressView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    [self.view addSubview:_progressView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self testPath];
//    [self testLine];
    [self triggleDownload];
}

- (void)triggleDownload
{
    //点击重置动画的逻辑
    if ([_timer isValid] || _progressView.finished)
    {
        [_timer invalidate];
        [_progressView reset];
    }
    else
    {
        [self startDownload];
    }
}

- (void)startDownload
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(downloading:) userInfo:nil repeats:YES];
}

- (void)downloading:(NSTimer *)timer
{
    if (arc4random_uniform(100) == 0)
    {
        //每0.02秒 1/100几率失败
        [_progressView failed];
        [timer invalidate];
    }
    else
    {
        _progressView.progress = _progressView.progress + 0.01;
        if (_progressView.progress >= 1)
        {
            [timer invalidate];
        }
    }
}

- (void)testLine
{
    CGFloat fromWidth = _lineLayer.lineWidth;
    CGFloat toWidth = 10 - _lineLayer.lineWidth;
    CABasicAnimation *lineWidth = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidth.fromValue = @(fromWidth);
    lineWidth.toValue = @(toWidth);
    lineWidth.duration = 1;
    _lineLayer.lineWidth = toWidth;
    [_lineLayer addAnimation:lineWidth forKey:lineWidth.keyPath];
    
    CGFloat fromLineDashPhase = _lineLayer.lineDashPhase;
    CGFloat toLineDashPhase = 20 - _lineLayer.lineDashPhase;
    CABasicAnimation *lineDashPhase = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
    lineDashPhase.fromValue = @(fromLineDashPhase);
    lineDashPhase.toValue = @(toLineDashPhase);
    lineDashPhase.duration = 1;
    _lineLayer.lineDashPhase = toLineDashPhase;
    [_lineLayer addAnimation:lineDashPhase forKey:lineDashPhase.keyPath];
}

- (void)testPath
{
    //因为CAShapeLayer会copy path，所以path的比较不能直接对比指针
    CGPathRef fromValue = _cycleLayer.path;
    CGPathRef toValue = CGPathEqualToPath(_path1.CGPath, fromValue) ? _path2.CGPath : _path1.CGPath;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(fromValue);
    animation.toValue = (__bridge id _Nullable)(toValue);
    animation.duration = 2;
    _cycleLayer.path = toValue;
    [_cycleLayer addAnimation:animation forKey:animation.keyPath];
    
    CGColorRef fromColor = _cycleLayer.strokeColor;
    CGColorRef toColor = CGPathEqualToPath(_path1.CGPath, fromValue) ? [UIColor yellowColor].CGColor :
    [UIColor redColor].CGColor;
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    colorAnimation.fromValue = (__bridge id _Nullable)(fromColor);
    colorAnimation.toValue = (__bridge id _Nullable)(toColor);
    colorAnimation.duration = 2;
    _cycleLayer.strokeColor = toColor;
    [_cycleLayer addAnimation:colorAnimation forKey:colorAnimation.keyPath];
    
    
    CGColorRef fromFill = _cycleLayer.fillColor;
    CGColorRef toFill = CGPathEqualToPath(_path1.CGPath, fromValue) ? [UIColor clearColor].CGColor :
    [UIColor redColor].CGColor;
    CABasicAnimation *fillAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillAnimation.fromValue = (__bridge id _Nullable)(fromFill);
    fillAnimation.toValue = (__bridge id _Nullable)(toFill);
    fillAnimation.duration = 2;
    _cycleLayer.fillColor = toFill;
    [_cycleLayer addAnimation:fillAnimation forKey:fillAnimation.keyPath];
}
@end
