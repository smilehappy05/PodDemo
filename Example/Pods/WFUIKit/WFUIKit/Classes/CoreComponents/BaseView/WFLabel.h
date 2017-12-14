//
//  BaseLabel.h
//  SmartPlan
//
//  Created by WuShiHai'sMac on 25/02/2017.
//  Copyright © 2017 WS. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdocumentation"
/**
 *  Demo:
 *  <font face='HelveticaNeue-CondensedBold' size=20 color='#F9972B' kern=35>custom font with kerning</font>";
 *   <a href='http://www.baidu.com'>ljaskldfj</a>
 *   <b>ljaskl<br/>dfj</b>
 *  <font face='HelveticaNeue-CondensedBold' size=20 color='#F9972B' kern=35>custom font with kerning</font>askdlfajskkajskfd<a href='http://www.baodi.com/test'>ljaskldfj</a>
 */
#pragma clang diagnostic pop

@interface WFLabel : UILabel

/**
 手动获取适配width后的高度，用于cell height的设置
 
 @param width 宽度
 @return CGSize
 */
- (CGSize)sizeThatFitsWidth:(CGFloat)width;

/**
 手动获取适配height后的宽度
 
 @param height 高度
 @return 描述
 */
- (CGSize)sizeThatFitsHeight:(CGFloat)height;

/**
 超链接点击后的跳转，该方法为空方法，建议重载。
 
 @param router 跳转链接
 @param key 点击的文字
 */
- (void)openLink:(NSString *)router key:(NSString *)key;


/**
 设置行间距, 如果使用lineSpacing命名，会出现冲突
 */
@property (nonatomic, assign) CGFloat wf_lineSpacing;


@end

@interface WFLabelTest : NSObject

+ (void)showTest;

@end
