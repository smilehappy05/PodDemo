//
//  UITabBarController+Addition.h
//  Loan
//
//  Created by WuShiHai on 13/04/2017.
//  Copyright © 2017 Shanghai Mengdian Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (WFAddition)

/**
 判断tabbar是否在当前controller显示
 默认只有self.viewControllers里面的页面展示底部Tabbar，如果实际不是，则该方法需要修复

 @param viewController 要判断的controller
 @return 是否显示
 */
- (BOOL)isShow:(UIViewController *)viewController;

@end
