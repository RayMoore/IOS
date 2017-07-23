//
//  AddContactViewController.h
//  PropertyListDemo
//
//  Created by amao on 16/7/13.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddContactDelegate <NSObject>
- (void)onAddContact:(NSDictionary *)dict;
- (void)onCancel;
@end

@interface AddContactViewController : UIViewController
@property (nonatomic,weak)  id<AddContactDelegate>  delegate;
@end
