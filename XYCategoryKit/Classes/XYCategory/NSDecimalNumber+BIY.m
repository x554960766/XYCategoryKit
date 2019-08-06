//
//  NSDecimalNumber+BIY.m
//  BIYong
//
//  Created by xuyi on 2018/7/31.
//

#import "NSDecimalNumber+BIY.h"

@implementation NSDecimalNumber (BIY)

- (NSString *)stringValueWithScale:(NSUInteger)scale {
    return self ?  [[self  formatNumberWithScale:scale] stringValue] : @"0";
}

- (NSDecimalNumber *)formatNumberWithScale:(NSUInteger)scale {
    if (self == nil) {
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    NSDecimalNumberHandler * handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    NSDecimalNumber *roundingNum = [self decimalNumberByRoundingAccordingToBehavior:handler];
    return roundingNum;
}

+ (NSString *)BIY_StringDecimal:(NSDecimalNumber *)decNum scale:(NSInteger)scale roundMode:(NSRoundingMode)mode {
    NSDecimalNumberHandler *round = [NSDecimalNumberHandler
                                     decimalNumberHandlerWithRoundingMode:mode
                                     scale:(short)scale
                                     raiseOnExactness:NO
                                     raiseOnOverflow:NO
                                     raiseOnUnderflow:NO
                                     raiseOnDivideByZero:NO];
    NSDecimalNumber * decNumber = [decNum decimalNumberByRoundingAccordingToBehavior: round];
    return [decNumber stringValue];
}

- (NSDecimalNumber *)precisionDetection{
    
    double testDouble = [self doubleValue];
    
    NSString *doubleString = [NSString stringWithFormat:@"%0.8f", testDouble];
    
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    
    return decNumber;
}

@end
