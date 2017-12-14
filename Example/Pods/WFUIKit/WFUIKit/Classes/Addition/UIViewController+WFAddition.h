//
//  UIViewController+WFAddition.h
//  Pods
//
//  Created by WuShiHai on 30/06/2017.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (WFAddition)

/**
 是否需要登录，目前Router部分会根据该值进行判断是否登录跳转

 @return 默认NO
 */
+ (BOOL)needLogin;

/**
 打点的pageName，打viewwillAppear 中 PV点的时候需要使用这个参数，其他打点也要优先使用这个pageName
 
 @return 默认类名
 */
+ (NSString *)pageName;

/**
 是否在viewwillAppear中打pv点
 
 @return 默认yes
 */
+ (BOOL)isStatisticPV;

@end
