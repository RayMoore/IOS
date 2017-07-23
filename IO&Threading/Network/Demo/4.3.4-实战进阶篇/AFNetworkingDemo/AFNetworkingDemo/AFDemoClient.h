//
//  AFDemoClient.h
//  AFNetworkingDemo
//
//  Created by NetEase on 16/8/31.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFDemoClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
