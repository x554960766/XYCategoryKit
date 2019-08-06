//
//  UIImageView+BIY.m
//  BIYong
//
//  Created by majia on 2018/8/22.
//

#import "UIImageView+BIY.h"

@implementation UIImageView (BIY)
+ (UIImageView *)cutImageView:(UIImageView *)imageView Corner:(CGFloat)corner {
    CGSize cornerRadii = CGSizeMake(corner, corner);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
    return imageView;
}
+ (UIImageView *)circleImageView:(UIImageView *)imageView {
    return [self cutImageView:imageView Corner:imageView.bounds.size.width];
}
@end
