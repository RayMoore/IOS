//
//  ViewController.m
//  VcStates
//
//  Created by wtndcs on 16/7/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    NSLog(@"Before Load View");
    [super loadView];
    NSLog(@"After Load View");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVcView:)];
    tapGesture.cancelsTouchesInView    = NO;
    tapGesture.numberOfTapsRequired    = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 80, 100, 40)];
    label.text = @"My Label in view DidLoad";
    [self.view addSubview:label];
    
    NSLog(@"view did load");
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)tapVcView:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"tapGesture");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view will appear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"view did appear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
