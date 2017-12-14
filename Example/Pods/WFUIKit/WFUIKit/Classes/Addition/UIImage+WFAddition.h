//
//  UIImage+WFAddition.h
//  Pods
//
//  Created by redye.hu on 2017/6/7.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (WFAddition)

/**
 根据颜色生成图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 根据颜色生成指定大小图片
 
 @param color 颜色
 @param size 尺寸
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;

/**
 将指定的view变成图片
 
 @param view view
 @return 图片
 */
+ (UIImage *)imageFromView:(UIView *)view;

/**
 将指定的view变成图片
 
 @param view view
 @param inset inset
 @return 图片
 */
+ (UIImage *)imageFromView:(UIView *)view
                     inset:(UIEdgeInsets)inset;

/**
 根据字符串生成二维码
 
 @param string 字符串
 @return 图片
 */
+ (UIImage *)qrCodeImageWithString:(NSString *)string;

/**
 根据字符串、宽度、高度生成二维码
 
 @param code 字符串
 @param width 宽度
 @param height 高度
 @return 图片
 */
+ (UIImage *)generateQRCode:(NSString *)code
                      width:(CGFloat)width
                     height:(CGFloat)height;

/**
 缩放图片

 @param targetSize 目标大小
 @param fitScale 是否适配屏幕
 @return 图片
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize
                         fitScale:(BOOL)fitScale;

/**
 缩放图片

 @param targetSize 目标大小
 @return 图片
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/**
 缩放图片

 @param newSize 目标大小
 @param quality 图片质量
 @return 图片
 */
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

/**
 压缩图片

 @param targetSize 指定大小
 @param image 图片
 @return 二进制流
 */
+ (NSData *)compressToSize:(long)targetSize image:(UIImage *)image;

/**
 压缩图片

 @param targetSize 目标大小
 @param sourceSize 资源大小
 @param image 图片
 @return 二进制
 */
+ (NSData *)compressToSize:(long)targetSize sourceSize:(long)sourceSize image:(UIImage *)image;

/**
 读取 framework 里的图片

 @param aclass 目标类
 @param name 图片名称
 @return 图片
 */
+ (UIImage *)frameworkImageWithClass:(Class)aclass name:(NSString *)name;

/**
 读取 framework 中 bundle 的图片

 @param aclass 目标类
 @param bundleName bundle 名称
 @param imageName 图片名称
 @return 图片
 */
+ (UIImage *)frameworkImage:(Class)aclass bundleName:(NSString *)bundleName imageName:(NSString *)imageName;

@end
