//
//  CustomTableViewCell.m
//  TableView
//
//  Created by wtndcs on 16/9/2.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    self.contentView.backgroundColor = highlighted? [UIColor yellowColor] : [UIColor whiteColor];
    self.hintLabel.backgroundColor = [UIColor redColor];
    NSLog(@"setHighlighted %@", highlighted ? @"YES" : @"NO");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? [UIColor blueColor] : [UIColor whiteColor];
    self.hintLabel.backgroundColor = [UIColor redColor];
    NSLog(@"setSelected %@", selected ? @"YES" : @"NO");
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.hintLabel.clipsToBounds = YES;
    self.hintLabel.layer.cornerRadius = 10;
    self.msgImgView.image = [UIImage imageNamed:@"mc_asset"];
}

- (void)setupMsgInfo:(MessageInfo *)msgInfo
{
    self.titleLabel.text = msgInfo.title;
    self.detailLabel.text = msgInfo.detail;
    self.hintLabel.text = [NSString stringWithFormat:@"%@", @(msgInfo.hintNum)];
    self.timeLabel.text = msgInfo.timeStr;
}

@end
