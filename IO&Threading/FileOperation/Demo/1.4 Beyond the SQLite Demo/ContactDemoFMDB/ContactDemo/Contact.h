//
//  Contact.h
//  ContactDemo
//
//  Created by amao on 16/7/18.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject
@property (nonatomic,assign)    int64_t     serialId;
@property (nonatomic,copy)      NSString    *name;
@property (nonatomic,copy)      NSString    *mobile;
@end
