//
//  MessageInfo.h
//  TableView
//
//  Created by wtndcs on 16/9/2.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageInfo : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *detail;

@property (nonatomic, strong) NSString *timeStr;

@property (nonatomic, assign) NSInteger hintNum;

@end
