//
//  Factory.m
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "Factory.h"
#import "Item.h"
@interface Factory ()
@property (strong,nonatomic) NSString* factoryName;
@property (strong,atomic) NSMutableDictionary* items;
@property (assign,atomic) CGFloat itemTotalPriceInFactory;
@property (assign,atomic) CGFloat itemTotalTaxInFactory;

@end

@implementation Factory

-(NSString*)getFactoryName{
    return self.factoryName;
}

-(NSMutableDictionary*)getItems{
    return self.items;
}

-(instancetype)initWithFactoryName:(NSString *) name{
    self = [super init];
    [self setFactoryName:name];
    self.items = [[NSMutableDictionary alloc] init];
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    Factory *myFactory = [[Factory allocWithZone:zone] initWithFactoryName:self.factoryName];
    return myFactory;
}


-(NSUInteger)hash
{
    return self.factoryName.hash;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:self.class] && [((Factory *)object).factoryName isEqualToString:self.factoryName])
    {
        return YES;
    }
    return NO;
}

- (NSInteger)getItemNumber{
    return self.items.count;
}

- (void)addItem:(Item*) item withItemCount:(NSInteger) count{
    [self.items setObject:[NSNumber numberWithInteger:count] forKey:item];
    self.itemTotalTaxInFactory += item.itemTax * count;
    self.itemTotalPriceInFactory += item.itemPrice * count;
}

- (void)removeItem:(Item*) item{
    NSInteger count = [[self.items objectForKey:item] integerValue];
    self.itemTotalTaxInFactory -= item.itemTax * count;
    self.itemTotalPriceInFactory -= item.itemPrice * count;
    [self.items removeObjectForKey:item];
}

- (CGFloat)getItemTotalTaxInFactory{
    return self.itemTotalTaxInFactory;
}

- (CGFloat)getItemTotalPriceInFactory{
    return self.itemTotalPriceInFactory;
}


- (CGFloat)getItemTotalPriceIncludingTaxInFactory{
    return self.itemTotalPriceInFactory + self.itemTotalTaxInFactory;
}


@end
