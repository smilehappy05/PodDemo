//
//  WFUIConfig.m
//  Pods
//
//  Created by Hu on 2017/6/5.
//
//

#import "WFUIConfig.h"

static CGFloat _designScreenWidth = 375;
static CGFloat _designScreenHeight = 667;
static NSString *_themeColor  = @"#fd6847";

@implementation WFUIConfig

+ (void)registerUIKit:(CGFloat)designScreenWidth
   designScreenHeight:(CGFloat)designScreenHeight
           themeColor:(NSString *)themeColor{
    _designScreenWidth = designScreenWidth;
    _designScreenHeight = designScreenHeight;
    _themeColor = themeColor;
}

+ (CGFloat)scaleOfFont{
    if (_designScreenWidth <= 0) {
        return 1;
    }
    return [UIScreen mainScreen].bounds.size.width/_designScreenWidth;
}

+ (CGFloat)designScreenWidth{
    return _designScreenWidth;
}

+ (CGFloat)designScreenHeight{
    return _designScreenHeight;
}

+ (NSString *)themeColor{
    return _themeColor;
}

+ (CGFloat)screenWidth {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

+ (CGFloat)screenHeight {
    return CGRectGetHeight([UIScreen mainScreen].bounds);
}

@end
