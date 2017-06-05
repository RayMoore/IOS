//
//  InterestedViewController.m
//  MVC
//
//  Created by wtndcs on 16/7/7.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "InterestedViewController.h"
#import "InterestedItem.h"
#import "InterestedView.h"

@interface InterestedViewController ()

// 感兴趣的Model
@property (nonatomic, strong) NSArray<InterestedItem *> *interestedModels;

// 感兴趣的View
@property (nonatomic, weak) InterestedView *interestedView;

@end

@implementation InterestedViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupInterestedModel];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [self setupInterestedModel];
    }
    
    return self;
}

// 设置感兴趣的Model
- (void)setupInterestedModel
{
    InterestedItem *item0 = [[InterestedItem alloc] init];
    [item0 setupWithBannerTitle:@"超全护眼保健品盘点" bannerImgName:@"protectEye.jpg" subTitle:@"生活家" subImgName:@"homeIcon.jpg"];
    
    InterestedItem *item1 = [[InterestedItem alloc] init];
    [item1 setupWithBannerTitle:@"拯救眼镜党的平价神器" bannerImgName:@"glass.jpg" subTitle:@"三石私物精选" subImgName:@"collection.jpg"];
    
    InterestedItem *item2 = [[InterestedItem alloc] init];
    [item2 setupWithBannerTitle:@"小小神器让自来水也能喝" bannerImgName:@"clearwater.jpg" subTitle:@"生活家" subImgName:@"homeIcon.jpg"];
    
    InterestedItem *item3 = [[InterestedItem alloc] init];
    [item3 setupWithBannerTitle:@"适合孩子吃的零食" bannerImgName:@"food.jpg" subTitle:@"生活家" subImgName:@"homeIcon.jpg"];
    
    self.interestedModels = @[ item0, item1, item2, item3 ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置感兴趣的View
    [self setupInterestedView];
}

- (void)setupInterestedView
{
    // 构造InterestedView
    InterestedView *interestedView = [[NSBundle mainBundle]
                                      loadNibNamed:@"InterestedView"
                                      owner:nil
                                      options:nil][0];
    interestedView.frame = CGRectMake(0, 80, self.view.frame.size.width, 300);
    self.interestedView = interestedView;
    
    // 设置Model数据
    for (int i = 0; i < self.interestedModels.count; i++) {
        InterestedItem *item = self.interestedModels[i];
        [self.interestedView.bannerTitles[i] setText:item.bannerTitle];
        [self.interestedView.bannerImgViews[i] setImage:[UIImage imageNamed:item.bannerImgName]];
        [self.interestedView.iconTitles[i] setText:item.subTitle];
        [self.interestedView.iconImgViews[i] setImage:[UIImage imageNamed:item.subImgName]];
    }
    
    // 添加到self.view上
    [self.view addSubview:self.interestedView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
