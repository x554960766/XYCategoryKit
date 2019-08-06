//
//  UITextField+BIYRange.h
//  BIYong
//
//  Created by majia on 2018/5/9.
//

#import <UIKit/UIKit.h>

@interface UITextField (BIYRange)
- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;

@end
