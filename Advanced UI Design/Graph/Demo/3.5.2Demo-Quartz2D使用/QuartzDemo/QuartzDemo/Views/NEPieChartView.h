//
//  NEPieChartView.h
//  QuartzDemo
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NEPieChartItem;

@interface NEPieChartView : UIView

/**
 *  要展示的数据.
 */
@property (nonatomic, strong) NSArray<NEPieChartItem *> *itemList;

/**
 *  界面的配置
 */
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat innerRadius;
@property (nonatomic, assign) CGFloat clickedRadius;
@property (nonatomic, assign) CGFloat sliceSpace;

@end
