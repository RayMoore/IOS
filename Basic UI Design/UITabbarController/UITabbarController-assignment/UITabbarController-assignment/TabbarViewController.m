//
//  TabbarViewController.m
//  UITabbarController-assignment
//
//  Created by Ray on 07/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "TabbarViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    

    tabBarItem1.image = [UIImage imageNamed:@"tab_home"];
    tabBarItem2.image = [UIImage imageNamed:@"tab_activity"];
    tabBarItem3.image = [UIImage imageNamed:@"tab_sort"];
    tabBarItem4.image =[UIImage imageNamed:@"tab_cart"];
    tabBarItem5.image =[UIImage imageNamed:@"tab_mine"];
    tabBarItem1.selectedImage = [UIImage imageNamed:@"tab_home_select"];
    tabBarItem2.selectedImage = [UIImage imageNamed:@"tab_activity_select"];
    tabBarItem3.selectedImage = [UIImage imageNamed:@"tab_sort_select"];
    tabBarItem4.selectedImage =[UIImage imageNamed:@"tab_cart_select"];
    tabBarItem5.selectedImage =[UIImage imageNamed:@"tab_mine_select"];
    tabBarItem1.title = @"首页";
    tabBarItem2.title = @"活动";
    tabBarItem3.title = @"分类";
    tabBarItem4.title = @"购物车";
    tabBarItem5.title = @"我的考拉";
    for (NSInteger i=0; i<5; i++) {
        UITabBarItem *item = [tabBar.items objectAtIndex:i];
        item.titlePositionAdjustment = UIOffsetMake(0, -5);
        if(i==1){
            item.badgeColor = [UIColor redColor];
            item.badgeValue = @"10";
        }
    }

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
