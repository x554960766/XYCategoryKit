//
//  NSDictionary+category.h
//  BiYong
//
//  Created by 马嘉 on 2018/2/7.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (category)

/**
 data转字典or数组

 @param jsonData
 @return 
 */
+(id)toArrayOrNSDictionary:(NSData *)jsonData;

/**
 字典转字符串

 @param dic
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 字符串转字典

 @param jsonString
 @return
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSDictionary *)decodeUrlStringToDict:(NSString *)string;

@end
