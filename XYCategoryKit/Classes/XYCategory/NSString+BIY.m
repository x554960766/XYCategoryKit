//
//  NSString+BIY.m
//  BIYong
//
//  Created by xuyi on 2018/4/13.
//

#import "NSString+BIY.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSString (BIY)

@dynamic noNullString;

- (NSString*)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)formatPriceString {
    float price = [self floatValue];
    if (price > 1) {
        return [NSString stringWithFormat:@"%.2f",price];
    }
    return self;
}


- ( NSString *)returnDecimalStringAfterPoint:(NSInteger)position
{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:self];
    
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
    
}

- (NSString *)noNullString {
    return [self stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
}

- (NSString *)precisionProblemFormat {
    double d            = [self doubleValue];
    NSString *dStr      = [NSString stringWithFormat:@"%lf", d];
    NSDecimalNumber *dn = [NSDecimalNumber decimalNumberWithString:dStr];
    return [dn stringValue];
}

- (NSString *)removeNullString {
    if ([self isEqualToString:@"(null)"]||[self isEqualToString:@"null"]|| [self isEqualToString:@"NULL"]) {
        return @"";
    }else
    {
        return self;
    }
}
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];// 以字典形式将参数返回
    NSString *parametersString = urlStr;
    NSRange range = [urlStr rangeOfString:@"?"];// 查找参数
    if (range.location != NSNotFound) {
        parametersString = [urlStr substringFromIndex:range.location + 1];
    }
    if ([parametersString containsString:@"&;"]) {// 多个参数,分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&;"];
        for (NSString *keyValuePair in urlComponents) {// 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            if (key == nil || value == nil) {// Key不能为nil
                continue;
            }
            id existValue = [params valueForKey:key];
            if (existValue != nil) {// 已存在的值,生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {// 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    [params setValue:items forKey:key];
                } else {// 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
            } else {// 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {// 单个参数 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        if (pairComponents.count == 1) {// 只有一个参数,没有值
            return nil;
        }
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        if (key == nil || value == nil) {// Key不能为nil
            return nil;
        }
        [params setValue:value forKey:key];// 设置值
    }
    return params;
}
// 将url的参数部分转化成字典
- (NSDictionary *)paramsURLString {
    
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSString *paramString = [self substringFromIndex:
                             ([self rangeOfString:@"?"].location + 1)];
    
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0] stringByRemovingPercentEncoding];
            NSString* value = [[kvPair objectAtIndex:1] stringByRemovingPercentEncoding];
            [pairs setValue:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

- (NSString *)encodeUrlString {
    if (self.length <= 0) {
        return @"";
    }
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                    NULL,
                                                                                                    kCFStringEncodingUTF8));
    return encodedString;
}


- (NSString*)stringEncodeURIComponent:(NSString *)string {
    if (self.length <= 0) {
        return @"";
    }
    return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)string,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
}

-(NSString *)numberSuitScanf:(NSString*)number{
    
    //首先验证是不是手机号码
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL isOk = [regextestmobile evaluateWithObject:number];
    if (isOk) {//如果是手机号码的话
        
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        return numberString;
    }
    return number;
}

+ (NSString *)sha1:(NSString *)input{
   
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
- (NSString *)base64String:(NSString *)string
{
    //先将string转换成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    return baseString;
}
- (NSString *)decodeBase64String:(NSString *)string {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *baseDataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return baseDataStr;
    
}
- (NSMutableAttributedString *)insertImageToString:(UIImage *)image atIndex:(NSInteger)index imageRect:(CGRect)rect{
    NSTextAttachment * textAttachment = [[NSTextAttachment alloc]init];
    textAttachment.image = image;
    textAttachment.bounds= rect;
    
    //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
    
    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    NSMutableAttributedString * finishAttribute = [[NSMutableAttributedString alloc]initWithString:self];
    [finishAttribute insertAttributedString:imageStr atIndex:index];
    return finishAttribute;
}

- (NSMutableAttributedString *)insertImageToString:(UIImage *)image atIndex:(NSInteger)index imageRect:(CGRect)rect textFont:(UIFont *)textFont textColor:(UIColor *)color {
    NSMutableAttributedString * finishAttribute = [self insertImageToString:image atIndex:index imageRect:rect];
    [finishAttribute addAttributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:color} range:NSMakeRange(0, finishAttribute.string.length)];
    return finishAttribute;
}

+ (NSInteger)findLocationString:(NSString *)string InString:(NSString *)text {
    NSRange range;
    NSInteger stringLocation;
    range = [text rangeOfString:string];
    if (range.location != NSNotFound) {
        stringLocation = range.location;
    }else{
        stringLocation = 0;
        NSLog(@"Not Found");
    }
    return stringLocation;
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<(int)[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

// 16进制转NSData
+(NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

//10进制转16进制
+(NSString *)ToHex:(uint16_t)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}


+ (NSString*) getSecrectStringWithIDNumberNo:(NSString*)accountNo
{
    NSMutableString *newStr = [NSMutableString stringWithString:accountNo];
    NSRange range = NSMakeRange(1, 16);
    if (newStr.length>=18) {
        [newStr replaceCharactersInRange:range withString:@"************"];
    }
    return newStr;
}
+ (NSString*) getSecrectStringWithNumberNo:(NSString*)accountNo{
    
    NSMutableString *newStr = [NSMutableString stringWithString:accountNo];
    NSRange range = NSMakeRange(1, accountNo.length - 2);
    if (newStr.length > 2) {
        [newStr replaceCharactersInRange:range withString:@"************"];
    }
    return newStr;
}





//加
- (NSString *)calculateByAdding:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSDecimalNumber *addingNum = [num1 decimalNumberByAdding:num2];
    return [addingNum stringValue];
}
//减
- (NSString *)calculateBySubtracting:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSDecimalNumber *subtractingNum = [num1 decimalNumberBySubtracting:num2];
    return [subtractingNum stringValue];
}
//乘
- (NSString *)calculateByMultiplying:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSDecimalNumber *multiplyingNum = [num1 decimalNumberByMultiplyingBy:num2];
    return [multiplyingNum stringValue];
}
//除
- (NSString *)calculateByDividing:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSDecimalNumber *dividingNum = [num1 decimalNumberByDividingBy:num2];
    return [dividingNum stringValue];
    
}
//幂运算
- (NSString *)calculateByRaising:(NSUInteger)power
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *raisingNum = [num1 decimalNumberByRaisingToPower:power];
    return [raisingNum stringValue];
    
}
//四舍五入
- (NSString *)calculateByRounding:(NSUInteger)scale
{
    NSDecimalNumberHandler * handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *roundingNum = [num1 decimalNumberByRoundingAccordingToBehavior:handler];
    return [roundingNum stringValue];
}
//是否相等
- (BOOL)calculateIsEqual:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSComparisonResult result = [num1 compare:num2];
    if (result == NSOrderedSame) {
        return YES;
    }
    return NO;
}
//是否大于
- (BOOL)calculateIsGreaterThan:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSComparisonResult result = [num1 compare:num2];
    if (result == NSOrderedDescending) {
        return YES;
    }
    return NO;
    
}
//是否小于
- (BOOL)calculateIsLessThan:(NSString *)stringNumer
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:stringNumer];
    NSComparisonResult result = [num1 compare:num2];
    if (result == NSOrderedAscending) {
        return YES;
    }
    return NO;
    
}

- (double)calculateDoubleValue
{
    NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:self];
    return [num doubleValue];
}


- (NSString *)urlAddkey:(NSString *)key value:(NSString *)value{
    
    if ([self rangeOfString:@"#"].location != NSNotFound) {//兼容
        return [NSString stringWithFormat:@"%@?%@=%@",self,key,value];
    }
    
    if ([self rangeOfString:@"?"].location != NSNotFound) {
        return [NSString stringWithFormat:@"%@&%@=%@",self,key,value];
    }
    
    return [NSString stringWithFormat:@"%@?%@=%@",self,key,value];
}
@end
