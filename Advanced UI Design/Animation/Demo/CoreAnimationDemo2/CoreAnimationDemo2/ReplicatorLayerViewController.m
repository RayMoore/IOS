//
//  ReplicatorLayerViewController.m
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "ReplicatorLayerViewController.h"
#import "RLActivityIndicatorView.h"


@implementation ReplicatorLayerViewController
{
    CAReplicatorLayer *_replicatorLayer;
    RLActivityIndicatorView *_indicatorView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Replicator animation";
    
    _replicatorLayer = [CAReplicatorLayer layer];
    _replicatorLayer.frame = CGRectMake(0, 200, self.view.bounds.size.width, 50);
    [self.view.layer addSublayer:_replicatorLayer];
    
    CALayer *square = [CALayer layer];
    square.backgroundColor = [UIColor blueColor].CGColor;
    square.frame = CGRectMake(0, 0, 20, 50);
    [_replicatorLayer addSublayer:square];
    
    _replicatorLayer.instanceCount = 10;
    
    CGFloat gap = (CGRectGetWidth(_replicatorLayer.bounds) - _replicatorLayer.instanceCount * CGRectGetWidth(square.bounds)) / (_replicatorLayer.instanceCount - 1);
    _replicatorLayer.instanceTransform = CATransform3DMakeTranslation(gap + CGRectGetWidth(square.bounds), 0, 0);
    _replicatorLayer.instanceAlphaOffset = -0.1;
    
    _indicatorView = [[RLActivityIndicatorView alloc] init];
    _indicatorView.bounds = CGRectMake(0, 0, 50, 50);
    _indicatorView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    [self.view addSubview:_indicatorView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([_indicatorView isAnimating])
    {
        [_indicatorView stopAnimating];
    }
    else
    {
        [_indicatorView startAnimating];
    }
}
@end
