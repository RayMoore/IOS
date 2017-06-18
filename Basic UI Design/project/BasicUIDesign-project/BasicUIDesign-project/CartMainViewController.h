//
//  CartMainViewController.h
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* CART_TABLE_VIEW_CELL = @"CartTableViewCell";
static NSString* CART_SECTION_VIEW = @"CartSectionView";
static NSString* FACTORY_SUMMARY_VIEW = @"FactorySummaryView";

@interface CartMainViewController : UIViewController

- (void)sectionAllChoose:(NSInteger)section andSelection:(BOOL)ifChoose;

- (void)updateCellByShowingTaxDetailWithCellIndexPath:(NSIndexPath*)indexPath andIfShowTaxDetail:(BOOL)ifShow;

- (void)cancelCellWithIndexPath:(NSIndexPath*)indexPath;

- (void)chooseCellWithIndexPath:(NSIndexPath*)indexPath;

- (void)updateTotalPrice:(CGFloat)price;

-(void)updateTotalTax:(CGFloat)tax;

@end
