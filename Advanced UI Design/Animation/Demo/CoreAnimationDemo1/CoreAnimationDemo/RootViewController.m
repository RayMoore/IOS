//
//  RootViewController.m
//  CoreAnimationDemo
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
    
    
    AnimationObject *implicitAnimation = [AnimationObject new];
    implicitAnimation.title = @"Implicit animation";
    implicitAnimation.className = @"ImplicitAnimationViewController";

    AnimationObject *presentationTree = [AnimationObject new];
    presentationTree.title = @"Presentation tree";
    presentationTree.className = @"PresentationTreeViewController";

    AnimationObject *transaction = [AnimationObject new];
    transaction.title = @"Transaction";
    transaction.className = @"TransactionViewController";

    AnimationObject *basicAnimation = [AnimationObject new];
    basicAnimation.title = @"Basic animation";
    basicAnimation.className = @"BasicAnimationViewController";
    
    AnimationObject *additiveAnimation = [AnimationObject new];
    additiveAnimation.title = @"Additive animation";
    additiveAnimation.className = @"AdditiveAnimationViewController";
    
    AnimationObject *mediaTiming = [AnimationObject new];
    mediaTiming.title = @"Media timing";
    mediaTiming.className = @"MediaTimingViewController";
    
    AnimationObject *playAnimation = [AnimationObject new];
    playAnimation.title = @"Play animation";
    playAnimation.className = @"PlayViewController";

    AnimationObject *fillMode = [AnimationObject new];
    fillMode.title = @"Fill mode";
    fillMode.className = @"FillModeViewController";
    
    _data = @[implicitAnimation,presentationTree,transaction,basicAnimation,fillMode,
              additiveAnimation,mediaTiming,playAnimation];
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
