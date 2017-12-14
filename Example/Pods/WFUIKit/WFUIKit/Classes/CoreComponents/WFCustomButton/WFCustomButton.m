//
//  WFCustomButton.m
//  Pods
//
//  Created by Hu on 2017/6/5.
//
//

#import "WFCustomButton.h"
#import "WFUIKitAddition.h"

@implementation WFCustomButton

- (void)into:(NSString *)imageName
       title:(NSString *)title
       frame:(CGRect)frame {
    
    [self into:imageName title:title frame:frame imageHeight:0];
}

- (void)into:(NSString *)imageName
       title:(NSString *)title
       frame:(CGRect)frame
 imageHeight:(float)height {
    
    [self intoData:[UIImage imageNamed:imageName] title:title frame:frame imageHeight:height];
}

- (void)intoData:(UIImage *)image
           title:(NSString *)title
           frame:(CGRect)frame
     imageHeight:(float)height {
    [self setScaleWidthFrame:frame];
    CGRect loc_rect = self.frame;
    _iconImgView =[[UIImageView alloc]init];
    [_iconImgView setImage:image];
    if(height == 0){
        height = _iconImgView.image.size.height;
    }
    float imgSizeW = _iconImgView.image.size.width;
    float imgSizeH = _iconImgView.image.size.height;
    if(imgSizeW == 0){
        imgSizeW=loc_rect.size.width;
        imgSizeH=loc_rect.size.height;
    }
    [_iconImgView setFrame:CGRectMake((loc_rect.size.width-imgSizeW)/2,(height-imgSizeH)/2, imgSizeW, imgSizeH)];
    [self addSubview:_iconImgView];
    if (title.length > 0)
    {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFrame:CGRectMake(0, height, loc_rect.size.width, loc_rect.size.height-height)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setText:title];
        [self addSubview:_titleLabel];
    }
    
    
    _clickBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_clickBtn setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_clickBtn setBackgroundColor:[UIColor clearColor]];
    [_clickBtn addTarget:self action:@selector(clickBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clickBtn];
}

- (void)addTarget:(id)target
           action:(SEL)action
 forControlEvents:(UIControlEvents)controlEvents {
    _supTarget = target;
    _supAction = action;
}


- (void)clickBtnEvent {    
    do {
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        [_supTarget performSelector:_supAction withObject:self];
        _Pragma("clang diagnostic pop")
    } while (0);
    
}


@end
