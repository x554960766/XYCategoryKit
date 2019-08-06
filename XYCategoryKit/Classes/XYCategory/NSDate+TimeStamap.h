//
//  NSDate+TimeStamap.h
//  BIYong
//
//  Created by caohx on 2018/8/1.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeStamap)
+(NSDate *)UTCDateFromTimeStamap:(NSString *)timeStamap;

+ (NSString *) compareCurrentTime:(NSString *)str;
@end
