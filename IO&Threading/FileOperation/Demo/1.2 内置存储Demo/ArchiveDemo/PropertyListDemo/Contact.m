//
//  Contact.m
//  PropertyListDemo
//
//  Created by amao on 16/7/18.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _mobile = [aDecoder decodeObjectForKey:@"mobile"];
        
    }
    return self;
}

@end
