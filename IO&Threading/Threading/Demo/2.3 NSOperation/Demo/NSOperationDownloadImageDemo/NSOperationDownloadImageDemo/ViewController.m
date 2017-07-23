//
//  ViewController.m
//  NSOperationDownloadImageDemo
//
//  Created by amao on 16/8/31.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"

@interface DownloadImageOperation : NSOperation
@property (nonatomic,strong)    UIImage *image;
@end

@implementation DownloadImageOperation

- (void)main
{
    NSURL *url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/c/cb/IOS7_Logo.png"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.image =  [UIImage imageWithData:data];
}

@end


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _queue = [[NSOperationQueue alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (IBAction)buttonPressed:(id)sender {

    
    /*
    DownloadImageOperation *op = [[DownloadImageOperation alloc] init];
    __weak typeof(op) weakOp = op;
    __weak typeof(self) weakSelf = self;
    op.completionBlock = ^(){
        
        typeof(weakSelf) strongSelf = weakSelf;
        UIImage *image = weakOp.image;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.imageView.image = image;
        });
    };*/
    
    
    /*
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/c/cb/IOS7_Logo.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image =  [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];*/
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self
                                                                     selector:@selector(downloadImage)
                                                                       object:nil];
    
    
    [_queue addOperation:op];
}

- (void)downloadImage
{
    NSURL *url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/c/cb/IOS7_Logo.png"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image =  [UIImage imageWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = image;
    });
}


@end
