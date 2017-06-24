//
//  RootViewController.m
//  UIViewAnimationDemo
//
//  Created by Chengyin on 16/7/3.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "RootViewController.h"

@interface AnimationObject : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *className;
@end

@implementation AnimationObject

@end

@implementation RootViewController
{
    NSArray *_data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    AnimationObject *viewAnimation = [AnimationObject new];
    viewAnimation.title = @"View animation";
    viewAnimation.className = @"ViewAnimationViewController";
    
    AnimationObject *flipAnimation = [AnimationObject new];
    flipAnimation.title = @"Flip animation";
    flipAnimation.className = @"FlipViewController";
    
    AnimationObject *springAnimation = [AnimationObject new];
    springAnimation.title = @"Spring animation";
    springAnimation.className = @"SpringViewController";
    
    AnimationObject *keyFrameAnimation = [AnimationObject new];
    keyFrameAnimation.title = @"Key frame animation";
    keyFrameAnimation.className = @"KeyFrameViewController";
    
    AnimationObject *playAnimation = [AnimationObject new];
    playAnimation.title = @"Play animation";
    playAnimation.className = @"PlayViewController";
    
    _data = @[viewAnimation,flipAnimation,springAnimation,keyFrameAnimation,playAnimation];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"defaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_data[indexPath.row] title];
    return cell;
}


#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *className = [_data[indexPath.row] className];
    UIViewController *viewController = [NSClassFromString(className) new];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
