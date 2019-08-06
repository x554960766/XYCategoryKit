//
//  UIView + BIY.h
//  BIYong
//
//  Created by xuyi on 2018/4/13.
//

#import <Foundation/Foundation.h>


typedef enum {
    TGReusableLabelLayoutMultiline = 1,
    TGReusableLabelLayoutHighlightLinks = 2,
    TGReusableLabelTruncateInTheMiddle = 16,
    TGReusableLabelLayoutHighlightCommands = 32,
    TGReusableLabelLayoutOffsetLastLine = 64
} BIYVViewBorder;

typedef enum :NSInteger{
    
    BIYShadowPathLeft,
    
    BIYShadowPathRight,
    
    BIYShadowPathTop,
    
    BIYShadowPathBottom,
    
    BIYShadowPathNoTop,
    
    BIYShadowPathAllSide
    
} BIYShadowPathSide;

@interface UIView (BIY)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic,assign) CGFloat bottomX;//x方向的尾部坐标
@property (nonatomic,assign) CGFloat bottomY;//y方向的尾部坐标

@property (nonatomic,assign) bool shouldAnimateShadowPath;//y方向的尾部坐标



-(UIViewController*)viewController;
+(UIViewController*)GetviewController;

/**
 切割圆角view
 
 @param rectCorner 想要切割角
 @param cornSize 切割的半径
 */
- (void)BIY_clipViewWithRectCorner:(UIRectCorner)rectCorner andCornerRadi:(CGSize)cornSize;

/**
 通过view生成图片
 
 @param view
 @param size
 @return image
 */
- (UIImage *)BIY_makeImageWithView:(UIView *)view withSize:(CGSize)size;


/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLineWithlineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;


- (void)drawFrameDashLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineHeight:(int)lineHeight corner:(float)corner;

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

-(void)BIY_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(BIYShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;


- (void)updataShandowPath;
@end
