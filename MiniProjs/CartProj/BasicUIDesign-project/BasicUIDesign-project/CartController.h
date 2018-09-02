//
//  CartController.h
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartManager.h"

@interface CartController : NSObject

-(CartManager*)getManager;
-(NSMutableDictionary*)getData;
-(NSMutableDictionary*)setData;
-(void)removeItem:(Item*)item fromFactory:(NSString*) factoryName;

@end
