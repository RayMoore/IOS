//
//  ViewController.m
//  NavAction
//
//  Created by wtndcs on 16/8/7.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "NavStatistic.h"

@interface ViewController ()

@property (nonatomic, strong) NavStatistic *navStatistic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navStatistic = [[NavStatistic alloc] init];
    self.navigationController.delegate = self.navStatistic;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoNext:(id)sender {
    NextViewController *next = [[NextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

@end
