//
//  NextViewController.m
//  CustomNav
//
//  Created by wtndcs on 16/7/31.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController () <UIGestureRecognizerDelegate>

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航栏标题";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    UIBarButtonItem *negSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negSpaceItem.width = -10;
//    
//    UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgBack"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
//    customView.backgroundColor = [UIColor yellowColor];
//    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
//    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navClose"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //self.navigationItem.leftBarButtonItems = @[leftBackItem,  closeItem];
    
    //self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navShare"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.backgroundColor = [UIColor blueColor];
    //self.navigationItem.titleView = titleView;
    //self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    if (self.navigationController.interactivePopGestureRecognizer.delegate) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
    
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
