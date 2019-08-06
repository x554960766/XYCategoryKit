//
//  UIApplication+BIYAlcation.h
//  BIYong
//
//  Created by baige on 2018/5/3.
//

#import <UIKit/UIKit.h>

@interface UIApplication (BIYAlcation)

- (void)biyOpenURL:(NSURL*_Nonnull)url options:(NSDictionary<NSString *, id> *)options completionHandler:(void (^ __nullable)(BOOL success))completion;

@end
