//
//  ImageChangeObserver.h
//  BasicUIDesign-project
//
//  Created by Ray on 14/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartMainViewController.h"

@interface ImageChangeObserver : NSObject

- (instancetype)initWithIndexPath:(NSIndexPath*)indexPath andController:(CartMainViewController*)controller;

@end
