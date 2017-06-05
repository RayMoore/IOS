//
//  CustomTableViewCell.h
//  TableView
//
//  Created by wtndcs on 16/9/2.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageInfo.h"

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *msgImgView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *detailLabel;

@property (nonatomic, weak) IBOutlet UILabel *hintLabel;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

- (void)setupMsgInfo:(MessageInfo *)msgInfo;

@end
