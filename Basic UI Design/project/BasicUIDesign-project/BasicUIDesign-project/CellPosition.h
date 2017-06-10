//
//  CellPosition.h
//  BasicUIDesign-project
//
//  Created by Ray on 10/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellPosition : NSObject <NSCopying>
- (instancetype)initWithSection:(NSInteger)section andRow:(NSInteger)row;
@end
