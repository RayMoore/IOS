//
//  AddContactViewController.m
//  ContactDemo
//
//  Created by amao on 16/7/18.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextfield;

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加联系人";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onCancel:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(onCancel)])
    {
        [_delegate onCancel];
    }
}

- (IBAction)onSave:(id)sender {
    NSString *name = _nameTextfield.text;
    NSString *mobile = _mobileTextfield.text;
    if ([name length] && [mobile length])
    {
        if (_delegate && [_delegate respondsToSelector:@selector(onAddContact:mobile:)])
        {
            [_delegate onAddContact:name mobile:mobile];
        }
    }
}

@end
