//
//  DeviceUtil.h
//  WeiKe
//
//  Created by kaelzhou on 15/5/4.
//  Copyright (c) 2015年 jing. All rights reserved.
//

@interface WFDeviceUtil : NSObject

+ (NSString *)macString;
+ (NSString *)idfaString;
+ (NSString *)idfvString;
+ (NSString *)appVersion;
+ (NSString *)bundleIdentifier;
+ (NSString *)buildVersion;
+ (NSString *)systemVersion;
+ (NSString *)deviceInfo;
+ (NSString *)getIPAddress;

/**
 设备指令集：
 eg. x86_64

 @return 字符串
 */
+ (NSString *)deviceArchitecture;

/**
 从UserDefaults中取key为wf_appDeviceUUID的值：
 1.如果取到，则return;
 2.如果取不到，则使用NSUUID创建一个新的，并保存到UserDefaults中;
 3.创建失败，则返回nil。
 @return 字符串
 */
+ (NSString *)appDeviceUUID;

@end
