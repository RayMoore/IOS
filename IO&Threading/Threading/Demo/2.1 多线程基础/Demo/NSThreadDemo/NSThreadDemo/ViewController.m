//
//  ViewController.m
//  NSThreadDemo
//
//  Created by amao on 16/8/5.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

@protocol DownloadImageProtocol <NSObject>

- (void)onDownloadImage:(UIImage *)image;

@end

@interface DownloadImageThread : NSThread
@property (nonatomic,weak)  id<DownloadImageProtocol> delegate;
@end


@implementation DownloadImageThread

- (void)main
{
    NSURL *url = [NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2014/09/23/21/23/iphone-6-458159_960_720.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(onDownloadImage:)])
    {
        [_delegate onDownloadImage:image];
    }
}

@end

@interface ViewController ()<DownloadImageProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)buttonPressed:(id)sender {
    DownloadImageThread *thread = [[DownloadImageThread alloc] init];
    thread.delegate = self;
    [thread start];
    
}

- (void)onDownloadImage:(UIImage *)image
{
    [self performSelectorOnMainThread:@selector(onMainThreadImageDone:)
                           withObject:image
                        waitUntilDone:NO];
    
}

- (void)onMainThreadImageDone:(id)arg
{
    if ([arg isKindOfClass:[UIImage class]])
    {
        self.imageView.image = (UIImage *)arg;
    }
}
@end
