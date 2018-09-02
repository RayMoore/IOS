//
//  CellPosition.m
//  BasicUIDesign-project
//
//  Created by Ray on 10/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "CellPosition.h"
@interface CellPosition()
@property (assign,nonatomic) NSInteger section;
@property (assign,nonatomic) NSInteger row;

@end


@implementation CellPosition

- (instancetype)initWithSection:(NSInteger)section andRow:(NSInteger)row{
    self = [super init];
    self.section = section;
    self.row = row;
    return self;
}
- (id)copyWithZone:(NSZone *)zone{
    
    CellPosition *pos = [[CellPosition allocWithZone:zone] initWithSection:self.section andRow:self.row];
    return pos;
}

-(NSUInteger)hash
{
    NSNumber *num = [[NSNumber alloc] initWithInt:(int)self.section];
    return num.hash;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:self.class])
    {
        CellPosition *temp = (CellPosition*)object;
        if(temp.section == self.section && temp.row == self.row){
            return YES;
        }
        return NO;
    }
    return NO;
}



@end
