//
//  CartSectionView.h
//  BasicUIDesign-project
//
//  Created by Ray on 09/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartMainViewController.h"

static BOOL CHOOSE = YES;
static BOOL NOT_CHOOSE = NO;
static NSString* CHOOSE_IMG = @"choose";
static NSString* NOT_CHOOSE_IMG = @"circle";

@interface CartSectionView : UITableViewCell

-(void)setAddressLabelName:(NSString*) name andMainController:(CartMainViewController*)controller;
-(BOOL)getChooseStatus;
-(void)setSection:(NSInteger)section;

@end
