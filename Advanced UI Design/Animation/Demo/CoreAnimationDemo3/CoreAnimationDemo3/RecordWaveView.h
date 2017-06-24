//
//  RecordWaveView.h
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/7/24.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordWaveView : UIView

@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) float power;//0 ~ 1

- (void)start;
- (void)stop;
@end
