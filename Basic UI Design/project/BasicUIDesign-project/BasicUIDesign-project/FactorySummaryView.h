//
//  FactorySummaryView.h
//  BasicUIDesign-project
//
//  Created by Ray on 09/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactorySummaryView : UITableViewCell
@property (assign,atomic) CGFloat taxInFactory;
@property (assign,atomic) CGFloat sumInFactory;
@property (weak, nonatomic) IBOutlet UILabel *taxInThisFactoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumInThisFactoryLabel;

@end
