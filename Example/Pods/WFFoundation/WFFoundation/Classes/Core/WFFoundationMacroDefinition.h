//
//  WFFoundationMacroDefinition.h
//  Pods
//
//  Created by WuShiHai on 10/07/2017.
//
//

#ifndef WFFoundationMacroDefinition_h
#define WFFoundationMacroDefinition_h

//MainBundle
#define MainBundle()                                ([NSBundle mainBundle])
#define PathForBundleResource(resName, resType)     [MainBundle() pathForResource:(resName) ofType:(resType)]
#define URLForBundleResource(resName, resType)      [MainBundle() URLForResource:(resName) \
withExtension:(resType)]
#define APPDisplayName()                            [MainBundle() \
objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define AppBundleIdentifier()                       [MainBundle() \
objectForInfoDictionaryKey:@"CFBundleIdentifier"]
#define AppReleaseVersionNumber()                   [MainBundle() \
objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define AppBuildVersionNumber()                     [MainBundle() objectForInfoDictionaryKey:@"CFBundleVersion"]

//text size
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define WF_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define WF_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

//block
#define WFBlockSafeRun(block, ...) block ? block(__VA_ARGS__) : nil

//获取通知中心
#define WFNotificationCenter [NSNotificationCenter defaultCenter]

//自定义高效率的 NSLog
#ifdef DEBUG
#define NSLog(...) DDLogInfo(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//判断当前的系统版本
//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//判断 iOS 8 或更高的系统版本
#define IOS_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
#endif
#if TARGET_IPHONE_SIMULATOR
#endif

//沙盒目录文件
//获取temp
#define WFPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define WFPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define WFPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//6.弱引用/强引用
#define MLWeakSelf(type)  __weak typeof(type) weak##type = type;
#define MLStrongSelf(type)  __strong typeof(type) type = weak##type;



//由角度转换弧度 由弧度转换角度
#define WFDegreesToRadian(x) (M_PI * (x) / 180.0)
#define WFRadianToDegrees(radian) (radian*180.0)/(M_PI)

#endif /* WFFoundationMacroDefinition_h */
