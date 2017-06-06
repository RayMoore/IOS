//
//  SecondViewController.m
//  UITabbarController-assignment
//
//  Created by Ray on 07/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"活动" image:[UIImage imageNamed:@"tab_activity"] selectedImage:[UIImage imageNamed:@"tab_activity_select"]];
}
- (IBAction)readMessage:(id)sender {
    self.tabBarItem.badgeValue = nil;
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
