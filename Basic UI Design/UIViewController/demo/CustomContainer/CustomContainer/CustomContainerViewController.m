//
//  CustomContainerViewController.m
//  MVC
//
//  Created by wtndcs on 16/6/26.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "CustomContainerViewController.h"
#import "SortViewController.h"
#import "BrandViewController.h"

@interface CustomContainerViewController ()

@property (nonatomic, strong) SortViewController *sortVc;

@property (nonatomic, strong) BrandViewController *brandVc;

@end

@implementation CustomContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self changeToSortVc];
}

- (IBAction)clickSortBtn:(id)sender
{
    [self changeToSortVc];
}

- (IBAction)clickBrandBtn:(id)sender
{
    [self changeToBrandVc];
}

- (void)changeToSortVc
{
    if (self.brandVc) {
        [self removeChildVc:self.brandVc];
    }
    self.brandHintView.hidden = YES;
    
    if (!self.sortVc) {
        self.sortVc = [[SortViewController alloc] init];
    }
    [self addChildVc:self.sortVc view:self.containerView];
    self.sortHintView.hidden = NO;
}

- (void)changeToBrandVc
{
    if (self.sortVc) {
        [self removeChildVc:self.sortVc];
    }
    self.sortHintView.hidden = YES;
    
    if (!self.brandVc) {
        self.brandVc = [[BrandViewController alloc] init];
    }
    [self addChildVc:self.brandVc view:self.containerView];
    self.brandHintView.hidden = NO;
}

#pragma mark - Add / Remove Child vc

- (void)addChildVc:(UIViewController*)vc
{
    [self addChildVc:vc view:self.view];
}

- (void)addChildVc:(UIViewController*)vc view:(UIView *)view
{
    BOOL needAddToParent = !vc.parentViewController;
    if (needAddToParent) [self addChildViewController:vc];
    vc.view.frame = view.bounds;
    [view addSubview:vc.view];
    if (needAddToParent) [vc didMoveToParentViewController:self];
}

- (void)removeChildVc:(UIViewController*)vc
{
    [vc willMoveToParentViewController:nil];
    if (![vc isViewLoaded]) {
        [vc removeFromParentViewController];
    }
    else {
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}

@end
