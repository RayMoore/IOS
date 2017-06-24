//
//  NEShareViewController.m
//  TextDemo
//
//  Created by NetEase on 16/7/24.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NERichTextViewController.h"

@interface NERichTextViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *addressView;
@property (nonatomic, strong) UIView *seperator;

@end

@implementation NERichTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不让UITextView居中.
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.addressView];
    [self.view addSubview:self.seperator];
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

- (NSAttributedString *)attributedString {
    NSString *address = @"联系地址：\r公司地址：中华人民共和国浙江省杭州市滨江区网商路599号 距离XXXX路100米\r邮政编码：310052";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:address attributes:@{NSKernAttributeName : @(10), NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle), NSUnderlineColorAttributeName : [UIColor orangeColor]
        }];

    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(0, 5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 5)];
    
    return attributedString;
}



// 段落属性
//- (NSAttributedString *)attributedString {
//    NSString *address = @"联系地址：\r公司地址：中华人民共和国浙江省杭州市滨江区网商路599号 距离XXXX路100米\r邮政编码：310052";
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:address];
//    
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    style.lineSpacing = 15;
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
//    
//    return attributedString;
//}
//



// 链接
//- (NSAttributedString *)attributedString {
//    NSString *address = @"联系地址：\r公司地址：中华人民共和国浙江省杭州市滨江区网商路599号 距离XXXX路100米\r邮政编码：310052";
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:address];
//    [attributedString addAttribute:NSLinkAttributeName value:@"http://www.163.com" range:NSMakeRange(0, address.length)];
//
//    return attributedString;
//}
//
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
//    return YES;
//}

- (UITextView *)addressView {
    if (nil == _addressView) {
        _addressView = [[UITextView alloc] initWithFrame:CGRectMake(10, 64, CGRectGetWidth(self.view.frame) - 20 * 2, 240)];
        _addressView.font = [UIFont systemFontOfSize:16];
        _addressView.delegate = self;
        _addressView.attributedText = [self attributedString];
        _addressView.editable = NO;
        // Typing Attributes
//        _addressView.typingAttributes = @{NSKernAttributeName : @(10),NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle), NSUnderlineColorAttributeName : [UIColor orangeColor]                                      };
    }
    
    return _addressView;
}

#pragma mark - Placeholder

- (UIView *)seperator {
    if (nil == _seperator) {
        _seperator = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 240, CGRectGetWidth(self.view.frame), 1)];
        _seperator.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _seperator;
}

@end
