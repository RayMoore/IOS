//
//  ViewController.m
//  GCDDownloadImageDemo
//
//  Created by amao on 16/8/15.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) dispatch_queue_t queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _queue = dispatch_queue_create("com.netease.study.imageloader", 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    
    dispatch_async(_queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2014/09/23/21/23/iphone-6-458159_960_720.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });
}

@end
