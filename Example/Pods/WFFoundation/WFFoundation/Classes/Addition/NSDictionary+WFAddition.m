//
//  NSDictionary+Addition.m
//  Loan
//
//  Created by WuShiHai on 25/04/2017.
//  Copyright © 2017 Shanghai Mengdian Information Technology Co., Ltd. All rights reserved.
//

#import "NSDictionary+WFAddition.h"

@implementation NSDictionary (WFAddition)

- (NSString *)URLParamterString{
    NSString *URLParamterString = @"";
    NSMutableArray *parameters = [@[] mutableCopy];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isKindOfClass:[NSString class]] && ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])) {
            [parameters addObject:[NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [obj stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
    }];
    URLParamterString = [parameters componentsJoinedByString:@"&"];
    
    return URLParamterString;
}

@end
