//
//  NSDictionary+Addition.h
//  Loan
//
//  Created by WuShiHai on 25/04/2017.
//  Copyright © 2017 Shanghai Mengdian Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WFAddition)

/**
 将字典拼接成GET URL 的参数
 eg.
 {"id":"1","name":"wushihai"}.URLParamterString => id=1&name=wushihai
 
 @return 拼接后的字符串数据
 */
- (NSString *)URLParamterString;

@end
