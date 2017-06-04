//
//  BlogViewController.m
//  UIView-assignment
//
//  Created by Ray on 04/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "BlogViewController.h"
#import "ArticleView.h"

@interface BlogViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *contentInputBg;
@property (weak, nonatomic) IBOutlet UITextField *contentInputTextField;
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation BlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage* bgImage = [_contentInputBg.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22) resizingMode:UIImageResizingModeStretch];
    [_contentInputBg setImage:bgImage];
    
    UIImage* btnBgImage = [[UIImage imageNamed:@"button-green"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [_publishBtn setBackgroundImage:btnBgImage forState:UIControlStateNormal];
    [_publishBtn setBackgroundImage:btnBgImage forState:UIControlStateHighlighted];
    [_publishBtn addTarget:self action:@selector(publishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}
- (void) publishBtnClicked{
    [self.view endEditing:YES];
    NSString* content = _contentInputTextField.text;
    if(content.length != 0){
        //content is not null, publish content.
        ArticleView* article = [[[UINib nibWithNibName:@"ArticleView" bundle:nil] instantiateWithOwner:nil options:nil]firstObject];
        NSDate* currentDate = [NSDate date];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString* dateString = [dateFormatter stringFromDate:currentDate];
        [article.userNameLabel setText:@"Ray"];
        [article.datetimeLabel setText:dateString];
        [article.contentLabel setText:content];
        //add article to the contentView view and then update the frame.
        [_contentView addSubview:article];
        [self updateLastArticleConstraint];
        
        
    }
}

- (void)updateLastArticleConstraint{
    ArticleView* article = [_contentView.subviews lastObject];
    [article setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint* topConstraint = nil;
    if(_contentView.subviews.count == 1){
        topConstraint = [NSLayoutConstraint constraintWithItem:article attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1 constant:12];
    }else{
        ArticleView* lastPreView = _contentView.subviews[_contentView.subviews.count-2];
        topConstraint = [NSLayoutConstraint constraintWithItem:article attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lastPreView attribute:NSLayoutAttributeBottom multiplier:1 constant:12];
    }
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem:article attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem:article attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [_contentView addConstraint:topConstraint];
    [_contentView addConstraint:leftConstraint];
    [_contentView addConstraint:rightConstraint];
    
}
- (void)updateLastArticleView{
    ArticleView* article = [_contentView.subviews lastObject];
    CGFloat offsetY = 0;
    if(_contentView.subviews.count == 1){
        offsetY = 12.f;
    }else{
        UIView *lastPreView = _contentView.subviews[_contentView.subviews.count-2];
        offsetY = CGRectGetMaxY(lastPreView.frame)+12.f;
    }
//    CGFloat articleHeight = [article.contentLabel sizeThatFits:CGSizeMake(CGRectGetWidth(_contentView.bounds)- 46.f, CGFLOAT_MAX)].height;
    article.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(_contentView.bounds)-46.f;
    CGFloat articleHeight = [article.contentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect articleFrame = CGRectMake(0, offsetY, CGRectGetWidth(_contentView.bounds), articleHeight+35.5);
    [article setFrame:articleFrame];
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
