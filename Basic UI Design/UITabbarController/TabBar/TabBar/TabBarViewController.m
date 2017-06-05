//
//  TabBarViewController.m
//  TabBar
//
//  Created by wtndcs on 16/8/17.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"

@interface TabBarViewController () <UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *first = [[FirstViewController alloc] init];
    SecondViewController *second = [[SecondViewController alloc] init];
    ThirdViewController *third = [[ThirdViewController alloc] init];
    FourthViewController *fourth = [[FourthViewController alloc] init];
    FifthViewController *fifth = [[FifthViewController alloc] init];
    
    self.viewControllers = @[ first, second, third, fourth, fifth ];
    
    second.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Item 2" image:nil selectedImage:nil];
    third.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Item 3" image:nil selectedImage:nil];
    fourth.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Item 4" image:nil selectedImage:nil];
    fifth.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Item 5" image:nil selectedImage:nil];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"barBack"];
    self.tabBar.shadowImage = [UIImage imageNamed:@"shadowBorder"];
    // self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tab_indicator"];
    self.tabBar.itemWidth = 60;
    self.tabBar.itemSpacing = 20;
    self.delegate = self;
    
    //self.tabBar.barTintColor = [UIColor grayColor];
    //self.tabBar.translucent = NO;
    
    // Do any additional setup after loading the view.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[ThirdViewController class]]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"%@", viewController);
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
