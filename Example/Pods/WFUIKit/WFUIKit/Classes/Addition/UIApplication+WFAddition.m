//
//  UIApplication+WFAddition.m
//  Pods
//
//  Created by redye.hu on 2017/6/6.
//
//

#import "UIApplication+WFAddition.h"

@implementation UIApplication (WFAddition)

+ (UIViewController *)displayViewController{
    return [self displayViewController:[self displayWindow].rootViewController ignorePresent:NO];
}

+ (UIViewController *)displayViewController:(id)currentViewController ignorePresent:(BOOL)ignorePresent{
    if ([currentViewController isKindOfClass:[UINavigationController class]]){
        return [self displayViewController:[[currentViewController viewControllers] lastObject] ignorePresent:ignorePresent];
    }else if ([currentViewController isKindOfClass:[UITabBarController class]]){
        return [self displayViewController:[currentViewController selectedViewController] ignorePresent:ignorePresent];
    }else if ([currentViewController isKindOfClass:[UIViewController class]]) {
        UIViewController *presentedViewController = [currentViewController presentedViewController];
        if (ignorePresent == NO && presentedViewController && [[self blackListForDisplayPresentViewController] containsObject:NSStringFromClass([presentedViewController class])] == NO) {
            return [self displayViewController:[currentViewController presentedViewController] ignorePresent:ignorePresent];
        }else{
            return currentViewController;
        }
    }else{
        NSAssert(0,@"%s:search display ViewControlelr error!",__func__);
        return nil;
    }
}

+ (NSString *)displayPageName{
    UIViewController *vc = [UIApplication displayViewController];
    SEL selector = NSSelectorFromString(@"pageName");
    if ([[vc class]respondsToSelector:selector]) {
        NSString *pageName = ((NSString * (*)(id, SEL))[[vc class] methodForSelector:selector])([vc class], selector);
        return pageName;
    }else{
        return NSStringFromClass([vc class]);
    }
}

+ (NSArray *)blackListForDisplayPresentViewController{
    static NSArray *whiteList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        whiteList = @[
                      @"RCTModalHostViewController",
                      ];
    });
    
    return whiteList;
}

+ (UIWindow *)displayWindow{
    __block UIWindow *window = nil;
    [[UIApplication sharedApplication].windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIWindow class]]) {
            window = obj;
        }
    }];
    return window;
}

+ (UIViewController *)topOfRootViewController{
    return [self displayViewController:[self displayWindow].rootViewController ignorePresent:YES];
}

@end
