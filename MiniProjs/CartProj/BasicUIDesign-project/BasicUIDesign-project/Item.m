//
//  Item.m
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "Item.h"
#import <UIKit/UIKit.h>

@interface Item ()

@end
@implementation Item

- (instancetype)initWithName:(NSString*) itemName andPrice:(CGFloat) price andTax:(CGFloat) tax andPic:(NSString*)picPath{
    self = [super init];
    [self setItemDescription:itemName];
    [self setItemPrice:price];
    [self setItemTax:tax];
    [self setPicURL:picPath];
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    
    Item *myItem = [[Item allocWithZone:zone] initWithName:self.itemDescription andPrice:self.itemPrice andTax:self.itemTax andPic:self.picURL];
    return myItem;
}

-(NSUInteger)hash
{
    return self.itemDescription.hash;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:self.class] && [((Item *)object).itemDescription isEqualToString:self.itemDescription])
    {
        return YES;
    }
    return NO;
}



@end
