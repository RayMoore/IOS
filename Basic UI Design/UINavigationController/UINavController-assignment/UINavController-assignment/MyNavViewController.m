//
//  MyNavViewController.m
//  UINavController-assignment
//
//  Created by Ray on 06/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "MyNavViewController.h"
#import "HomepageViewController.h"

@interface MyNavViewController ()

@end

@implementation MyNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HomepageViewController* homepage = [[HomepageViewController alloc]init];
    [self initWithRootViewController:homepage];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
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
