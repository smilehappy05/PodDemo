//
//  WFTagParserUtil.m
//  Pods
//
//  Created by Suhayl on 13/10/2017.
//
//

#import "WFTagConvertUtil.h"
#import "YYModel.h"

@implementation WFTagConvert


@end

@implementation WFTagParser

+ (instancetype)initWithString:(NSString*)aText
                           tag:(NSString*)tag
                    attributes:(NSMutableDictionary*)attributes{
    return [[self alloc] initWithString:aText
                                    tag:tag
                             attributes:attributes];
}

- (instancetype)initWithString:(NSString*)aText
                           tag:(NSString*)tag
                    attributes:(NSDictionary *)attributes{
    if (self = [self init]) {
        _tag = [tag copy];
        _attributes = attributes;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

@end


@implementation WFTagConvertUtil

+ (WFTagConvert *)extract:(NSString *)text
              isParsePTag:(BOOL)isParsePTag {
    
    WFTagConvert *convert = [[WFTagConvert alloc] init];
    convert.text = text;
    
    NSMutableString *newText = [NSMutableString stringWithString:text];
    [newText replaceOccurrencesOfString:@"<br\\s*/?>"
                             withString:@"\n"
                                options:NSRegularExpressionSearch
                                  range:NSMakeRange(0, newText.length)];
    [newText replaceOccurrencesOfString:@"&nbsp;"
                             withString:@" "
                                options:NSRegularExpressionSearch
                                  range:NSMakeRange(0, newText.length)];
    
    text = [newText copy];
    
    if ([text containsString:@"</"] == NO) {
        convert.plainText = text;
        return convert;
    }
    
    NSScanner *scanner = nil;
    NSString *scanText = nil;
    NSString *tag = nil;
    NSString *paragraphReplacement = @"\n";
    NSMutableDictionary<NSValue *,NSArray<WFTagParser *> *> *parsersInRange = [@{} mutableCopy];
    NSMutableArray<WFTagParser *> *parsers = [@[] mutableCopy];
    //记录还未找到</ 结尾的Parser，用于rangeOfParsers 的转化
    NSMutableArray<WFTagParser *> *unmatchParsers = [NSMutableArray array];
    NSRange lastMatchParderRange = NSMakeRange(0, 0);
    
    NSInteger last_position = 0;
    scanner = [NSScanner scannerWithString:text];
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:NULL];
        [scanner scanUpToString:@">" intoString:&scanText];
        
        NSString *delimiter = [NSString stringWithFormat:@"%@>", scanText];
        NSInteger position = [text rangeOfString:delimiter].location;
        if (position != NSNotFound)
        {
            if (isParsePTag && [delimiter rangeOfString:@"<p"].location==0)
            {
                text = [text stringByReplacingOccurrencesOfString:delimiter
                                                       withString:paragraphReplacement
                                                          options:NSCaseInsensitiveSearch
                                                            range:NSMakeRange(last_position, position+delimiter.length-last_position)];
            }
            else
            {
                text = [text stringByReplacingOccurrencesOfString:delimiter
                                                       withString:@""
                                                          options:NSCaseInsensitiveSearch
                                                            range:NSMakeRange(last_position, position + delimiter.length - last_position)];
            }
            
            text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            text = [text stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        }
        
        if ([scanText rangeOfString:@"</"].location == 0){
            // end of tag
            tag = [scanText substringFromIndex:2];
            if (position != NSNotFound){
                __block WFTagParser *matchParser = nil;
                [parsers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(WFTagParser * _Nonnull parser, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (parser.text == nil && [parser.tag isEqualToString:tag]) {
                        parser.range = NSMakeRange(parser.location, position - parser.location);
                        parser.text = [text substringWithRange:parser.range];
                        matchParser = parser;
                        *stop = YES;
                    }
                }];
                //一段range上尽可能多的tag
                if (matchParser) {
                    NSRange range = NSMakeRange(matchParser.location, matchParser.range.length);
                    NSValue *rangeValue = [NSValue valueWithRange:range];
                    if (NSEqualRanges(range, lastMatchParderRange)) {
                        __block NSArray *lastMatchParsers = nil;
                        [parsersInRange enumerateKeysAndObjectsUsingBlock:^(NSValue * _Nonnull key, NSArray<WFTagParser *> * _Nonnull obj, BOOL * _Nonnull stop) {
                            if (NSEqualRanges(key.rangeValue, lastMatchParderRange)) {
                                lastMatchParsers = obj;
                                *stop = YES;
                            }
                        }];
                        NSMutableArray *mergeParsers = [@[] mutableCopy];
                        [mergeParsers addObjectsFromArray:lastMatchParsers];
                        [mergeParsers addObjectsFromArray:unmatchParsers];
                        [parsersInRange setObject:[mergeParsers copy] forKey:rangeValue];
                    }else {
                        //对数组内的对象不copy，不修改其中的字段值，不会影响到parsers 中的数据
                        [parsersInRange setObject:@[matchParser] forKey:rangeValue];
                    }
                    lastMatchParderRange = range;
                    [unmatchParsers removeObject:matchParser];
                }
            }
        }
        else{
            // start of tag
            NSArray *textComponents = [[scanText substringFromIndex:1] componentsSeparatedByString:@" "];
            tag = [textComponents objectAtIndex:0];
            if (tag.length > 0) {
                NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
                for (int i=1; i<[textComponents count]; i++)
                {
                    NSArray *pair = [[textComponents objectAtIndex:i] componentsSeparatedByString:@"="];
                    if ( [pair count] >= 2 )
                    {
                        [attributes setObject:[[pair subarrayWithRange:NSMakeRange(1, [pair count] - 1)] componentsJoinedByString:@"="] forKey:[pair objectAtIndex:0]];
                    }
                }
                
                WFTagParser *parser = [WFTagParser initWithString:nil
                                                              tag:tag
                                                       attributes:attributes];
                parser.location = position;
                [parsers addObject:parser];
                [unmatchParsers addObject:parser];
            }
        }
        
        last_position = position;
    }
    
    convert.parsersInRange = [parsersInRange copy];
    convert.parsers = [parsers copy];
    convert.plainText = text;
    
    return convert;
}

+ (NSArray<NSString *> *)splitParagraph:(NSString *)text{
    
    if (!text) {
        return nil;
    }
    
    NSMutableString *newText = [NSMutableString stringWithString:text];
    [newText replaceOccurrencesOfString:@"<br\\s*/?>"
                             withString:@"\n"
                                options:NSRegularExpressionSearch
                                  range:NSMakeRange(0, newText.length)];
    [newText replaceOccurrencesOfString:@"&nbsp;"
                             withString:@" "
                                options:NSRegularExpressionSearch
                                  range:NSMakeRange(0, newText.length)];
    
    text = [newText copy];
    
    if ([text containsString:@"</"] == NO) {
        return @[text];
    }
    
    NSScanner *scanner = nil;
    NSString *scanText = nil;
    
    NSMutableArray<NSString *> *paragraphs = [@[] mutableCopy];
    NSMutableArray<NSString *> *unmatchTags = [NSMutableArray array];
    
    NSInteger last_position = 0;
    
    scanner = [NSScanner scannerWithString:text];
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:NULL];
        [scanner scanUpToString:@">" intoString:&scanText];
        
        if (scanText.length > 0) {
            NSString *delimiter = [NSString stringWithFormat:@"%@>", scanText];
            if ([delimiter containsString:@"/"]) {
                NSInteger index = [unmatchTags indexOfObject:[delimiter stringByReplacingOccurrencesOfString:@"/" withString:@""]];
                if (index != NSNotFound) {
                    [unmatchTags removeObjectAtIndex:index];
                    if (unmatchTags.count == 0) {
                        NSString *paragraph = [text substringWithRange:NSMakeRange(last_position, scanner.scanLocation - last_position + 1)];
                        [paragraphs addObject:paragraph];
                        last_position = scanner.scanLocation + 1;
                    }
                }else {
                    
                }
            }else {
                [unmatchTags addObject:delimiter];
            }
        }
    }
    
    if (last_position < text.length - 1) {
        NSString *paragraph = [text substringWithRange:NSMakeRange(last_position, text.length - last_position)];
        [paragraphs addObject:paragraph];
    }
    
    return paragraphs;
}

+ (WFTagConvert *)extract:(NSString *)text {
    return [self extract:text
             isParsePTag:YES];
}

@end
