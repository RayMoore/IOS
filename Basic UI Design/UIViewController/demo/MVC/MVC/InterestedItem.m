//
//  InterestedItem.m
//  MVC
//
//  Created by wtndcs on 16/7/7.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "InterestedItem.h"

@implementation InterestedItem

- (void)setupWithBannerTitle:(NSString *)bannerTitle
               bannerImgName:(NSString *)bannerImgName
                    subTitle:(NSString *)subTitle
                  subImgName:(NSString *)subImgName
{
    self.bannerTitle = bannerTitle;
    self.bannerImgName = bannerImgName;
    self.subTitle = subTitle;
    self.subImgName = subImgName;
}

@end
