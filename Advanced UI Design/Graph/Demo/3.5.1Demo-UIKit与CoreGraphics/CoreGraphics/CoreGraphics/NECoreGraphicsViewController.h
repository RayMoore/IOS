//
//  NECoreGraphicsViewController.h
//  CoreGraphics
//
//  Created by NetEase on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NEViewType) {
    NEViewHeader = 1,
    NEViewRectangle,
    NEViewCircle,
    NEViewEllipse,
    NEViewCurve,
    NEViewTriangle,
};

@interface NECoreGraphicsViewController : UIViewController

@property (nonatomic, assign) NEViewType viewType;

@end
