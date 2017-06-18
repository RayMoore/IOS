//
//  Factory.h
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"


@interface Factory : NSObject <NSCopying>

-(instancetype)initWithFactoryName:(NSString *) name;

- (void)addItem:(Item*) item withItemCount:(NSInteger) count;

- (NSInteger)getItemNumber;

-(NSString*)getFactoryName;

-(NSMutableDictionary*)getItems;

- (void)removeItem:(Item*) item;

- (CGFloat)getItemTotalPriceInFactory;

- (CGFloat)getItemTotalTaxInFactory;

- (CGFloat)getItemTotalPriceIncludingTaxInFactory;

@end
