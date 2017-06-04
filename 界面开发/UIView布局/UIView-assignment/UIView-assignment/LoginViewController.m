//
//  LoginViewController.m
//  UIView-assignment
//
//  Created by Ray on 04/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "LoginViewController.h"
#import "BlogViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *accountViewBg;
@property (weak, nonatomic) IBOutlet UITextField *accountViewTextField;
@property (weak, nonatomic) IBOutlet UIImageView *pwdViewBg;
@property (weak, nonatomic) IBOutlet UITextField *pwdViewTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *loginInfoIcon;
@property (weak, nonatomic) IBOutlet UILabel *loginInfoMsg;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginIndicator;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage* bgImage = [_accountViewBg.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22) resizingMode:UIImageResizingModeStretch];
    [_accountViewBg setImage:bgImage];
    [_pwdViewBg setImage:bgImage];
    
    UIImage* btnBgImage = [[UIImage imageNamed:@"button-green"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [_loginBtn setBackgroundImage:btnBgImage forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:btnBgImage forState:UIControlStateHighlighted];
    [_loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginInfoMsg setHidden:YES];
    [_loginInfoIcon setHidden:YES];
    [_loginIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginBtnClicked{
    [_loginBtn setEnabled:NO];
    [_loginIndicator startAnimating];
    [_loginIndicator setAlpha:0.5f];
    [UIView animateWithDuration:1.f animations:^{
        [_loginIndicator setAlpha:1.f];
    }completion:^(BOOL finished){
        [self.view endEditing:YES];
        NSString* errorMsg = @"";
        NSString* account = _accountViewTextField.text;
        NSString* pwd = _pwdViewTextField.text;
        if([@"admin" isEqualToString:account]&&[@"test" isEqualToString:pwd]){
        //login successfully
        [_loginInfoMsg setHidden:YES];
        [_loginInfoIcon setHidden:YES];
        [self showBlogView];
        [_loginIndicator stopAnimating];
        
        }else{
        //login failed
        if(account.length == 0){
            errorMsg = @"请输入用户名";
        }else if(pwd.length == 0){
            errorMsg = @"请输入密码";
        }else{
            //account name didn't match pwd
            errorMsg = @"用户名或密码输入有误";
        }
        [_loginIndicator stopAnimating];
        [_loginInfoMsg setText:errorMsg];
        [_loginInfoIcon setHidden:NO];
        [_loginInfoMsg setHidden:NO];
        }
        [_loginBtn setEnabled:YES];
    
    }];
}

- (void) showBlogView{
    BlogViewController* blogView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"blogViewController"];
    [self presentViewController:blogView animated:YES completion:nil];
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
