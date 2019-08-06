//
//  UIImageView+BIY.h
//  BIYong
//
//  Created by majia on 2018/8/22.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BIY)

/**
 给imageview切角

 @param imageView
 @param corner 切角大小
 @return
 */
+ (UIImageView *)cutImageView:(UIImageView *)imageView Corner:(CGFloat)corner;

/**
 给imageview切圆角

 @param imageView
 */
+ (UIImageView *)circleImageView:(UIImageView *)imageView;
@end
