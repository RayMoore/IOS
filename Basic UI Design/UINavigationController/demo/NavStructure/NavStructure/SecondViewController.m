//
//  SecondViewController.m
//  NavStructure
//
//  Created by wtndcs on 16/7/27.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "SecondViewController.h"
#import "LastViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Second Vc";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoLast:(id)sender
{
    LastViewController *last = [[LastViewController alloc] init];
    [self.navigationController pushViewController:last animated:YES];

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
