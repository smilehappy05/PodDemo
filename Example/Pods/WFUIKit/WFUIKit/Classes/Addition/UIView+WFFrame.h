//
//  UIView+WFFrame.h
//  Pods
//
//  Created by redye.hu on 2017/6/6.
//
//

#import <UIKit/UIKit.h>

@interface UIView (WFFrame)


/**
 等比缩放 按小的来
 
 @param frame 视图的 frame
 */
- (void)setScaleEqualFrame:(CGRect)frame;

/**
 等比缩放 按小的来
 
 @param frame 视图的 frame
 @param _isNavigationBar 是否存在导航
 @param _isTabBar 是否存在 tabbar
 */
- (void)setScaleEqualFrame:(CGRect)frame
           isNavigationBar:(BOOL)_isNavigationBar
                  isTabBar:(BOOL)_isTabBar;

/**
 等比缩放 按大的来
 
 @param frame 视图的 frame
 */
- (void)setScaleEqualBigFrame:(CGRect)frame;


/**
 等比缩放 按大的来
 
 @param frame 视图的 frame
 @param _isNavigationBar 是否存在导航
 @param _isTabBar 是否存在 tabbar
 */
- (void)setScaleEqualBigFrame:(CGRect)frame
              isNavigationBar:(BOOL)_isNavigationBar
                     isTabBar:(BOOL)_isTabBar;

/**
 宽度随屏幕缩放 高度随屏幕缩放 坐标随屏幕缩放－－－－会变形不等比缩放
 
 @param frame 视图 frame
 */
- (void)setScaleFrame:(CGRect)frame;

/**
 宽度随屏幕缩放 高度随屏幕缩放 坐标随屏幕缩放－－－－会变形不等比缩放
 
 @param frame 视图 frame
 @param _isNavigationBar 是否存在导航
 @param _isTabBar 是否存在 tabbar
 */
- (void)setScaleFrame:(CGRect)frame
      isNavigationBar:(BOOL)_isNavigationBar
             isTabBar:(BOOL)_isTabBar;

/**
 固定高和y坐标 x和宽 适配屏幕
 
 @param frame 视图 frame
 */
- (void)setScaleWidthFrame:(CGRect)frame;

/**
 固定宽高和y坐标   x适配屏幕
 
 @param frame 视图 frame
 */
- (void)setScaleXFrame:(CGRect)frame;

/**
 画线
 
 @param frame 线的 frame
 @param _subView 线的父视图
 @return 线
 */
+ (UIView *)drawBackLine:(CGRect)frame
                 subView:(UIView *)_subView;

/**
 画线
 
 @param frame 线的 frame
 @param _subView 线的父视图
 @return 线
 */
+ (UIView *)drawLine:(CGRect)frame
             subView:(UIView *)_subView;

/**
 画线
 
 @param frame 线的 framw
 @param _subView 线的父视图
 @param _color 线的颜色
 @return 线
 */
+ (UIView *)drawLine:(CGRect)frame
             subView:(UIView *)_subView
               color:(NSString *)_color;

/**
 画宽度屏幕适配的线
 
 @param frame 线的 frame
 @param _subView 线的父视图
 */
+ (void)drawScaleLine:(CGRect)frame
              subView:(UIView *)_subView;

/**
 画宽度屏幕适配的线
 
 @param frame 线的 frame
 @param _subView 线的父视图
 @param _isNavigationBar 是否存在导航
 @param _isTabBar 是否存在 tabbar
 */
+ (void)drawScaleLine:(CGRect)frame
              subView:(UIView *)_subView
      isNavigationBar:(BOOL)_isNavigationBar
             isTabBar:(BOOL)_isTabBar;

/**
 画虚线
 
 @param frame 线的 frame
 @param _subView 线的父视图
 @param _color 线的颜色
 */
+ (void)drawDashedLine:(CGRect)frame
               subView:(UIView *)_subView
                 color:(NSString *)_color;

/**
 计算缩放倍数
 
 @param _isNavigationBar 是否存在导航
 @param _isTabBar 是否存在 tabbar
 @return 缩放倍数
 */
+ (float)getScaleH:(BOOL)_isNavigationBar
          isTabBar:(BOOL)_isTabBar;

/**
 分割线的颜色
 
 @return 颜色
 */
+ (UIColor *)seperateColor;

@end
