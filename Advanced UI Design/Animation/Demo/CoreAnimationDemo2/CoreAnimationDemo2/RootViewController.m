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
    
    AnimationObject *playAnimation = [AnimationObject new];
    playAnimation.title = @"Play animation";
    playAnimation.className = @"PlayViewController";
    
    AnimationObject *springAnimation = [AnimationObject new];
    springAnimation.title = @"Spring animation";
    springAnimation.className = @"SpringViewController";
    
    AnimationObject *keyframeAnimation = [AnimationObject new];
    keyframeAnimation.title = @"Keyframe animation";
    keyframeAnimation.className = @"KeyFrameViewController";
    
    AnimationObject *driveCarAnimation = [AnimationObject new];
    driveCarAnimation.title = @"Drive Car animation";
    driveCarAnimation.className = @"DriveCarViewController";

    AnimationObject *transitionAnimation = [AnimationObject new];
    transitionAnimation.title = @"Transition animation";
    transitionAnimation.className = @"TransitionViewController";
    
    AnimationObject *groupAnimation = [AnimationObject new];
    groupAnimation.title = @"Group animation";
    groupAnimation.className = @"GroupViewController";
    
    AnimationObject *shapeLayerAnimation = [AnimationObject new];
    shapeLayerAnimation.title = @"ShapeLayer animation";
    shapeLayerAnimation.className = @"ShapeLayerViewController";
    
    AnimationObject *replicatorLayerAnimation = [AnimationObject new];
    replicatorLayerAnimation.title = @"ReplicatorLayer animation";
    replicatorLayerAnimation.className = @"ReplicatorLayerViewController";
    
    AnimationObject *emitterLayerAnimation = [AnimationObject new];
    emitterLayerAnimation.title = @"EmitterLayer animation";
    emitterLayerAnimation.className = @"EmitterLayerViewController";
    
    _data = @[playAnimation,springAnimation,keyframeAnimation,driveCarAnimation,transitionAnimation,groupAnimation,
              shapeLayerAnimation,replicatorLayerAnimation,emitterLayerAnimation];
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
