//
//  SLDownloadProgressView.h
//  CoreAnimationDemo2
//
//  Created by Chengyin on 16/7/19.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLDownloadProgressView : UIView

@property (nonatomic,assign) float progress; // >= 1，时自动显示成功
@property (nonatomic,readonly) BOOL finished; //是否已经进入完成状态（成功/失败）

- (void)failed;//下载失败，显示失败
- (void)reset;//重置
@end
