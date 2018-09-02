//
//  CartManager.m
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "CartManager.h"
#import "Factory.h"
@interface CartManager ()

@property (strong, atomic) NSMutableDictionary* factory;

@end

@implementation CartManager

-(instancetype)init{
    self = [super init];
    self.factory = [[NSMutableDictionary alloc]init];
    return self;
}

-(NSMutableDictionary*)getAllFactory{
    return self.factory;
}

-(Factory*)getFactoryByName:(NSString *)factoryName{
    return [self.factory valueForKey:factoryName];
}

-(void)addFactory:(Factory*) factory{
    [self.factory setValue:factory forKey:factory.getFactoryName];
}


-(NSInteger)getTotalItemNumber{
    NSInteger totalNum = 0;
    for(NSString* factoryName in self.factory){
        totalNum += [[self.factory objectForKey:factoryName] getItemNumber];
    }
    return totalNum;
}


@end
