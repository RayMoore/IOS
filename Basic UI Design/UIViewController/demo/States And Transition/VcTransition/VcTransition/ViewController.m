//
//  ViewController.m
//  VcTransition
//
//  Created by wtndcs on 16/7/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ViewController.h"
#import "TargetViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"First Vc viewWillAppear");
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"First Vc viewDidAppear");
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"First Vc viewWillDisappear");
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"First Vc viewDidDisappear");
    [super viewDidDisappear:animated];
}

- (IBAction)clickPush:(id)sender
{
    TargetViewController *targetVc = [[TargetViewController alloc] init];

    [self.navigationController pushViewController:targetVc animated:NO];
}

- (IBAction)clickModal:(id)sender
{
    TargetViewController *targeVc = [[TargetViewController alloc] init];
    [self presentViewController:targeVc animated:NO completion:^{
        NSLog(@"Finish Modal");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
