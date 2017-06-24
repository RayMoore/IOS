//
//  NECoreGraphicsViewController.m
//  CoreGraphics
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NECoreGraphicsViewController.h"
#import "NECircleView.h"
#import "NEEllipseView.h"
#import "NETriagleView.h"
#import "NERectangleView.h"
#import "NEHeaderView.h"

static const NSInteger kTopBarHeight = (20 + 44);

@interface NECoreGraphicsViewController ()

@property (nonatomic, strong) UIView *customView;

@end

@implementation NECoreGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubView];
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


#pragma mark -

- (void)addSubView {
    CGRect rect = CGRectMake(0, kTopBarHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kTopBarHeight);
    switch (_viewType) {
        case NEViewRectangle:
            _customView = [[NERectangleView alloc] initWithFrame:rect];
            break;
            
        case NEViewCircle:
            _customView = [[NECircleView alloc] initWithFrame:rect];
            break;
            
        case NEViewEllipse:
            _customView = [[NEEllipseView alloc] initWithFrame:rect];
            break;
            
        case NEViewTriangle:
            _customView = [[NETriagleView alloc] initWithFrame:rect];
            break;
            
        case NEViewHeader:
            _customView = [[NEHeaderView alloc] initWithFrame:rect];
            
        default:
            break;
    }
    
    _customView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_customView];
}

@end
