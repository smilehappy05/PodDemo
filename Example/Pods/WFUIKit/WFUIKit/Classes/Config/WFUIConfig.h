//
//  WFUIConfig.h
//  Pods
//
//  Created by Hu on 2017/6/5.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WFUIConfig : NSObject

/**
 *  调用UIKit库的时候 注册对应的应用级配置
 *
 *  @param designScreenWidth 设计稿所使用的尺寸
 */
+ (void)registerUIKit:(CGFloat)designScreenWidth
   designScreenHeight:(CGFloat)designScreenHeight
           themeColor:(NSString *)themeColor;

/**
 *  获取字体放大比例
 *
 *  @return 屏幕宽度与设计稿的比例
 */
+ (CGFloat)scaleOfFont;

/**
 *  设计稿尺寸
 *
 *  @return 注册UIKit时候传入的尺寸
 */
+ (CGFloat)designScreenWidth;


/**
 *  设计稿尺寸
 *
 *  @return 注册UIKit时候传入的尺寸
 */
+ (CGFloat)designScreenHeight;

/**
 *  主题色
 *
 *  @return 获取主题颜色
 */
+ (NSString *)themeColor;

/**
 屏幕宽度

 @return 屏幕宽度
 */
+ (CGFloat)screenWidth;

/**
 屏幕高度

 @return 屏幕高度
 */
+ (CGFloat)screenHeight;

@end
