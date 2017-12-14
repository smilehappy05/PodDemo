//
//  UIView+WFFrame.m
//  Pods
//
//  Created by redye.hu on 2017/6/6.
//
//

#import "UIView+WFFrame.h"
#import "UIColor+WFAddition.h"
#import <WFUIKit/WFUIKitConfig.h>

@implementation UIView (WFFrame)

//等比缩放 按小的来
- (void)setScaleEqualFrame:(CGRect)frame{
    [self setScaleEqualFrame:frame isNavigationBar:NO isTabBar:NO];
}

- (void)setScaleEqualFrame:(CGRect)frame isNavigationBar:(BOOL)_isNavigationBar isTabBar:(BOOL)_isTabBar{
    float loc_ScaleH = [UIView getScaleH:_isNavigationBar isTabBar:_isTabBar];
    float loc_ScaleW = (float)[WFUIConfig scaleOfFont];
    float loc_sizeScale = loc_ScaleH;
    if(loc_sizeScale > loc_ScaleW){
        loc_sizeScale = loc_ScaleW;
    }
    CGRect loc_frame=CGRectMake(CGRectGetMinX(frame)*loc_ScaleW, CGRectGetMinY(frame)*loc_ScaleH, CGRectGetWidth(frame)*loc_sizeScale, CGRectGetHeight(frame)*loc_sizeScale);
    [self setFrame:loc_frame];
}

//等比缩放 按大的来
- (void)setScaleEqualBigFrame:(CGRect)frame{
    [self setScaleEqualBigFrame:frame isNavigationBar:NO isTabBar:NO];
}

- (void)setScaleEqualBigFrame:(CGRect)frame isNavigationBar:(BOOL)_isNavigationBar isTabBar:(BOOL)_isTabBar{
    float loc_ScaleH=[UIView getScaleH:_isNavigationBar isTabBar:_isTabBar];
    float loc_ScaleW=(float)[WFUIConfig scaleOfFont];
    
    float loc_sizeScale=loc_ScaleH;
    if(loc_sizeScale<loc_ScaleW){
        loc_sizeScale=loc_ScaleW;
    }
    CGRect loc_frame=CGRectMake(CGRectGetMinX(frame)*loc_ScaleW, CGRectGetMinY(frame)*loc_ScaleH, CGRectGetWidth(frame)*loc_sizeScale, CGRectGetHeight(frame)*loc_sizeScale);
    [self setFrame:loc_frame];
}

- (void)setScaleFrame:(CGRect)frame{
    [self setScaleFrame:frame isNavigationBar:NO isTabBar:NO];
}

- (void)setScaleFrame:(CGRect)frame isNavigationBar:(BOOL)_isNavigationBar isTabBar:(BOOL)_isTabBar{
    float loc_ScaleH=[UIView getScaleH:_isNavigationBar isTabBar:_isTabBar];
    float loc_ScaleW=(float)[WFUIConfig scaleOfFont];
    
    CGRect loc_frame=CGRectMake(CGRectGetMinX(frame)*loc_ScaleW, CGRectGetMinY(frame)*loc_ScaleH, CGRectGetWidth(frame)*loc_ScaleW, CGRectGetHeight(frame)*loc_ScaleH);
    [self setFrame:loc_frame];
}
//固定高和y坐标
- (void)setScaleWidthFrame:(CGRect)frame{
    float loc_ScaleW=(float)[WFUIConfig scaleOfFont];
    CGRect loc_frame=CGRectMake(CGRectGetMinX(frame)*loc_ScaleW, CGRectGetMinY(frame), CGRectGetWidth(frame)*loc_ScaleW, CGRectGetHeight(frame));
    [self setFrame:loc_frame];
}
//固定宽高和y坐标   x适配屏幕
- (void)setScaleXFrame:(CGRect)frame{
    float loc_ScaleW=(float)[WFUIConfig scaleOfFont];
    CGRect loc_frame=CGRectMake(CGRectGetMinX(frame)*loc_ScaleW, CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
    [self setFrame:loc_frame];
}

//截取多余的
+ (void)drawScaleLine:(CGRect)frame subView:(UIView *)_subView{
    [UIView drawScaleLine:frame subView:_subView isNavigationBar:NO isTabBar:NO];
}

+ (void)drawScaleLine:(CGRect)frame subView:(UIView *)_subView isNavigationBar:(BOOL)_isNavigationBar isTabBar:(BOOL)_isTabBar{
    float loc_w=frame.size.width;
    float loc_h=frame.size.height;
    UIView *lineView=[[UIView alloc]init];
    [lineView setScaleFrame:frame isNavigationBar:_isNavigationBar isTabBar:_isTabBar];
    CGRect loc_frame=lineView.frame;
    if(loc_frame.size.height>loc_frame.size.width){
        loc_frame.size.width=loc_w;
    }else{
        loc_frame.size.height=loc_h;
    }
    lineView.frame=loc_frame;
    [lineView setBackgroundColor:[self seperateColor]];
    [_subView addSubview:lineView];
}

+ (UIView *)drawBackLine:(CGRect)frame subView:(UIView *)_subView{
    UIView *lineView=[[UIView alloc] init];
    [lineView setFrame:frame];
    lineView.frame = frame;
    [lineView setBackgroundColor:[self seperateColor]];
    [_subView addSubview:lineView];
    return lineView;
}

+ (UIView *)drawLine:(CGRect)frame subView:(UIView *)_subView {
    
    return [self drawBackLine:frame subView:_subView];
}

+ (UIView *)drawLine:(CGRect)frame subView:(UIView *)_subView color:(NSString *)_color{
    UIView *lineView=[[UIView alloc]init];
    [lineView setFrame:frame];
    lineView.frame=frame;
    [lineView setBackgroundColor:[UIColor colorWithHex:_color]];
    [_subView addSubview:lineView];
    return lineView;
}

//画虚线
+ (void)drawDashedLine:(CGRect)frame subView:(UIView *)_subView color:(NSString *)_color{
    UIView *imageView1 = [[UIView alloc]initWithFrame:frame];
    [_subView addSubview:imageView1];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:imageView1.bounds];
    [shapeLayer setPosition:imageView1.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor redColor] CGColor]];
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3],
                                    [NSNumber numberWithInt:1],
                                    nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 89);
    CGPathAddLineToPoint(path, NULL, 320,89);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
}
#pragma mark 内部方法
//计算缩放倍数
+ (float)getScaleH:(BOOL)_isNavigationBar isTabBar:(BOOL)_isTabBar{
    float loc_ScreenHeight = [WFUIConfig screenHeight];
    float loc_DesignScreenHeight = [WFUIConfig designScreenHeight];
    if(_isNavigationBar) {
        loc_ScreenHeight = loc_ScreenHeight - 44;
        loc_DesignScreenHeight = loc_DesignScreenHeight - 44;
    }
    if(_isTabBar) {
        loc_ScreenHeight = loc_ScreenHeight-48;
        loc_DesignScreenHeight = loc_DesignScreenHeight-48;
    }
    return (float)(loc_ScreenHeight*1.0)/(loc_DesignScreenHeight*1.0);
}

+ (UIColor *)seperateColor {
    return [UIColor colorWithHex:@"#e7e7e7"];
}

@end
