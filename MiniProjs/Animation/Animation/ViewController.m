//
//  ViewController.m
//  Animation
//
//  Created by Ray on 03/07/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "ViewController.h"
#import "BarAnimation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    BarAnimation *bar = [[BarAnimation alloc] init];
    [bar setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bar];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
