//
//  NSDecimalNumber+BIYRound.h
//  BIYong
//
//  Created by majia on 2018/4/27.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (BIYRound)
+ (NSString *)BIY_StringDecimal:(NSDecimalNumber *)decNum scale:(NSInteger)scale roundMode:(NSRoundingMode)mode;

- (NSDecimalNumber *)precisionDetection;
@end
