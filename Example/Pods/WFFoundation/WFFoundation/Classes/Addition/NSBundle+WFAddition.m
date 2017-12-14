//
//  NSBundle+MFAddition.m
//  Pods
//
//  Created by WuShiHai on 01/06/2017.
//
//

#import "NSBundle+WFAddition.h"

@implementation NSBundle (MFAddition)

@end

@implementation NSBundle (MFConfiguration)

+ (NSString *)stringValueWithConfigurationService:(NSString *)service
                                              key:(NSString *)key
                                     defaultValue:(NSString *)defaultValue{
    NSString *value = [self valueWithConfigurationService:service
                                           key:key
                                  defaultValue:defaultValue
                                          type:[NSString class]];
    if (value.length <= 0) {
        value = defaultValue;
    }
    return value;
}

+ (BOOL)boolValueWithConfigurationService:(NSString *)service
                                        key:(NSString *)key
                               defaultValue:(BOOL)defaultValue{
    return [[self valueWithConfigurationService:service
                                           key:key
                                  defaultValue:@(defaultValue)
                                          type:[NSNumber class]] boolValue];
}

+ (NSDictionary *)mapValueWithConfigurationService:(NSString *)service
                                               key:(NSString *)key
                                      defaultValue:(NSString *)defaultValue{
    return [self valueWithConfigurationService:service
                                           key:key
                                  defaultValue:defaultValue
                                          type:[NSDictionary class]];
}

+ (id)valueWithConfigurationService:(NSString *)service
                                key:(NSString *)key
                       defaultValue:(id)defaultValue
                               type:(Class)type{
    id value = [self valueWithConfigurationService:service
                                                      key:key
                                             defaultValue:defaultValue];
    if ([value isKindOfClass:type]) {
        return value;
    }else{
        return nil;
    }
}

+ (id)valueWithConfigurationService:(NSString *)service
                                key:(NSString *)key
                       defaultValue:(id)defaultValue{
    NSDictionary *configurationMaps = [[NSBundle mainBundle]
                                       objectForInfoDictionaryKey:@"WFConfiguration"];
    if ([configurationMaps isKindOfClass:[NSDictionary class]]) {
        NSDictionary *serviceMaps = [configurationMaps objectForKey:service];
        if ([serviceMaps isKindOfClass:[NSDictionary class]]) {
            NSString *value = [serviceMaps objectForKey:key];
            if (value) {
                return value;
            }
        }
    }
    
    return defaultValue;
}

@end
