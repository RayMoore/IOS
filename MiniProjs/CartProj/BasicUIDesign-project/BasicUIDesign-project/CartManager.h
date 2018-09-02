//
//  CartManager.h
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Factory.h"

@interface CartManager : NSObject

-(Factory*)getFactoryByName:(NSString*)factoryName;
-(void)addFactory:(Factory*) factory;
-(NSInteger)getTotalItemNumber;
-(NSMutableDictionary*)getAllFactory;

@end
