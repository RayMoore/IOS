//
//  NEPieChartViewController.m
//  QuartzDemo
//
//  Created by Netease on 16/7/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NESnapShotController.h"
#import "NEPieChartView.h"
#import "NEPieChartItem.h"
#import "UIImage+NEKits.h"

@interface NESnapShotController ()

@property (nonatomic, strong) NEPieChartView *pieChart;
@property (nonatomic, strong) UIButton *snapShotBtn;

@end

@implementation NESnapShotController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self addSubView];
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

- (void)addSubView {
    CGFloat circleRadius = 120;
    CGRect rect = CGRectMake(CGRectGetWidth(self.view.frame) / 2.0 - circleRadius, 135, circleRadius * 2, circleRadius * 2);
    self.pieChart = [[NEPieChartView alloc] initWithFrame:rect];
    self.pieChart.radius = 100;
    self.pieChart.innerRadius = 33;
    self.pieChart.clickedRadius = 110;
    self.pieChart.itemList = [self buildTestData];
    self.pieChart.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pieChart];
    
    self.snapShotBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 80, 120, 44)];
    [self.snapShotBtn setTitle:@"截屏" forState:UIControlStateNormal];
    self.snapShotBtn.titleLabel.textColor = [UIColor whiteColor];
    self.snapShotBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.snapShotBtn.layer.cornerRadius = 15;
    self.snapShotBtn.layer.masksToBounds = YES;
    self.snapShotBtn.layer.borderWidth = 1;
    self.snapShotBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.snapShotBtn addTarget:self action:@selector(onClickSnapShotBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.snapShotBtn];
}

// 展示PieChart.
- (NSArray<NEPieChartItem *> *)buildTestData {
    NSMutableArray *itemList = [[NSMutableArray alloc] init];
    
    {
        NEPieChartItem *item = [[NEPieChartItem alloc] init];
        item.name = @"开发";
        item.value = 10;
        item.color = [UIColor colorWithRed:77.0 / 255.0 green:216.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f];
        [itemList addObject:item];
    }
    
    {
        NEPieChartItem *item = [[NEPieChartItem alloc] init];
        item.name = @"测试";
        item.value = 20;
        item.color = [UIColor redColor];
        [itemList addObject:item];
    }
    
    {
        NEPieChartItem *item = [[NEPieChartItem alloc] init];
        item.name = @"产品";
        item.value = 30;
        item.color = [UIColor blueColor];
        [itemList addObject:item];
    }
    
    {
        NEPieChartItem *item = [[NEPieChartItem alloc] init];
        item.name = @"运维";
        item.value = 40;
        item.color = [UIColor purpleColor];
        [itemList addObject:item];
    }
    
    CGFloat sumValue;
    for (NEPieChartItem *item in itemList) {
        sumValue += item.value;
    }
    
    if (sumValue > 0) {
        CGFloat startPercentage = 0;
        for (NEPieChartItem *item in itemList) {
            item.startPercentage = startPercentage;
            item.endPercentage = item.startPercentage + item.value / sumValue;
            startPercentage = item.endPercentage;
        }
    }
    
    return itemList;
}

#pragma mark - Actions

- (void)onClickSnapShotBtn:(id)sender {
    UIImage *image = [UIImage imageFromView:self.pieChart];
    if (nil != image) {
        [self saveImageToPhotos:image];
    }
}

#pragma mark - Save Files to Album 

- (void)saveImageToPhotos:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if (error != nil) {
        msg = @"保存截屏图片失败";
    } else {
        msg = @"保存截屏图片成功";
    }
    
    [self showAlertMessage:@"保存截屏图片"];
}

- (void)showAlertMessage:(NSString *)message {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Save Image Files

- (void)saveImage:(UIImage *)image toCacheFile:(NSString *)fileName {
    if (nil == image || [fileName length] == 0) {
        return;
    }
    
    NSData *data = UIImagePNGRepresentation(image);
    if (data) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filePath = [paths[0] stringByAppendingPathComponent:@"default"];
        if (![fileManager fileExistsAtPath:filePath]) {
            [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        
        NSString *file = [filePath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:file]) {
            [fileManager removeItemAtPath:file error:nil];
        }
        
        NSLog(@"保存文件到%@", file);
        [fileManager createFileAtPath:file contents:data attributes:nil];
    }
}

@end
