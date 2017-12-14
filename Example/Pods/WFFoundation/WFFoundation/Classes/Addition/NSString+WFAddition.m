//
//  NSString+Additions.m
//  Loan
//
//  Created by Hu on 2017/4/19.
//  Copyright © 2017年 Shanghai Mengdian Information Technology Co., Ltd. All rights reserved.
//

#import "NSString+WFAddition.h"

@implementation NSString (WFAddition)

- (BOOL)isPhone {
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (NSString *)formatPhone{
    if (self.length <= 3) {
        return self;
    }
    
    NSInteger leftLength = self.length - 3;
    NSInteger index = leftLength / 4;
    if (leftLength % 4 == 0) {
        index--;
    }
    NSMutableString *whiteSpceText = [self mutableCopy];
    [whiteSpceText insertString:@" " atIndex:3];
    for(int i = 1 ; i <= index ; i++){
        [whiteSpceText insertString:@" " atIndex: 4 + i * 5 - 1];
    }
    return whiteSpceText;
}

- (NSString *)trimAllSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)replaceEmojiWithString:(NSString *)replaceString {
    
    NSString *emojiPattern1 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900-\\U0001F9FF]"; //Code Points with default emoji representation
    NSString *emojiPattern2 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900–\\U0001F9FF]\\uFE0F"; //Characters with emoji variation selector
    NSString *emojiPattern3 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900–\\U0001F9FF][\\U0001F3FB-\\U0001F3FF]"; //Characters with emoji modifier
    NSString *emojiPattern4 = @"[\\U0001F1E6-\\U0001F1FF][\\U0001F1E6-\\U0001F1FF]"; //2-letter flags
    NSString *pattern = [NSString stringWithFormat:@"\(%@)|\(%@)|\(%@)|\(%@)", emojiPattern4, emojiPattern3, emojiPattern2, emojiPattern1];
    NSString *regex = [NSString stringWithFormat:@"(?:\(%@))(?:\\u200D(?:\(%@)))*", pattern, pattern];
    NSError *error = nil;
    NSRegularExpression *express = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&error];
    NSString *newString = [express stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:replaceString];
    return newString;
}

- (NSString *)lastPathComponentEscapingParamters{
    NSString *lastPathComponent = self.lastPathComponent;
    if (lastPathComponent.length > 0) {
        return [lastPathComponent componentsSeparatedByString:@"?"].firstObject;
    }
    return nil;
}

@end
