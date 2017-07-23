//
//  SDWebImageDemoController.m
//  SDWebImageDemo
//
//  Created by Netease on 16/8/31.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "SDWebImageDemoController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface SDWebImageDemoController ()

@property (nonatomic, strong) UIImageView *headerImageView;

@end


NSString * const kImageFileURL = @"http://posttestserver.com/files/2016/11/27/f_17.43.112127782985";

//NSString * const kImageFileURL = @"http://posttestserver.com/files/2016/08/30/f_21.48.332024410400";

@implementation SDWebImageDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 150, 200)];
    self.headerImageView.backgroundColor = [UIColor lightGrayColor];
    self.headerImageView.layer.borderWidth = 1.0;
    self.headerImageView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:self.headerImageView];
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:kImageFileURL] placeholderImage:[UIImage imageNamed:@"test.jpg"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"receivedSize: %@, total Size : %@, progress : %@", @(receivedSize), @(expectedSize), expectedSize != 0 ? @(100.0 * receivedSize / expectedSize) : @(100));
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
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
