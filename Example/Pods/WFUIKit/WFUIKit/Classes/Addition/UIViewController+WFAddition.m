//
//  UIViewController+WFAddition.m
//  Pods
//
//  Created by WuShiHai on 30/06/2017.
//
//

#import "UIViewController+WFAddition.h"

@implementation UIViewController (WFAddition)

+ (BOOL)needLogin {
    return NO;
}

+ (NSString *)pageName{
    return [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
}
+ (BOOL)isStatisticPV{
    return YES;
}

@end
