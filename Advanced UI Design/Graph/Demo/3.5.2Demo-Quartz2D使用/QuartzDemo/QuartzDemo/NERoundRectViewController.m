//
//  NERoundRectViewController.m
//  QuartzDemo
//
//  Created by Netease on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NERoundRectViewController.h"
#import "UIImage+NEKits.h"

@interface NERoundRectViewController ()

@property (nonatomic, strong) UIImageView *customImageView;

@end

@implementation NERoundRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
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

- (void)addSubView {
    CGFloat totalWidth = CGRectGetWidth(self.view.bounds);
    CGFloat width = 200;
    CGFloat startX = (totalWidth - width) / 2;
    UIImageView *srcImageView = [[UIImageView alloc] initWithFrame:CGRectMake(startX, 100, width, 300)];
    
    UIImage *image = [UIImage imageNamed:@"Panda"];
    UIImage *rounderImage = [image imageWithRoundedCorner:15 size:srcImageView.bounds.size];
    srcImageView.image = rounderImage;
    
    self.customImageView = srcImageView;
    [self.view addSubview:self.customImageView];
}


@end
