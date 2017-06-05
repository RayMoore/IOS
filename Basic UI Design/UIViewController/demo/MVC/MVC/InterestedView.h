//
//  InterestedView.h
//  MVC
//
//  Created by wtndcs on 16/7/7.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterestedView : UIView

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *bannerImgViews;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *bannerTitles;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *iconImgViews;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *iconTitles;

@end
