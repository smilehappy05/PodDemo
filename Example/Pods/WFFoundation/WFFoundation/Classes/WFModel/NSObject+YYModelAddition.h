//
//  NSObject+YYModelAddition.h
//  Pods
//
//  Created by WuShiHai on 05/04/2017.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (YYModelAddition)

/**
 model转换成字典，如果失败，则返回空字典，使用时不需要进行安全检查

 @return 返回字典
 */
- (NSDictionary *)yy_modelToJSON;

@end
