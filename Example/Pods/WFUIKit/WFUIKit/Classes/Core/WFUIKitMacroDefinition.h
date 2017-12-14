//
//  WFUIKitMacroDefinition.h
//  Pods
//
//  Created by WuShiHai on 10/07/2017.
//
//

#ifndef WFUIKitMacroDefinition_h
#define WFUIKitMacroDefinition_h

//获取屏幕宽度与高度
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREENH_HEIGHT))
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
#define IPHONE_X_BOTTOM_MARGIN 35.0f

//设置RGB颜色/设置RGBA颜色
#define WFRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define WFRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

//设置 view 圆角和边框
#define WFViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#endif /* WFUIKitMacroDefinition_h */
