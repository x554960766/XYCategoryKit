//
//  UIView + BIY.m
//  BIYong
//
//  Created by xuyi on 2018/4/13.
//

#import "UIView + BIY.h"

@implementation UIView (BIY)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)bottomX{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottomY{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottomY:(CGFloat)bottomY{
    self.y = bottomY - self.height;
}

- (void)setBottomX:(CGFloat)bottomX{
    //  self.y = bottomY - self.height;
    CGRect frame = self.frame;
    frame.origin.x = bottomX - self.frame.size.width;
    self.frame = frame;
    
}


+ (UIViewController *)GetviewController{
    UIView *view = [[UIView alloc] init];
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]] && ![nextResponder isKindOfClass:[UINavigationController class]])
        {
            return (UIViewController*)nextResponder;
        }
        else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            UINavigationController * tempNav = (UINavigationController *)nextResponder;
            return tempNav.topViewController;
        }
    }
    return nil;
}
-(UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]] && ![nextResponder isKindOfClass:[UINavigationController class]])
        {
            return (UIViewController*)nextResponder;
        }
        else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            UINavigationController * tempNav = (UINavigationController *)nextResponder;
            return tempNav.topViewController;
        }
    }
    return nil;
}
- (void)BIY_clipViewWithRectCorner:(UIRectCorner)rectCorner andCornerRadi:(CGSize)cornSize{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
#pragma mark 生成image
- (UIImage *)BIY_makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}


/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLineWithlineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (void)drawFrameDashLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineHeight:(int)lineHeight corner:(float)corner{
    CAShapeLayer *border = [CAShapeLayer layer];
    /* 虚线的颜色 */
    border.strokeColor = lineColor.CGColor;
    /* 填充虚线内的颜色 */
    border.fillColor = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:corner];
    
    //设置路径
    border.path = path.CGPath;
    
    border.frame = self.bounds;
    //虚线的宽度
    border.lineWidth = lineHeight;
    
    border.lineDashPattern = @[[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing]];
    
    [self.layer addSublayer:border];
}


/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 */

-(void)BIY_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(BIYShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth
{
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = shadowColor.CGColor;
    
    self.layer.shadowOpacity = shadowOpacity;
    
    self.layer.shadowRadius =  shadowRadius;
    
    self.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    
    CGFloat originX = 0;
    
    CGFloat originY = 0;
    
    CGFloat originW = self.bounds.size.width;
    
    CGFloat originH = self.bounds.size.height;
    
    
    switch (shadowPathSide) {
        case BIYShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case BIYShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
            
        case BIYShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
            
        case BIYShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case BIYShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case BIYShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
            
    }
    
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    
    self.layer.shadowPath = path.CGPath;
    
}

- (void)updataShandowPath {
    CAAnimation *animation = [self.layer animationForKey:@"bounds.size"];
    if (animation) {
        // 通过CABasicAnimation类来为shadowPath添加动画
        CABasicAnimation *shadowPathAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
        // 根据bounds的动画属性设置shadowPath的动画属性
        shadowPathAnimation.timingFunction = animation.timingFunction;
        shadowPathAnimation.duration = animation.duration;
        // iOS8 bounds的隐式动画默认开启了additive属性，当前一次bounds change的动画还在进行中时，
        // 新的bounds change动画将会被叠加在之前的上，从而让动画更加顺滑
        // 然而shadowPath并不支持additive animation，所以当多个动画叠加，将会看到shadowPath和bounds动画不一致的现象
        // shadowPathAnimation.additive = YES;
        
        // 设置shadowAnimation的新值，未设置from，则from属性将默认为当前shadowPath的状态
        shadowPathAnimation.toValue = [UIBezierPath bezierPathWithRect:self.layer.bounds];
        
        // 将动画添加至layer的渲染树
        [self.layer addAnimation:shadowPathAnimation forKey:@"shadowPath"];
    }
    // 根据苹果文档指出的，显式动画只会影响动画效果，而不会影响属性的的值，所以这两为了持久化shadowPath的改变需要进行属性跟新
    // 同时也处理了bounds非动画改变的情况
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath;
}




@end
