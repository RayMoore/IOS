//
//  FirstViewController.m
//  TabBar
//
//  Created by wtndcs on 16/8/17.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *firstNormalImage =  [[UIImage imageNamed:@"tab_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *firstSelectedImage =  [[UIImage imageNamed:@"tab_home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:firstNormalImage selectedImage:firstSelectedImage];
    
//    self.tabBarItem.badgeValue = @"10";
    self.tabBarItem.titlePositionAdjustment = UIOffsetMake(-2, -2);
//    
//    NSShadow *shadow = [NSShadow new];
////    [shadow setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.750f]];
//    [shadow setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    
//    NSDictionary *tabBarTitleTextAttributes = @{ NSForegroundColorAttributeName:[UIColor orangeColor], NSShadowAttributeName: shadow };
    
//    [self.tabBarItem setTitleTextAttributes:tabBarTitleTextAttributes forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
