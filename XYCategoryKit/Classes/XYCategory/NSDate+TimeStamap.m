//
//  NSDate+TimeStamap.m
//  BIYong
//
//  Created by caohx on 2018/8/1.
//

#import "NSDate+TimeStamap.h"

@implementation NSDate (TimeStamap)
//将时间戳转化成 date
+(NSDate *)UTCDateFromTimeStamap:(NSString *)timeStamap{
    
    NSTimeInterval timeInterval =[timeStamap doubleValue]/1000;
    //  /1000;传入的时间戳timeStamap如果是精确到毫秒的记得要/1000
    NSDate *UTCDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    return UTCDate;
}
+ (NSString *) compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
//    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

@end
