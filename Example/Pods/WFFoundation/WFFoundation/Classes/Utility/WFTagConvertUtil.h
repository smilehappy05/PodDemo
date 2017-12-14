//
//  WFLabelParserUtil.h
//  Pods
//
//  Created by Suhayl on 13/10/2017.
//
//

#import <Foundation/Foundation.h>

@class WFTagConvert;
@class WFTagParser;
@interface WFTagConvertUtil : NSObject

/**
 解析xml格式数据
 
 @param text 数据源
 @return 结果
 */
+ (WFTagConvert *)extract:(NSString *)text;

/**
 分割段落
 
 @param text 数据源
 @return 结果
 */
+ (NSArray<NSString *> *)splitParagraph:(NSString *)text;

/**
 解析xml数据
 
 @param text 数据源
 @param isParsePTag 是否自动处理<p>标签
 @return 结果
 */
+ (WFTagConvert *)extract:(NSString *)text
              isParsePTag:(BOOL)isParsePTag;

@end


@interface WFTagConvert : NSObject

/**
 对parser进行分解，NSValue 为[NSValue valueWithRange:], 以Range为基础，进行每个Range上的映射Parsers
 */
@property (nonatomic, strong) NSDictionary<NSValue *,NSArray<WFTagParser *> *> *parsersInRange;

/**
 所有的tag parser
 */
@property (nonatomic, strong) NSArray<WFTagParser *> *parsers;

/**
 原文本
 */
@property (nonatomic, strong) NSString *text;

/**
 纯文本
 */
@property (nonatomic, strong) NSString *plainText;

@end


@interface WFTagParser : NSObject<NSCopying>

+ (instancetype)initWithString:(NSString*)aText
                           tag:(NSString*)tag
                    attributes:(NSDictionary *)attributes;

/**
 parser对应的纯文本
 */
@property (nonatomic, strong) NSString *text;

/**
 对应的标签，如p、a等
 */
@property (nonatomic, strong) NSString *tag;

/**
 parser对应的起始位置
 */
@property (nonatomic, assign) NSInteger location;

/**
 对应的范围
 */
@property (nonatomic, assign) NSRange range;

/**
 属性
 */
@property (nonatomic, strong) NSDictionary *attributes;

@end




