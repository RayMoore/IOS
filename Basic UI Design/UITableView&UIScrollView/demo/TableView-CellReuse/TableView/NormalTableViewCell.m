//
//  NormalTableViewCell.m
//  TableView
//
//  Created by wtndcs on 16/9/10.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NormalTableViewCell.h"

@implementation NormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    //NSLog(@"initWithStyle For Normal Cell");
    
    return self;
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self  = [super initWithCoder:aDecoder];
    
    //NSLog(@"initWithCoder For Normal Cell");
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
