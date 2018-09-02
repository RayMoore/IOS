//
//  Item.h
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Item : NSObject <NSCopying>

@property (strong,nonatomic) NSString* itemDescription;
@property (assign,nonatomic) CGFloat itemPrice;
@property (assign,nonatomic) CGFloat itemTax;
@property (strong,nonatomic) NSString* picURL;

- (instancetype)initWithName:(NSString*) itemName andPrice:(CGFloat) price andTax:(CGFloat) tax andPic:(NSString*)picPath;
@end
