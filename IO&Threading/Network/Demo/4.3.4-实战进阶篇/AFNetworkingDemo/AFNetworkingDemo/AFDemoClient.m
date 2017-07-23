//
//  AFDemoClient.m
//  AFNetworkingDemo
//
//  Created by NetEase on 16/8/31.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "AFDemoClient.h"

static NSString * const AFDemoBaseURLString = @"http://putsreq.com/";

@implementation AFDemoClient

+ (instancetype)sharedClient {
    static AFDemoClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFDemoClient alloc] initWithBaseURL:[NSURL URLWithString:AFDemoBaseURLString]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _sharedClient;
}

@end
