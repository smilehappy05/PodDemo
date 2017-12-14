//
//  UIImageView+Animations.m
//  ItGirls
//
//  Created by WuShiHai on 8/31/16.
//  Copyright © 2016 微盟. All rights reserved.
//

#import "UIImageView+WFAnimations.h"

@implementation UIImageView (WFAnimations)

- (void)rotating{
    [self rotating:1 direction:1];
}

- (void)rotating:(CFTimeInterval)duration direction:(NSInteger)direction{
    
    if (direction != 1 && direction != -1) {
        direction = 1;
    }
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    animation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * direction];
    
    animation.duration = duration;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    animation.removedOnCompletion = NO;
    
    [self.layer removeAnimationForKey:@"rotate360Degree"];
    [self.layer addAnimation:animation forKey:@"rotate360Degree"];
    
}


@end
