//
//  NECircleProgressViewController.m
//  QuartzDemo
//
//  Created by Netease on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NECircleProgressViewController.h"
#import "NECircleChart.h"

@interface NECircleProgressViewController ()

@property (nonatomic, strong) NECircleChart *circleChart;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation NECircleProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self addSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)addSubView {
    CGFloat startX = (CGRectGetWidth(self.view.bounds) - 280) / 2;
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(startX, 80, 280, 40)];
    self.slider.minimumValue = 1;
    self.slider.maximumValue = 100;
    self.slider.value = 72;
    [self.slider addTarget:self action:@selector(updateCurrentValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.slider];
    
    CGRect rect = CGRectMake(0, 150.0, CGRectGetWidth(self.view.frame), 200.0);
    self.circleChart = [[NECircleChart alloc] initWithFrame:rect
                                                      total:@100
                                                    current:@(self.slider.value)
                                                  clockwise:YES];
    self.circleChart.backgroundColor = [UIColor clearColor];
    [self.circleChart setStrokeColor:[UIColor orangeColor]];
    [self.view addSubview:self.circleChart];
}

- (void)updateCurrentValue:(UISlider *)slider {
    self.circleChart.current = @(slider.value);
    [self.circleChart setNeedsDisplay];
}

@end
