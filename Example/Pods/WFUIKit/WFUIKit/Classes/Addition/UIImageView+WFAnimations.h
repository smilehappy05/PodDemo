//
//  UIImageView+Animations.h
//  ItGirls
//
//  Created by WuShiHai on 8/31/16.
//  Copyright © 2016 微盟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WFAnimations)

/**
 图片360°不停旋转
 */
- (void)rotating;

/**
 图片360°不停旋转

 @param duration 转360°所需时间，用于控制旋转速度
 @param direction 方向，1为顺时针，-1为逆时针
 */
- (void)rotating:(CFTimeInterval)duration direction:(NSInteger)direction;

@end
