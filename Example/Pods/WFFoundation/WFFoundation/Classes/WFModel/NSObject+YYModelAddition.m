//
//  NSObject+YYModelAddition.m
//  Pods
//
//  Created by WuShiHai on 05/04/2017.
//
//

#import "NSObject+YYModelAddition.h"
#import "YYModel.h"

@implementation NSObject (YYModelAddition)

- (NSDictionary *)yy_modelToJSON{
    NSDictionary *dic = [self yy_modelToJSONObject];
    return [dic isKindOfClass:[NSDictionary class]]?dic:@{};
}

@end
