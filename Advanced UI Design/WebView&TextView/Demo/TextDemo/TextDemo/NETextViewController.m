//
//  NETextViewController.m
//  TextDemo
//
//  Created by NetEase on 16/7/21.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NETextViewController.h"

@interface NETextViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *addressView;
@property (nonatomic, strong) UIView *firstSeperator;
@property (nonatomic, strong) UIView *secondSeperator;

@property (nonatomic, strong) UITextView *addressPlaceholderView;

@end

@implementation NETextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不让UITextView居中.
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.addressView];
    [self.view addSubview:self.addressPlaceholderView];
    [self.view addSubview:self.firstSeperator];
    [self.view addSubview:self.secondSeperator];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification*)notification {
//    self.view.window.backgroundColor = self.view.backgroundColor;
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [(NSValue*)[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [(NSNumber*)[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat height = CGRectGetHeight(keyboardFrame);

    NSNumber *option = (NSNumber *)[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration delay:0 options:option.integerValue animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -height);
    } completion:nil];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:duration];
//    self.view.transform = CGAffineTransformMakeTranslation(0, -height);
//    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    double duration = [(NSNumber*)[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    NSNumber *option = (NSNumber *)[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration delay:0 options:option.integerValue animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:nil];
    
//    [UIView beginAnimations:nil context:nil];
//    
//    [UIView setAnimationDuration:duration];
//    
//    self.view.transform = CGAffineTransformIdentity;
//    
//    [UIView commitAnimations];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView endEditing:YES];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView == self.addressView) {
        _addressPlaceholderView.hidden = ([textView.text length] > 0);
    }
}

- (UITextView *)addressView {
    if (nil == _addressView) {
        _addressView = [[UITextView alloc] initWithFrame:CGRectMake(10, 364, CGRectGetWidth(self.view.frame) - 10 * 2, 300)];
        _addressView.font = [UIFont systemFontOfSize:16];
        _addressView.delegate = self;
    }
    
    return _addressView;
}

- (UITextView *)addressPlaceholderView {
    if (nil == _addressPlaceholderView) {
        _addressPlaceholderView = [[UITextView alloc] initWithFrame:self.addressView.frame];
        _addressPlaceholderView.font = [UIFont systemFontOfSize:16];
        _addressPlaceholderView.text = @"请输入地址";
        _addressPlaceholderView.textColor = [UIColor lightGrayColor];
        _addressPlaceholderView.backgroundColor = [UIColor clearColor];
        _addressPlaceholderView.userInteractionEnabled = NO;
    }

    return _addressPlaceholderView;
}

- (UIView *)firstSeperator {
    if (nil == _firstSeperator) {
        _firstSeperator = [[UIView alloc] initWithFrame:CGRectMake(0, 45 + 300, CGRectGetWidth(self.view.frame), 1)];
        _firstSeperator.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _firstSeperator;
}

- (UIView *)secondSeperator {
    if (nil == _secondSeperator) {
        _secondSeperator = [[UIView alloc] initWithFrame:CGRectMake(0, 364 + 300, CGRectGetWidth(self.view.frame), 1)];
        _secondSeperator.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _secondSeperator;
}

@end
