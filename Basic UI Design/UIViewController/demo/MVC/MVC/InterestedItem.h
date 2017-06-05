//
//  InterestedItem.h
//  MVC
//
//  Created by wtndcs on 16/7/7.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterestedItem : NSObject

@property (nonatomic, strong) NSString *bannerImgName; // 横幅图片名称
@property (nonatomic, strong) NSString *bannerTitle;   // 横幅描述

@property (nonatomic, strong) NSString *subImgName;    // 副标题图片名称
@property (nonatomic, strong) NSString *subTitle;      // 副标题描述

- (void)setupWithBannerTitle:(NSString *)bannerTitle
               bannerImgName:(NSString *)bannerImgName
                    subTitle:(NSString *)subTitle
                  subImgName:(NSString *)subImgName;

@end
