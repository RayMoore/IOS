//
//  AddContactViewController.h
//  ContactDemo
//
//  Created by amao on 16/7/18.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact+CoreDataProperties.h"

@protocol AddContactDelegate <NSObject>
- (void)onAddContact:(NSString *)name
              mobile:(NSString *)mobile;
- (void)onCancel;
@end

@interface AddContactViewController : UIViewController
@property (nonatomic,weak)  id<AddContactDelegate>  delegate;
@end
