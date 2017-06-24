//
//  RLActivityIndicatorView.h
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/18.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLActivityIndicatorView : UIView

@property (nonatomic,strong) UIColor *color;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;
@end
