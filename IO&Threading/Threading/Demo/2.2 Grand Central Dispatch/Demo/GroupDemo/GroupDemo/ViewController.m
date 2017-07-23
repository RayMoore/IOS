//
//  ViewController.m
//  GroupDemo
//
//  Created by amao on 16/8/15.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)downloadImage:(id)sender {
    
    self.leftImageView.image = nil;
    self.rightImageView.image = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2014/09/23/21/23/iphone-6-458159_960_720.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.leftImageView.image = image;
        });

    });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2014/09/23/21/23/iphone-6-458159_960_720.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.rightImageView.image = image;
        });
        
    });
}


- (IBAction)groupDownloadImage:(id)sender {
    
    self.leftImageView.image = nil;
    self.rightImageView.image = nil;
    
    dispatch_group_t group = dispatch_group_create();
    __block UIImage *left,*right = nil;
    
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2014/09/23/21/23/iphone-6-458159_960_720.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        left = [UIImage imageWithData:data];

    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2014/09/23/21/23/iphone-6-458159_960_720.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        right = [UIImage imageWithData:data];
    
    });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.leftImageView.image = left;
            self.rightImageView.image = right;
        });
    });
}

@end
