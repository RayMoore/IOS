//
//  NEPieChartViewController.m
//  QuartzDemo
//
//  Created by Netease on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NEPieChartViewController.h"
#import "NEPieChartView.h"
#import "NEPieChartItem.h"

@interface NEPieChartViewController ()

@property (nonatomic, strong) NEPieChartView *pieChart;

@end

@implementation NEPieChartViewController

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
    CGFloat circleRadius = 120;
    CGRect rect = CGRectMake(CGRectGetWidth(self.view.frame) / 2.0 - circleRadius, 115, circleRadius * 2, circleRadius * 2);
    self.pieChart = [[NEPieChartView alloc] initWithFrame:rect];
    self.pieChart.radius = 100;
    self.pieChart.innerRadius = 33;
    self.pieChart.clickedRadius = 110;
    self.pieChart.itemList = [self buildTestData];
    self.pieChart.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pieChart];
}

#pragma mark - 构造测试数据

- (NSArray<NEPieChartItem *> *)buildTestData {
    NSMutableArray *itemList = [[NSMutableArray alloc] init];
    
    {
        NEPieChartItem *item = [[NEPieChartItem alloc] init];
        item.name = @"开发";
        item.value = 10;
        item.color = [UIColor colorWithRed:77.0 / 255.0 green:216.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f];
        [itemList addObject:item];
    }

    {
        NEPieChartItem *item = [[NEPieChartItem alloc] init];
        item.name = @"测试";
        item.value = 20;
        item.color = [UIColor redColor];
        [itemList addObject:item];
    }
    
    {
        NEPieChartItem *item = [[NEPieChartItem alloc] init];
        item.name = @"产品";
        item.value = 30;
        item.color = [UIColor blueColor];
        [itemList addObject:item];
    }
    
    {
        NEPieChartItem *item = [[NEPieChartItem alloc] init];
        item.name = @"运维";
        item.value = 40;
        item.color = [UIColor purpleColor];
        [itemList addObject:item];
    }
    
    CGFloat sumValue;
    for (NEPieChartItem *item in itemList) {
        sumValue += item.value;
    }
    
    if (sumValue > 0) {
        CGFloat startPercentage = 0;
        for (NEPieChartItem *item in itemList) {
            item.startPercentage = startPercentage;
            item.endPercentage = item.startPercentage + item.value / sumValue;
            startPercentage = item.endPercentage;
        }
    }
    
    return itemList;
}

@end
