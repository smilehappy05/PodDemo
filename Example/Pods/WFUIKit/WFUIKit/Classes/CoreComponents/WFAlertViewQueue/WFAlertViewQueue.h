//
//  IGAlertViewQueue.h
//  ItGirls
//
//  Created by WuShiHai on 9/6/16.
//  Copyright © 2016 微盟. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  为了避免定制的弹框同时弹出，特定义此类，全局弹框需通过调用该类进行管理
 */
@interface WFAlertViewQueue : NSObject

+ (void)appDidLaunch;

+ (void)showAlertView:(NSObject *)alertView showBlock:(void(^)(void))showBlock;
+ (void)dismissAlertView:(NSObject *)alertView;

@end
