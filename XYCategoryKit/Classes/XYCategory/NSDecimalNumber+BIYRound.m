//
//  NSDecimalNumber+BIYRound.m
//  BIYong
//
//  Created by majia on 2018/4/27.
//

#import "NSDecimalNumber+BIYRound.h"

@implementation NSDecimalNumber (BIYRound)
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
