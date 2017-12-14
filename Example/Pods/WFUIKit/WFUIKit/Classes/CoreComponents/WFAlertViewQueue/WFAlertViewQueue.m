//
//  IGAlertViewQueue.m
//  ItGirls
//
//  Created by WuShiHai on 9/6/16.
//  Copyright © 2016 微盟. All rights reserved.
//

#import "WFAlertViewQueue.h"
#import <WFFoundation/WFFoundation.h>

@interface WFAlertViewQueue ()

@property (nonatomic, strong) NSMutableArray *alertViews;
@property (nonatomic, strong) NSMutableArray *showBlocks;

@property (nonatomic, strong) NSObject *currentAlertView;

@property (nonatomic, assign) BOOL isAppLaunch;

@end

@implementation WFAlertViewQueue

+ (instancetype)sharedAlertViewQueue{
    
    static dispatch_once_t pred;
    static WFAlertViewQueue *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

+ (void)appDidLaunch{
    [WFAlertViewQueue sharedAlertViewQueue].isAppLaunch = YES;
    [[WFAlertViewQueue sharedAlertViewQueue] showAlertView];
}

+ (void)showAlertView:(NSObject *)alertView
            showBlock:(void(^)(void))showBlock{
    if (alertView && showBlock && [[WFAlertViewQueue sharedAlertViewQueue].alertViews containsObject:alertView] == NO) {
        [[WFAlertViewQueue sharedAlertViewQueue].alertViews addObject:alertView];
        [[WFAlertViewQueue sharedAlertViewQueue].showBlocks addObject:showBlock];
    }
    [[WFAlertViewQueue sharedAlertViewQueue] showAlertView];
}

+ (void)dismissAlertView:(NSObject *)alertView{
    [[WFAlertViewQueue sharedAlertViewQueue] dismissAlertView:alertView];
}

- (void)showAlertView{
    if (self.currentAlertView) {
        return;
    }

    NSObject *alertView = self.alertViews.lastObject;
    self.currentAlertView = alertView;
    
    void (^showblock)(void) = self.showBlocks.lastObject;
    
    WFBlockSafeRun(showblock);
    
}
- (void)dismissAlertView:(NSObject *)alertView{
    if (alertView) {
        NSInteger index = [self.alertViews indexOfObject:alertView];
        if (index != NSNotFound) {
            [self.alertViews removeObject:alertView];
            [self.showBlocks removeObjectAtIndex:index];
        }
    }
    self.currentAlertView = nil;
    [[WFAlertViewQueue sharedAlertViewQueue] showAlertView];
}

- (NSMutableArray *)alertViews{
    if (_alertViews) {
        return _alertViews;
    }
    _alertViews = [@[] mutableCopy];
    return _alertViews;
}
- (NSMutableArray *)showBlocks{
    if (_showBlocks) {
        return _showBlocks;
    }
    _showBlocks = [@[] mutableCopy];
    return _showBlocks;
}

@end
