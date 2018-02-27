//
//  SystemManagerViewController.m
//  StudentInfoManagementSystem
//
//  Created by Ray on 26/07/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "SystemManagerViewController.h"
#import "TabbarViewController.h"

@interface SystemManagerViewController ()

@end

@implementation SystemManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)add:(id)sender{

}
- (IBAction)checkDetail:(id)sender{
    
    TabbarViewController *tabViewController = [[TabbarViewController alloc] init];
    [self.navigationController pushViewController:tabViewController animated:NO];
    
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
