//
//  NSObject+BIYCrashProtect.h
//  BIYong
//
//  Created by baige on 2018/8/20.
//

#import <Foundation/Foundation.h>

/*
 主要为了保护 unrecognized selector sent to instance xxx
 debug 环境下 会alert
 */

@interface NSObject (BIYCrashProtect)

@end
