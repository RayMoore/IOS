//
//  NavViewController.m
//  CustomContainer
//
//  Created by wtndcs on 16/7/3.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NavViewController.h"
#import "CustomContainerViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        CustomContainerViewController *parent = [[CustomContainerViewController alloc] init];
        self.viewControllers = @[ parent ];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
