//
//  NELoginViewController.m
//  TextDemo
//
//  Created by NetEase on 16/7/24.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NELoginViewController.h"

@interface NELoginViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITextField *userNameText;
@property (nonatomic, strong) UITextField *passwordText;

@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UIImageView *userNameImageView;
@property (nonatomic, strong) UIImageView *passwordImageView;
@property (nonatomic, strong) UIView *firstSeperator;
@property (nonatomic, strong) UIView *secondSeperator;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UITableView *tipTableView;
@property (strong, nonatomic) NSMutableArray *tips;
@property (strong, nonatomic) NSArray *suffixes;

@end

@implementation NELoginViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    
    return self;
}

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    _tips = [NSMutableArray array];
    _suffixes = @[@"@163.com",
                  @"@126.com",
                  @"@yeah.net",
                  @"@sina.com",
                  @"@gmail.com",
                  @"@188.com"];
    _tipTableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 64 + 46, CGRectGetWidth(self.view.frame) - 30, 190) style:UITableViewStylePlain];
    _tipTableView.delegate = self;
    _tipTableView.dataSource = self;
    _tipTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tipTableView.backgroundColor = [UIColor whiteColor];
    self.tipTableView.hidden = YES;
    [self.view addSubview:self.tipTableView];
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


#pragma mark - Notifications

- (void)textDidChange:(NSNotification *)notification {
    UITextField *textField = notification.object;
    if (textField == self.userNameText) {
        [self updateTips];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_userNameText == textField) {
        NSLog(@"textFieldShouldBeginEditing");
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_userNameText == textField) {
        NSLog(@"textFieldDidBeginEditing");
        if (textField == _userNameText) {
            [self updateTips];
        }
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
//        NSLog(@"textFieldDidEndEditing");
        _tipTableView.hidden = YES;
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

#pragma mark - Update Tips

- (void)updateTips
{
    NSString *username = _userNameText.text;
    [_tips removeAllObjects];
    
    if (username.length > 0) {
        NSRange atRange = [username rangeOfString:@"@"];
        if (atRange.location == NSNotFound) {
            for (NSString *suffix in _suffixes) {
                [_tips addObject:[NSString stringWithFormat:@"%@%@", username, suffix]];
            }
        } else {
            NSString *name = [[username componentsSeparatedByString:@"@"] objectAtIndex:0];
            NSString *suffix = [[username componentsSeparatedByString:@"@"] objectAtIndex:1];
            if (name.length > 0) {
                suffix = [NSString stringWithFormat:@"@%@", suffix];
                for (NSString *suf in _suffixes) {
                    if ([suf hasPrefix:suffix] && ![suf isEqualToString:suffix]) {
                        [_tips addObject:[NSString stringWithFormat:@"%@%@", name, suf]];
                    }
                }
            }
        }
    }
    
    [_tipTableView setHidden:(_tips.count==0)];
    [_tipTableView reloadData];
    [self adjustHeightOfTableview];
}

- (void)adjustHeightOfTableview {
    CGFloat height = _tipTableView.contentSize.height;
    CGFloat maxHeight = 190.f;
    if (height > maxHeight) {
        height = maxHeight;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _tipTableView.frame;
        frame.size.height = height;
        _tipTableView.frame = frame;
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tips count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"tipCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tipCell"];
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        
        [cell.textLabel setFont:[UIFont systemFontOfSize:16.f]];
        cell.textLabel.textColor = [UIColor colorWithRed:0x33 / 255 green:0x33 / 255 blue:0x33 / 255 alpha:1.0];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        
        UIView *selectBgView = [[UIView alloc] initWithFrame:cell.bounds];
        [selectBgView setBackgroundColor:[UIColor lightGrayColor]];
        [cell setSelectedBackgroundView:selectBgView];
    }
    
    NSString *tip = [_tips objectAtIndex:indexPath.row];
    [cell.textLabel setText:tip];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *tip = [_tips objectAtIndex:indexPath.row];
    [_userNameText setText:tip];
    [_tipTableView setHidden:YES];
    
    [_passwordText becomeFirstResponder];
}

@end
