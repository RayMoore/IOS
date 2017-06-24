//
//  NELoginViewController.m
//  TextDemo
//
//  Created by NetEase on 16/7/24.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NELoginInputViewController.h"

@interface NELoginInputViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UITextField *userNameText;
@property (nonatomic, strong) UITextField *passwordText;

@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UIImageView *userNameImageView;
@property (nonatomic, strong) UIImageView *passwordImageView;
@property (nonatomic, strong) UIView *firstSeperator;
@property (nonatomic, strong) UIView *secondSeperator;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIPickerView *namePickerView;
@property (nonatomic, strong) NSArray *nameList;

@end

@implementation NELoginInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.inputView];
    [self.view addSubview:self.loginBtn];
    [self.inputView addSubview:self.userNameImageView];
    [self.inputView addSubview:self.passwordImageView];
    [self.inputView addSubview:self.userNameText];
    [self.inputView addSubview:self.passwordText];
    [self.inputView addSubview:self.firstSeperator];
    [self.inputView addSubview:self.secondSeperator];
    
    _nameList = @[@"test1", @"test2", @"test3", @"test4", @"test5", @"test6"];
    _namePickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _namePickerView.delegate = self;
    _namePickerView.dataSource = self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Text Fields

- (UITextField *)userNameText {
    if (nil == _userNameText) {
        _userNameText = [[UITextField alloc] initWithFrame:CGRectMake(43, 0, CGRectGetWidth(self.view.frame) - 43 - 12, 45)];
        _userNameText.placeholder = @"用户名/邮箱/手机号";
        _userNameText.font = [UIFont systemFontOfSize:16.0];
        _userNameText.minimumFontSize = 12.0;
        _userNameText.adjustsFontSizeToFitWidth = YES;
        _userNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameText.returnKeyType = UIReturnKeyNext;
        _userNameText.delegate = self;
    }
    
    return _userNameText;
}

- (UITextField *)passwordText {
    if (nil == _passwordText) {
        _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(43, 45, CGRectGetWidth(self.view.frame) - 43 - 12, 45)];
        _passwordText.placeholder = @"密码";
        _passwordText.font = [UIFont systemFontOfSize:16.0];
        _passwordText.textAlignment = NSTextAlignmentLeft;
        _passwordText.borderStyle = UITextBorderStyleNone;
        _passwordText.minimumFontSize = 12.0;
        _passwordText.adjustsFontSizeToFitWidth = YES;
        _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordText.secureTextEntry = YES;
        _passwordText.returnKeyType = UIReturnKeyDone;
        _passwordText.delegate = self;
    }
    
    return _passwordText;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_userNameText == textField) {
        NSLog(@"textFieldShouldBeginEditing");
        _userNameText.inputView = self.namePickerView;
        _userNameText.text = [self selectedName];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_userNameText == textField) {
        NSLog(@"textFieldDidBeginEditing");
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (_userNameText == textField) {
        NSLog(@"textFieldShouldEndEditing");
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_userNameText == textField) {
        NSLog(@"textFieldDidEndEditing");
        textField.text = [self selectedName];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_userNameText == textField) {
        NSLog(@"shouldChangeCharactersInRange");
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_userNameText == textField) {
        [_passwordText becomeFirstResponder];
    } else if (_passwordText == textField) {
        [self onLogin:textField];
    }
    
    return NO;
}

#pragma mark - Getter / Setter Other Subviews

- (UIView *)inputView {
    if (nil == _inputView) {
        _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 90)];
    }
    
    return _inputView;
}

- (UIView *)firstSeperator {
    if (nil == _firstSeperator) {
        _firstSeperator = [[UIView alloc] initWithFrame:CGRectMake(15, 45, CGRectGetWidth(self.view.frame), 1)];
        _firstSeperator.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _firstSeperator;
}

- (UIView *)secondSeperator {
    if (nil == _secondSeperator) {
        _secondSeperator = [[UIView alloc] initWithFrame:CGRectMake(0, 45 * 2, CGRectGetWidth(self.view.frame), 1)];
        _secondSeperator.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _secondSeperator;
}

- (UIImageView *)userNameImageView {
    if (nil == _userNameImageView) {
        _userNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 13, 20, 20)];
        _userNameImageView.image = [UIImage imageNamed:@"login_logo"];
    }
    
    return _userNameImageView;
}

- (UIImageView *)passwordImageView {
    if (nil == _passwordImageView) {
        _passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 58, 20, 20)];
        _passwordImageView.image = [UIImage imageNamed:@"login_password"];
    }
    
    return _passwordImageView;
}

- (UIButton *)loginBtn {
    if (nil == _loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 105 + 64 + 20, CGRectGetWidth(self.view.frame) - 60 * 2, 40)];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _loginBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _loginBtn.layer.cornerRadius = 5.0;
        _loginBtn.layer.borderWidth = 1.0;
        [_loginBtn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _loginBtn;
}

#pragma mark - Actions

- (IBAction)onLogin:(id)sender {
    [self.view endEditing:YES];
    
    NSString *alertMsg = [NSString stringWithFormat:@"登录用户名: %@, 密码: %@", self.userNameText.text, self.passwordText.text];
    [self showAlertMessage:alertMsg];
}

- (IBAction)onBtnClicked:(id)sender {
    [self onLogin:sender];
}

#pragma mark - Show Alert Messages

- (void)showAlertMessage:(NSString *)message {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark -

- (NSString *)selectedName {
    NSInteger index = [_namePickerView selectedRowInComponent:0];
    return index < [_nameList count] ? [_nameList objectAtIndex:index] : @"";
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_nameList count];
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_nameList objectAtIndex:row];
}

@end
