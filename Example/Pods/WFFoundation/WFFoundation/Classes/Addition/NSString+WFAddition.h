//
//  NSString+Additions.h
//  Loan
//
//  Created by Hu on 2017/4/19.
//  Copyright © 2017年 Shanghai Mengdian Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WFAddition)

/**
 验证是否手机号

 @return 是否为手机号
 */
- (BOOL)isPhone;

/**
 格式化手机号：188 8888 8888

 @return 处理后的结果
 */
- (NSString *)formatPhone;

/**
 去除字符串中的空格

 @return 处理后的结果
 */
- (NSString *)trimAllSpace;

/**
 替换掉字符创中的 emoji 表情

 @param replaceString 替换字符串
 @return 替换掉 emoji 表情后的字符串
 */
- (NSString *)replaceEmojiWithString:(NSString *)replaceString;

/**
 如 mxdl://fin-loan.weimob.com/home/mainPage?token=! 可得到 mainPage
 
 @return 如果没有则返回nil
 */
- (NSString *)lastPathComponentEscapingParamters;

@end
