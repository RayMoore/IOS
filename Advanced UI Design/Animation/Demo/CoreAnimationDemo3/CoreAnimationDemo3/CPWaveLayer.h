//
//  CPWaveLayer.h
//  CoreAnimationDemo3
//
//  Created by Chengyin on 16/7/24.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/**
 *  y=Asin(ωx+φ)+k
 *  A——振幅，当物体作轨迹符合正弦曲线的直线往复运动时，其值为行程的1/2。
 *  (ωx+φ)——相位，反映变量y所处的状态。
 *  φ——初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
 *  k——偏距，反映在坐标系上则为图像的上移或下移。
 *  ω——频率， 控制正弦周期(单位角度内震动的次数)。
 */
@interface CPWaveLayer : CAShapeLayer

@property (nonatomic,assign) CGFloat amplitude; //振幅
@property (nonatomic,assign) CGFloat phase;     //相位
@property (nonatomic,assign) CGFloat frequency; //频率

@end
