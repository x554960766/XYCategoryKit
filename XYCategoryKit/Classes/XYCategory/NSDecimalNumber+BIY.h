//
//  NSDecimalNumber+BIY.h
//  BIYong
//
//  Created by xuyi on 2018/7/31.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (BIY)

+ (NSString *)BIY_StringDecimal:(NSDecimalNumber *)decNum scale:(NSInteger)scale roundMode:(NSRoundingMode)mode;


- (NSString *)stringValueWithScale:(NSUInteger)scale;

/**
 精度格式化

 @param scale 精度位数(现在写死10位)
 @return <#return value description#>
 */
- (NSDecimalNumber *)formatNumberWithScale:(NSUInteger)scale;

- (NSDecimalNumber *)precisionDetection;

@end
