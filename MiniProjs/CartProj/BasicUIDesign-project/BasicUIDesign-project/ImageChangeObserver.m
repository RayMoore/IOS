//
//  ImageChangeObserver.m
//  BasicUIDesign-project
//
//  Created by Ray on 14/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "ImageChangeObserver.h"
#import "CartSectionView.h"


@interface ImageChangeObserver()
@property (strong,nonatomic)  NSIndexPath*indexPath;
@property (strong,atomic) CartMainViewController*controller;
@end


@implementation ImageChangeObserver

- (instancetype)initWithIndexPath:(NSIndexPath*)parentIndexPath andController:(CartMainViewController *)parentController{
    self = [super init];
    self.indexPath = parentIndexPath;
    self.controller = parentController;
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    BOOL oldValue = [[change objectForKey:NSKeyValueChangeOldKey] integerValue] == 1?YES:NO;
    BOOL newValue = [[change objectForKey:NSKeyValueChangeNewKey] integerValue] == 1?YES:NO;
    
    if(oldValue == CHOOSE && newValue == NOT_CHOOSE){
        [self.controller cancelCellWithIndexPath:self.indexPath];
    }else if(oldValue == NOT_CHOOSE && newValue == YES){
        [self.controller chooseCellWithIndexPath:self.indexPath];
    }else{
        // oldValue == newValue
        // ignore
        return;
    }
}

@end


