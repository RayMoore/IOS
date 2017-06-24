//
//  NEDefinitions.h
//  QuartzDemo
//
//  Created by Netease on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#ifndef NEDefinitions_h
#define NEDefinitions_h

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

typedef NS_ENUM(NSInteger, NEDemoType) {
    NEDemoCircleProgress = 1,
    NEDemoPieChart,
    NEDemoScreenShot,
    NEDemoRoundRect
};

#endif /* NEDefinitions_h */
