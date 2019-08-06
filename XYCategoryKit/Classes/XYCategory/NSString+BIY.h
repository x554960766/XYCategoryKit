//
//  NSString+BIY.h
//  BIYong
//
//  Created by xuyi on 2018/4/13.
//

#import <Foundation/Foundation.h>

@interface NSString (BIY)
@property ( nonatomic,copy) NSString * noNullString;

- (NSString*)MD5;
- (NSString *)base64String:(NSString *)string;
- (NSString *)decodeBase64String:(NSString *)string;

/// 如果是整数就
- (NSString *)formatPriceString;
- (NSString *)returnDecimalStringAfterPoint:(NSInteger)position;

/**
 精度问题转换
 
 @return
 */
- (NSString *)precisionProblemFormat;

- (NSString *)removeNullString;

/// 将url的参数部分转化成字典
- (NSDictionary *)paramsURLString;

- (NSString *)encodeUrlString;

- (NSString*)stringEncodeURIComponent:(NSString *)string;
/*
 手机号隐藏四位
 */
-(NSString *)numberSuitScanf:(NSString*)number;

+ (NSString*) getSecrectStringWithIDNumberNo:(NSString*)accountNo;

+ (NSString*) getSecrectStringWithNumberNo:(NSString*)accountNo;
//hasd值
+ (NSString*)sha1:(NSString*)input;

- (NSMutableAttributedString *)insertImageToString:(UIImage *)image atIndex:(NSInteger)index imageRect:(CGRect)rect;

- (NSMutableAttributedString *)insertImageToString:(UIImage *)image atIndex:(NSInteger)index imageRect:(CGRect)rect textFont:(UIFont *)textFont textColor:(UIColor *)color;


+ (NSInteger)findLocationString:(NSString *)string InString:(NSString *)text;

+ (NSString *)convertToJsonData:(NSDictionary *)dict;


//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;

// 16进制转NSData
+(NSData *)convertHexStrToData:(NSString *)str;

//10进制转16进制
+(NSString *)ToHex:(uint16_t)tmpid;


#pragma mark - 高精度计算

//加
- (NSString *)calculateByAdding:(NSString *)stringNumer;
//减
- (NSString *)calculateBySubtracting:(NSString *)stringNumer;
//乘
- (NSString *)calculateByMultiplying:(NSString *)stringNumer;
//除
- (NSString *)calculateByDividing:(NSString *)stringNumer;
//幂运算
- (NSString *)calculateByRaising:(NSUInteger)power;
//四舍五入
- (NSString *)calculateByRounding:(NSUInteger)scale;
//是否相等
- (BOOL)calculateIsEqual:(NSString *)stringNumer;
//是否大于
- (BOOL)calculateIsGreaterThan:(NSString *)stringNumer;
//是否小于
- (BOOL)calculateIsLessThan:(NSString *)stringNumer;
//转成小数
- (double)calculateDoubleValue;
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

- (NSString *)urlAddkey:(NSString *)key value:(NSString *)value;

@end
