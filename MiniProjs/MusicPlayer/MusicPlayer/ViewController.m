//
//  ViewController.m
//  MusicPlayer
//
//  Created by Ray on 03/07/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CALayer *_layer1;
    CALayer *_layer2;
    CALayer *_layer3;
    CALayer *_layer4;
    NSArray *_layers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"netease music player";
    
    _layer1 = [CALayer layer];
    _layer1.backgroundColor = [UIColor redColor].CGColor;
    _layer1.frame = CGRectMake(100, 300, 30, 60);
    [self.view.layer addSublayer:_layer1];
    
    _layer2 = [CALayer layer];
    _layer2.backgroundColor = [UIColor redColor].CGColor;
    _layer2.frame = CGRectMake(150, 300, 30, 120);
    [self.view.layer addSublayer:_layer2];
    
    _layer3 = [CALayer layer];
    _layer3.backgroundColor = [UIColor redColor].CGColor;
    _layer3.frame = CGRectMake(200, 300, 30, 60);
    [self.view.layer addSublayer:_layer3];
    
    _layer4 = [CALayer layer];
    _layer4.backgroundColor = [UIColor redColor].CGColor;
    _layer4.frame = CGRectMake(250, 300, 30, 120);
    [self.view.layer addSublayer:_layer4];
    
    _layers = @[_layer1,_layer2,_layer3,_layer4];
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testSpringAnimation];
    //    [self damping];
    //    [self velocity];
    //    [self mass];
    //    [self stiffness];
}

- (void)testSpringAnimation
{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"bounds"];
    
    CGRect rect = _layer1.bounds;
    rect.size.height = 60;
    animation.fromValue = [NSValue valueWithCGRect:rect];
    rect.size.height = 120;
    animation.toValue = [NSValue valueWithCGRect:rect];
    //    animation.duration = 1;
    //    animation.duration = 5;
    //    animation.delegate = self;
    //    NSLog(@"%lf",animation.settlingDuration);
    //    animation.duration = animation.settlingDuration;
    _layer1.bounds = rect;
    
    [_layer1 addAnimation:animation forKey:animation.keyPath];
    NSLog(@"started");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
