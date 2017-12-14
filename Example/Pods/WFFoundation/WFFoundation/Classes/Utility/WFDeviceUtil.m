//
//  DeviceUtil.m
//  WeiKe
//
//  Created by kaelzhou on 15/5/4.
//  Copyright (c) 2015年 jing. All rights reserved.
//

#import "WFDeviceUtil.h"

#import <arpa/inet.h>
#import <ifaddrs.h>

//for mac
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

//for idfa
#import <AdSupport/AdSupport.h>

@implementation WFDeviceUtil

+ (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

+ (NSString *)idfaString {
    //获取广告id
    if ([[UIDevice currentDevice].systemVersion floatValue] < 6.0) {
        return @"";
    }
    else{
        ASIdentifierManager *asIM = [ASIdentifierManager sharedManager];
        
        if (asIM == nil) {
            return @"";
        }
        else{
            NSString *identifier = [asIM.advertisingIdentifier UUIDString];
            return identifier;
        }
        
    }
    
}

+ (NSString *)idfvString
{
    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return @"";
}

+ (NSString*)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return version;
}

+ (NSString*)bundleIdentifier
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    
    return version;
}

+ (NSString *)buildVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    return version;
}

+ (NSString*)systemVersion
{
    UIDevice *device = [UIDevice currentDevice];
    return device.systemVersion;
}

+ (NSString*)deviceInfo
{
    UIDevice *device = [UIDevice currentDevice];
    return device.model;
}

+ (NSString *)getIPAddress{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    return [self getIPv6Address];
#else
    return [self getIPv4Address];
#endif
}
+ (NSString *)getIPv4Address {
    
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

+ (NSString *)getIPv6Address {
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
    
}

+ (NSString *)deviceArchitecture{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    return platform;
}

+ (NSString *)appDeviceUUID {
    static dispatch_once_t onceToken;
    static NSString *wf_appDeviceUUID = nil;
    dispatch_once(&onceToken, ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        wf_appDeviceUUID = [userDefaults objectForKey:@"wf_appDeviceUUID"];
        if ([wf_appDeviceUUID isKindOfClass:[NSString class]] == NO) {
            NSUUID *UUID = [[NSUUID alloc] init];
            wf_appDeviceUUID = UUID.UUIDString;
            if ([wf_appDeviceUUID isKindOfClass:[NSString class]]) {
                [userDefaults setObject:wf_appDeviceUUID forKey:@"wf_appDeviceUUID"];
            }
        }
    });
    return wf_appDeviceUUID;
}

@end
