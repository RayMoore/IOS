//
//  NavStatistic.m
//  NavAction
//
//  Created by wtndcs on 16/8/7.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NavStatistic.h"

@interface NavStatistic ()

@property (nonatomic, assign) NSInteger currentCount;

@property (nonatomic, weak) UIViewController *currentPage;

@property (nonatomic, assign) NSTimeInterval currentShowTime;

@end

@implementation NavStatistic

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL isPush = NO;
    if (navigationController.viewControllers.count > self.currentCount) {
        isPush = YES;
    }
    if (isPush) {
        if (self.currentPage) {
            NSLog(@"首次展示页面：%@ 来自 %@", NSStringFromClass([viewController class]), NSStringFromClass([self.currentPage class]));
        }
        else {
            NSLog(@"首次展示页面：%@", NSStringFromClass([viewController class]));
        }
    }
    if (self.currentPage) {
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval duration = currentTime - self.currentShowTime;
        NSLog(@"页面 %@ 展示时长 %f", NSStringFromClass([self.currentPage class]), duration);
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.currentCount = [navigationController.viewControllers count];
    self.currentPage = viewController;
    self.currentShowTime = [[NSDate date] timeIntervalSince1970];
}

@end
