//
//  FactorySummaryView.h
//  BasicUIDesign-project
//
//  Created by Ray on 09/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartMainViewController.h"

@interface FactorySummaryView : UITableViewCell

-(void)setSummaryViewPrice:(CGFloat)price andTax:(CGFloat)tax;

-(void)substractPrice:(CGFloat)price andTax:(CGFloat)tax;

-(void)addPrice:(CGFloat)price andTax:(CGFloat)tax;

-(void)getFactorySummaryDetail;

//-(void)ignoreCheckoutObserver;

-(void)setupWithController:(CartMainViewController*)controller;

@end
