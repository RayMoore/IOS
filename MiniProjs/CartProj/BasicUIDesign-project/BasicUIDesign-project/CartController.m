//
//  CartController.m
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "CartController.h"
#import "CartManager.h"
#import "Item.h"
#import "Factory.h"

@interface CartController ()

@property (strong,atomic) CartManager* manager;

@end

@implementation CartController

-(CartManager*)getManager{
    return self.manager;
}

-(void)removeItem:(Item*)item fromFactory:(NSString*) factoryName{
    [[self.manager getFactoryByName:factoryName]removeItem:item];
}

-(NSMutableDictionary*) setData{
    
    CartManager *manager = [[CartManager alloc]init];
    Item* item1 = [[Item alloc] initWithName:@"Swisse 睡眠片 改善睡眠缓解压力 100粒" andPrice:125.0 andTax:0 andPic:@"item1.jpeg"];
    Item* item2 = [[Item alloc] initWithName:@"2件装 | STREAMLAND 新溪岛 Lemon honey 柠檬蜜 500克/瓶 2017款" andPrice:156.0 andTax:14.2 andPic:@"item2.jpeg"];
    Item* item3 = [[Item alloc] initWithName:@"2件装 | 【墨笔组合】 LAMY 凌美 恒星系列F尖时尚钢笔 荧光紫+黑组合套装" andPrice:189.0 andTax:22.5 andPic:@"item3.jpeg"];
    Factory* fct1 = [[Factory alloc] initWithFactoryName:@"杭州保税1号仓"];
    Factory* fct2 = [[Factory alloc] initWithFactoryName:@"杭州保税5号仓"];
    [fct1 addItem:item1 withItemCount:2];
    [fct1 addItem:item2 withItemCount:1];
    [fct2 addItem:item3 withItemCount:1];
    
    [manager addFactory:fct1];
    [manager addFactory:fct2];
    
    [self setManager:manager];
    
    return [self.manager getAllFactory];
}

-(NSMutableDictionary*)getData{
    return [self.manager getAllFactory];
}


@end
