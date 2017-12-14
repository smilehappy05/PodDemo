//
//  NSString+YYModel.m
//  Pods
//
//  Created by WuShiHai on 09/06/2017.
//
//

#import "NSString+YYModel.h"

@implementation NSString (YYModel)

- (id)yy_stringToJSONObject{
    id jsonObject = [self p_yy_modelToJSON:self];
    
    if (jsonObject){
        return jsonObject;
    }else{
        //与H5的交互中，H5会用/进行转义，而Apple只认\，故作相应的转换
        NSString *parseString = [self stringByReplacingOccurrencesOfString:@"/\"" withString:@"\\\""];
        
        return [self p_yy_modelToJSON:parseString];
    }
}

- (id)p_yy_modelToJSON:(NSString *)string{
    NSError *error = nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    return jsonObject;
    
}

@end
