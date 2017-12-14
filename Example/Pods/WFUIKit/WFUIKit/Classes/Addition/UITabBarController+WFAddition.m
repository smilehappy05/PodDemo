//
//  UITabBarController+Addition.m
//  Loan
//
//  Created by WuShiHai on 13/04/2017.
//  Copyright © 2017 Shanghai Mengdian Information Technology Co., Ltd. All rights reserved.
//

#import "UITabBarController+WFAddition.h"

@implementation UITabBarController (WFAddition)

- (BOOL)isShow:(UIViewController *)viewController{
    
    UIViewController *selectedViewController = self.selectedViewController;
    if (selectedViewController == viewController) {
        return YES;
    }else{
        if ([selectedViewController isKindOfClass:[UINavigationController class]]) {
            if ([(UINavigationController *)selectedViewController viewControllers].firstObject == viewController) {
                return YES;
            }else{
                return viewController.hidesBottomBarWhenPushed == NO;
            }
        }
    }
    
    return NO;
}

@end
