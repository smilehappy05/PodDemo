//
//  BaseLabel.m
//  SmartPlan
//
//  Created by WuShiHai'sMac on 25/02/2017.
//  Copyright © 2017 WS. All rights reserved.
//

#import "WFLabel.h"
#import <WFFoundation/WFFoundation.h>
#import <YYModel/YYModel.h>

#import "UIColor+WFAddition.h"
#import "UIApplication+WFAddition.h"

@interface WFLabel()

//原数据
@property (nonatomic, strong) NSString *_text;

@property (nonatomic, strong) WFTagConvert *convert;

@property (nonatomic, strong) NSString *router;
@property (nonatomic, assign) NSInteger numberOfRouters;

@property (nonatomic, strong) NSTextContainer *textContainer;
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSLayoutManager *layoutManager;

@end

@implementation WFLabel

- (instancetype)init{
    if ([super init]) {
    }
    return self;
}

- (CGSize)sizeThatFitsWidth:(CGFloat)width{
    return [self sizeThatFitsSize:CGSizeMake(width, CGFLOAT_MAX)];
}

- (CGSize)sizeThatFitsHeight:(CGFloat)height{
    return [self sizeThatFitsSize:CGSizeMake(CGFLOAT_MAX, height)];
}

- (CGSize)sizeThatFitsSize:(CGSize)size{
    self.lineBreakMode = NSLineBreakByWordWrapping;
    if (self.attributedText) {
        
        CGRect rect = [self.attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
        
    }else{
        size = WF_MULTILINE_TEXTSIZE(self.text, self.font, size, 0);
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
}

- (void)openLink:(NSString *)router key:(NSString *)key {
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textContainer.size = self.bounds.size;
}

#pragma mark - Set
- (void)setWf_lineSpacing:(CGFloat)wf_lineSpacing {
    _wf_lineSpacing = wf_lineSpacing;
    if (__text.length > 0) {
        [self setText:__text];
    }
}

#pragma mark - Draw Text
- (void)setText:(NSString *)text
{
    __text = text;
    
    if (!text) {
        text = @"";
    }
    
    self.convert = [WFTagConvertUtil extract:text];
    
    if (_convert.parsers.count > 0) {
        [self parseAttributeString];
        
        if (self.numberOfRouters > 0) {
            self.userInteractionEnabled = YES;
        }
        
        //多点触摸事件时，才需要使用layout进行布局
        if (self.numberOfRouters > 1) {
            
            [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)]];
            
            NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
            NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
            NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
            
            // Configure layoutManager and textStorage
            [layoutManager addTextContainer:textContainer];
            [textStorage addLayoutManager:layoutManager];
            
            // Configure textContainer
            textContainer.lineFragmentPadding = 0.0;
            textContainer.lineBreakMode = NSLineBreakByWordWrapping;
            textContainer.maximumNumberOfLines = self.numberOfLines;
            
            self.layoutManager = layoutManager;
            self.textContainer = textContainer;
            self.textStorage = textStorage;
            
        }
    }else{
        if (_wf_lineSpacing > 0) {
            NSMutableAttributedString *attributedString = [self baseAttributedString];
            self.attributedText = [attributedString copy];
        }else {
            [super setText:text];
        }
    }
}


- (void)parseAttributeString{
    if (_convert.plainText.length > 0) {
        NSMutableAttributedString *attributedString = [self baseAttributedString];
        self.numberOfRouters = 0;
        
        [_convert.parsersInRange enumerateKeysAndObjectsUsingBlock:^(NSValue * _Nonnull key, NSArray<WFTagParser *> * _Nonnull obj, BOOL * _Nonnull stop) {
            [self parseAttributeString:attributedString
                               parsers:obj
                                 range:key.rangeValue];
        }];
        
        self.attributedText = [attributedString copy];
    }
}

- (void)parseAttributeString:(NSMutableAttributedString *)attributedString
                     parsers:(NSArray<WFTagParser *> *)parsers
                       range:(NSRange)range {
    NSMutableDictionary *attributes = [@{} mutableCopy];
    __block BOOL isBold = NO;
    [parsers enumerateObjectsUsingBlock:^(WFTagParser * _Nonnull parser, NSUInteger idx, BOOL * _Nonnull stop) {
        if (parser.text.length > 0) {
            if ([parser.tag isEqualToString:@"a"]) {
                NSString *router = [parser.attributes objectForKey:@"href"];
                if ([router isKindOfClass:[NSString class]]) {
                    self.router = [[router stringByReplacingOccurrencesOfString:@"'" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                    self.numberOfRouters++;
                }
            }else if ([parser.tag isEqualToString:@"font"]) {
                if ([parser.attributes objectForKey:@"size"]) {
                    NSString *size = [parser.attributes objectForKey:@"size"];
                    [attributes setObject:[UIFont systemFontOfSize:size.floatValue] forKey:NSFontAttributeName];
                }
                if ([parser.attributes objectForKey:@"color"]) {
                    NSString *colorStr = [[[parser.attributes objectForKey:@"color"] stringByReplacingOccurrencesOfString:@"'" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                    UIColor *color = [UIColor colorWithHex:colorStr];
                    if (color) {
                        [attributes setObject:color forKey:NSForegroundColorAttributeName];
                    }
                }
            }else if ([parser.tag isEqualToString:@"b"]) {
                isBold = YES;
            }
        }
    }];
    if (isBold) {
        UIFont *font = [attributes objectForKey:NSFontAttributeName]?:self.font;
        [attributes setObject:[UIFont boldSystemFontOfSize:font.pointSize] forKey:NSFontAttributeName];
    }
    if (attributes.allKeys.count > 0) {
        [self safe_setAttributes:attributedString attrs:attributes range:range];
    }
}

- (void)safe_setAttributes:(NSMutableAttributedString *)attributedString attrs:(NSDictionary<NSString *, id> *)attrs range:(NSRange)range{
    if (attrs && range.location + range.length <= attributedString.length) {
        [attributedString setAttributes:attrs range:range];
    }
}

#pragma mark - Override
- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode{
    [super setLineBreakMode:lineBreakMode];
    
    self.textContainer.lineBreakMode = lineBreakMode;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines{
    [super setNumberOfLines:numberOfLines];
    
    self.textContainer.maximumNumberOfLines = numberOfLines;
}

#pragma mark - Setter
- (void)setRouter:(NSString *)router{
    if (router.length > 0) {
        self.userInteractionEnabled = YES;
    }
    _router = router;
}

#pragma mark - Touch
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_router) {
        [self wf_openRouter:_router key:_convert.plainText];
    }else{
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)handleTapOnLabel:(UITapGestureRecognizer *)tapGesture
{
    
    CGPoint locationOfTouchInLabel = [tapGesture locationInView:tapGesture.view];
    CGSize labelSize = tapGesture.view.bounds.size;
    CGRect textBoundingBox = [self.layoutManager usedRectForTextContainer:self.textContainer];
    
    CGFloat textContainerOffsetX = 0;
    if (self.textAlignment == NSTextAlignmentCenter) {
        textContainerOffsetX = (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x;
    }else if (self.textAlignment == NSTextAlignmentRight){
        textContainerOffsetX = (labelSize.width - textBoundingBox.size.width) - textBoundingBox.origin.x;
    }
    CGPoint textContainerOffset = CGPointMake(textContainerOffsetX,
                                              (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
    
    
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                         locationOfTouchInLabel.y - textContainerOffset.y);
    NSInteger indexOfCharacter = [self.layoutManager characterIndexForPoint:locationOfTouchInTextContainer
                                                            inTextContainer:self.textContainer
                                   fractionOfDistanceBetweenInsertionPoints:nil];
    
    [_convert.parsers enumerateObjectsUsingBlock:^(WFTagParser * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = NSMakeRange(obj.location, obj.text.length);
        if (NSLocationInRange(indexOfCharacter, range)) {
            NSString *router = [obj.attributes objectForKey:@"href"];
            if ([router isKindOfClass:[NSString class]]) {
                router = [[router stringByReplacingOccurrencesOfString:@"'" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                [self wf_openRouter:router key:obj.text];
                *stop = YES;
            }
        }
    }];
    
}

- (void)wf_openRouter:(NSString *)router key:(NSString *)key{
    [self openLink:router key:key];
    NSString * method = @"wf_openLink:key:";
    SEL selector = NSSelectorFromString(method);
    if ([self respondsToSelector:selector]) {
        ((void (*)(id, SEL, NSString *, NSString *))[self methodForSelector:selector])(self, selector, router, key);
    }
}

#pragma mark - Private Method
- (NSMutableAttributedString *)baseAttributedString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_convert.plainText];
    NSMutableDictionary *attributes = [@{} mutableCopy];
    [attributes setObject:self.font forKey:NSFontAttributeName];
    [attributes setObject:self.textColor forKey:NSForegroundColorAttributeName];
    [self safe_setAttributes:attributedString attrs:attributes range:NSMakeRange(0, attributedString.length)];
    
    // 调整行间距
    if (_wf_lineSpacing > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:_wf_lineSpacing];
        [attributedString addAttribute:NSParagraphStyleAttributeName
                                 value:paragraphStyle
                                 range:NSMakeRange(0, [_convert.plainText length])];
    }
    
    return attributedString;
}
+ (NSArray<NSString *> *)ml_arrarOfLastParsers {
    static dispatch_once_t onceToken;
    static NSArray<NSString *> *keys = nil;
    dispatch_once(&onceToken, ^{
        keys = @[@"b"];
    });
    return keys;
}

@end

@implementation WFLabelTest

+ (void)showTest{
    [self testBoldLabel];
}

+ (void)testCommon{
    WFLabel *label = [[WFLabel alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    label.textColor = [UIColor blackColor];
    //    label.font = Font(15);
    label.text = @"<a href='http://www.baidu.com'>ljaskldfj</a> <a href='http://stackoverflow.com/questions/1256887/create-tap-able-links-in-the-nsattributedstring-of-a-uilabel'>stackoverflow.com</a>";
    
    [[UIApplication displayWindow] addSubview:label];
}

+ (void)testBoldLabel{
    WFLabel *label = [[WFLabel alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    label.textColor = [UIColor blackColor];
    //    label.font = Font(15);
    label.text = @"<b>ljaskldfj</b><b><font size=30 >stackoverflow.com</font></b>";
    
    [[UIApplication displayWindow] addSubview:label];
}

@end
