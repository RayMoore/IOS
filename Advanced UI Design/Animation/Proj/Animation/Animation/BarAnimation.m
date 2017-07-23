//
//  BarAnimation.m
//  Animation
//
//  Created by Ray on 03/07/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "BarAnimation.h"

@interface BarAnimation ()

@property(assign,nonatomic) BOOL playing;
@property (weak, nonatomic) IBOutlet UIView *bar_1;
@property (weak, nonatomic) IBOutlet UIView *bar_2;
@property (weak, nonatomic) IBOutlet UIView *bar_3;
@property (weak, nonatomic) IBOutlet UIView *bar_4;

@end

@implementation BarAnimation

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self = [super init];
    self.playing = NO;
    [self.bar_1 setBackgroundColor:[UIColor greenColor]];
    return self;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.playing = !self.playing;
    if(_playing){
        NSLog(@"playing");
        [self startPlaying];
    }else{
        NSLog(@"stop playing");
        [self stopPlaying];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //ignore
}



-(void)startPlaying{
//    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
//        
//    } completion:nil];
//    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"bounds"];
//    
//    CGRect rect = self.bar_1.layer.bounds;
//    rect.size.height = 60;
//    animation.fromValue = [NSValue valueWithCGRect:rect];
//    rect.size.height = 120;
//    animation.toValue = [NSValue valueWithCGRect:rect];
//    //    animation.duration = 1;
//    //    animation.duration = 5;
//    //    animation.delegate = self;
//    //    NSLog(@"%lf",animation.settlingDuration);
//    //    animation.duration = animation.settlingDuration;
//    self.bar_1.bounds = rect;
//    
//    [self.bar_1.layer addAnimation:animation forKey:animation.keyPath];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [self.bar_1 setHidden:YES];
    } completion:nil];
}

-(void)stopPlaying{

}


@end
