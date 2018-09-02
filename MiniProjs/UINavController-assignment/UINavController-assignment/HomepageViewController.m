//
//  HomepageViewController.m
//  UINavController-assignment
//
//  Created by Ray on 06/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "HomepageViewController.h"
#import "H5ViewController.h"

@interface HomepageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *gotoH5Label;
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (assign,nonatomic) CGFloat marginSpace;
@property (assign,nonatomic) CGFloat navImageWidth;

@end

@implementation HomepageViewController

- (void)updateSearchBarWithImageWidth:(CGFloat)imageWidth andMargin:(CGFloat)marginSpace{
    [_titleView setHidden:YES];
    // Get the width and height of navigation bar
    CGRect rectNav = self.navigationController.navigationBar.frame;
    CGFloat navWidth = rectNav.size.width;// width
    CGFloat navHeight = rectNav.size.height;// height
    CGFloat topMargin = 0.15 * navHeight;
    CGFloat searchBarHeight = navHeight - 2 * topMargin;
    CGFloat searchBarWidth = navWidth - 2 * (2 * marginSpace + imageWidth);
    [_titleView setFrame:CGRectMake(0, 0, searchBarWidth, searchBarHeight)];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateSearchBarWithImageWidth:_navImageWidth andMargin:_marginSpace];

}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_titleView setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.titleView = _titleView;
    
    UIBarButtonItem* leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    leftSpace.width = -5;
    UIBarButtonItem* rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    rightSpace.width = 5;
    UIBarButtonItem* leftScan = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"scan"] style:UIBarButtonItemStylePlain target:self action:@selector(scan)];
    UIBarButtonItem* rightMsg = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStylePlain target:self action:@selector(getMessage)];
    
    [_titleView setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.leftBarButtonItems = @[leftSpace,leftScan];
    self.navigationItem.rightBarButtonItems = @[rightMsg,rightSpace];
    _marginSpace = leftSpace.width;
    _navImageWidth = leftScan.width;
    
    //hide nav bar when swipe or tap on screen
    self.navigationController.hidesBarsOnSwipe = YES;
    self.navigationController.hidesBarsOnTap = YES;
    
    UITapGestureRecognizer *gestureGotoH5=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoH5)];
    _gotoH5Label.userInteractionEnabled=YES;
    [_gotoH5Label addGestureRecognizer:gestureGotoH5];
    
}

- (void)showMessageWithTitle:(NSString*)title andMessage:(NSString*)msg{
    UIAlertController *messageAlertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    
    [messageAlertController addAction:cancelAction];
    [messageAlertController addAction:okAction];
    [self presentViewController:messageAlertController animated:YES completion:nil];
}
- (void)scan{
    [self showMessageWithTitle:@"Scanning" andMessage:@"using camera..."];
}
- (void)getMessage{
    [self showMessageWithTitle:@"Message" andMessage:@"checking messages..."];
}

- (void)gotoH5{
    if([_searchBar isEditing]){
        [_searchBar endEditing:YES];
    }
    H5ViewController* H5 = [[H5ViewController alloc]init];
    [self.navigationController pushViewController:H5 animated:YES];
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
