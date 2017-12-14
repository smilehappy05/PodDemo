//
//  NSBundle+WFAddition.h
//  Pods
//
//  Created by WuShiHai on 01/06/2017.
//
//

#import <Foundation/Foundation.h>

@interface NSBundle (WFAddition)



@end

@interface NSBundle (WFConfiguration)

/**
 用于获取info.plist中设置的配置项，默认从'WFConfiguration'key中取${service}中取${key}

 @param service 服务名称
 @param key key值
 @param defaultValue 如果从key里面取不到，则返回该值
 @return 键值，如果不存在，则返回默认值, 会有类型检查, 返回字符串
 */
+ (NSString *)stringValueWithConfigurationService:(NSString *)service
                                              key:(NSString *)key
                                     defaultValue:(NSString *)defaultValue;

/**
 用于获取info.plist中设置的配置项，默认从'WFConfiguration'key中取${service}中取${key}

 @param service 服务名称
 @param key key值
 @param defaultValue 如果从key里面取不到，则返回该值
 @return 键值，如果不存在，则返回默认值, 会有类型检查, 返回BOOL
 */
+ (BOOL)boolValueWithConfigurationService:(NSString *)service
                                      key:(NSString *)key
                             defaultValue:(BOOL)defaultValue;

/**
 用于获取info.plist中设置的配置项，默认从'WFConfiguration'key中取${service}中取${key}
 
 @param service 服务名称
 @param key key值
 @param defaultValue 如果从key里面取不到，则返回该值
 @return 键值，如果不存在，则返回默认值, 会有类型检查, 返回字典
 */
+ (NSDictionary *)mapValueWithConfigurationService:(NSString *)service
                                               key:(NSString *)key
                                      defaultValue:(NSString *)defaultValue;

/**
 用于获取info.plist中设置的配置项，默认从'WFConfiguration'key中取${service}中取${key}

 @param service 服务名称
 @param key key值
 @param defaultValue 如果从key里面取不到，则返回该值
 @param type 返回类型检查
 @return 返回值
 */
+ (id)valueWithConfigurationService:(NSString *)service
                                key:(NSString *)key
                       defaultValue:(id)defaultValue
                               type:(Class)type;

@end
