//
//  UIColor+WFAddition.h
//  Pods
//
//  Created by redye.hu on 2017/6/6.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (WFAddition)

/**
 将十六进制的字符串转为颜色，支持alpha
 eg. "#FFFFFFFF", "FFFFFFFF", "FFFFFF"
 
 @param string 字符串
 @return 转换后的颜色值
 */
+ (UIColor *)colorWithHex:(NSString *)string;

@end
