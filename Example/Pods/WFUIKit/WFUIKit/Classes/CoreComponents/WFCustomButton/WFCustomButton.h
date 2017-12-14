//
//  WFCustomButton.h
//  Pods
//
//  Created by Hu on 2017/6/5.
//
//

#import <UIKit/UIKit.h>

@interface WFCustomButton : UIView

@property (weak) id supTarget;
@property (nonatomic, assign) SEL supAction;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *clickBtn;


/**
 自定义 button

 @param imageName 图片名称
 @param title 标题
 @param frame frame
 */
- (void)into:(NSString *)imageName
       title:(NSString *)title
       frame:(CGRect)frame;

/**
 自定义 button

 @param imageName 图片名称
 @param title 标题
 @param frame frame
 @param height 图片高度
 */
- (void)into:(NSString *)imageName
       title:(NSString *)title
       frame:(CGRect)frame
 imageHeight:(float)height;

/**
 自定义 button

 @param image 图片
 @param title 标题
 @param frame frame
 @param height 图片高度
 */
- (void)intoData:(UIImage *)image
           title:(NSString *)title
           frame:(CGRect)frame
     imageHeight:(float)height;

/**
 自定义 button 的事件响应

 @param target 事件响应者
 @param action 事件
 @param controlEvents 事件响应的触发条件
 */
- (void)addTarget:(id)target
           action:(SEL)action
 forControlEvents:(UIControlEvents)controlEvents;

@end
