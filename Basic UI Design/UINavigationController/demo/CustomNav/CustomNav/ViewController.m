//
//  ViewController.m
//  CustomNav
//
//  Created by wtndcs on 16/7/31.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"导航栏标题";
    
//     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBack"] forBarMetrics:UIBarMetricsDefault];
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
//   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    self.view.backgroundColor = [UIColor blueColor];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"navSep"];
//    
//    NSShadow *shadow = [NSShadow new];
//    [shadow setShadowColor: [UIColor colorWithWhite:0.0f alpha:0.750f]];
//    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
//
//    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                               [UIColor yellowColor],NSForegroundColorAttributeName,
//                                               shadow, NSShadowAttributeName, nil];
//
//    [self.navigationController.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
//    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:10 forBarMetrics:UIBarMetricsDefault];
//
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"imgBack"]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"imgBack"]];
//    [self.navigationController setNavigationBarHidden:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)clickPushNext:(id)sender
{
    NextViewController *next = [[NextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

- (void)popOUt
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
