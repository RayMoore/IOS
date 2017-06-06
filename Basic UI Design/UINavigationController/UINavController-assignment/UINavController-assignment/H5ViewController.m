//
//  H5ViewController.m
//  UINavController-assignment
//
//  Created by Ray on 06/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "H5ViewController.h"

@interface H5ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic,strong) id<UIGestureRecognizerDelegate> originDelegate;

@end

@implementation H5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"美食-饮料清仓专场";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem* leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    leftSpace.width = -5;
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
    UIBarButtonItem* leftBackItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    UIBarButtonItem* leftCloseItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    UIBarButtonItem* rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    rightSpace.width = 5;
    UIBarButtonItem* rightShare = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.leftBarButtonItems = @[leftSpace,leftBackItem,leftCloseItem];
    self.navigationItem.rightBarButtonItems = @[rightShare,rightSpace];
    
    
    //hide nav bar when swipe or tap on screen
    self.navigationController.hidesBarsOnSwipe = YES;
    self.navigationController.hidesBarsOnTap = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.originDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = _originDelegate;
    _originDelegate = nil;
}


- (void)share{
    UIAlertController *shareAlertController = [UIAlertController alertControllerWithTitle:@"Sharing" message:@"share this page." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    
    [shareAlertController addAction:cancelAction];
    [shareAlertController addAction:okAction];
    [self presentViewController:shareAlertController animated:YES completion:nil];
}

- (void)closeView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goback{
    [self.navigationController popViewControllerAnimated:YES];
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
