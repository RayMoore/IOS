//
//  CartTableViewCell.h
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "CartMainViewController.h"

static BOOL SHOW_TAX = YES;
static BOOL NOT_SHOW_TAX = NO;

@interface CartTableViewCell : UITableViewCell

-(NSString*)getDescription;

-(void)makeAllChooseBySelection:(BOOL)selection;

-(void)setupWithItem:(Item*)item andAmount:(NSInteger) amount andIndexPath:(NSIndexPath*)indexPath andController:(CartMainViewController*)controller;

-(CGFloat)getTotalTax;

-(CGFloat)getTotalPrice;

-(BOOL)getChooseStatus;

-(BOOL)getShowTaxStatus;

-(void)ignoreImageObserver;

@end
