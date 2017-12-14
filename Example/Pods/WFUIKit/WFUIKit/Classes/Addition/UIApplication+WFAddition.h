//
//  UIApplication+WFAddition.h
//  Pods
//
//  Created by redye.hu on 2017/6/6.
//
//

#import <UIKit/UIKit.h>

@interface UIApplication (WFAddition)


/**
 当前正在显示的 viewController， 忽略模态弹出

 @return viewController
 */
+ (UIViewController *)displayViewController;

/**
 当前正在显示的 window

 @return window
 */
+ (UIWindow *)displayWindow;

/**
 当前处在最顶层的 viewController

 @return viewController
 */
+ (UIViewController *)topOfRootViewController;


/**
 当前正在显示的 viewController 的名字

 @return viewController 的名字
 */
+ (NSString *)displayPageName;

@end
