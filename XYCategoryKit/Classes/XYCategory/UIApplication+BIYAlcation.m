//
//  UIApplication+BIYAlcation.m
//  BIYong
//
//  Created by baige on 2018/5/3.
//

#import "UIApplication+BIYAlcation.h"

@implementation UIApplication (BIYAlcation)

- (void)biyOpenURL:(NSURL*)url options:(NSDictionary<NSString *, id> *)options completionHandler:(void (^ __nullable)(BOOL success))completion{
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 10.0) {
        [[UIApplication sharedApplication] openURL:url options:options completionHandler:completion];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
