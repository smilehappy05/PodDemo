//
//  BaseViewController.m
//  SmartPlan
//
//  Created by WuShiHai'sMac on 25/02/2017.
//  Copyright © 2017 WS. All rights reserved.
//

#import "WFViewController.h"

@interface WFViewController ()<UINavigationBarDelegate>

@property (nonatomic, strong, readwrite) WFView *contentView;

@end

@implementation WFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - init
- (WFView *)contentView{
    if (_contentView) {
        return _contentView;
    }
    
    _contentView = [[WFView alloc] init];
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
    [self.view sendSubviewToBack:_contentView];

    return _contentView;
}


@end
