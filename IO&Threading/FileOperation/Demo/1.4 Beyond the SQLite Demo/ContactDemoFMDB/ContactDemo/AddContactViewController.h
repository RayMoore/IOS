//
//  AddContactViewController.h
//  ContactDemo
//
//  Created by amao on 16/7/18.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol AddContactDelegate <NSObject>
- (void)onAddContact:(Contact *)contact;
- (void)onCancel;
@end

@interface AddContactViewController : UIViewController
@property (nonatomic,weak)  id<AddContactDelegate>  delegate;
@end
