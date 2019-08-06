//
//  UIImage+BIY.h
//  BIYong
//
//  Created by xuyi on 2018/4/13.
//

#import <UIKit/UIKit.h>

@interface UIImage (BIY)

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;



/// 根据颜色生成图片
+ (UIImage *)lbd_imageFromColor:(UIColor *)color andHeight:(float)height;
+ (UIImage *)lbd_imageFromColor:(UIColor *)color andWidth:(float)width andHeight:(float)height;

+(UIImage*)convertViewToImage:(UIView*)v;

-(UIImage *)lbd_drawRectWithRoundedCorner:(CGFloat)radius andCGSize:(CGSize)size;

+ (instancetype)ml_imageFromBundleNamed:(NSString *)name;
+ (UIImage *)lbd_imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (UIImage *)lbd_imageWithColor:(UIColor *)color;
/**
 *  等比例缩放
 *
 *  @param size 缩放大小
 *
 *  @return 缩放后的image
 */
- (UIImage *)scaleToSize:(CGSize)size;
/**
 *  缩放从顶部开始平铺图片
 *
 *  @param frameSize 缩放大小
 *
 *  @return 缩放后的image
 */
- (UIImage *)imageScaleAspectFillFromTop:(CGSize)frameSize;

/**
 *  裁剪图片
 *
 *  @param rect 裁剪范围
 *
 *  @return 裁剪后的图片
 */
-(UIImage *)subImageInRect:(CGRect)rect;
/**
 *  根据大小铺满整个显示范围
 *
 *  @param viewsize 显示图片的大小
 *
 *  @return 调整后的图片
 */
- (UIImage *)imageFillSize:(CGSize)viewsize;

/**
 *  图片切圆
 *
 *  @param image 需要切割的图片
 *  @param corner    圆角的大小
 *
 *  @return 切割后的图片
 */

-(UIImage *)createCircleImageWithParam:(CGFloat) corner;

/**
 *  图片高斯模糊
 *
 *  @param value 数值是模糊度（3～30，越大越模糊）
 *
 *  @return 返回模糊图片
 */

- (UIImage *)blurWithBlurValue:(CGFloat)value;

/**
 *  切割右边半圆
 *
 *  @param sizetoFit 图片的大小
 *
 *  @return 返回切割的图片
 */
- (UIImage *)clipHalfCornerWithSize:(CGSize)size;

/**
 *  给图片加文字水印
 *
 *  @param str     水印文字
 *  @param strRect 文字所在的位置大小
 *  @param attri   文字的相关属性，自行设置
 *
 *  @return 加完水印文字的图片
 */
- (UIImage*)imageWaterMarkWithString:(NSString*)str Imagerect:(CGRect)strRect attribute:(NSDictionary *)attri Image:(UIView *)image;
/**
 *  同上
 *
 *  @param str      同上
 *  @param strPoint 文字（0，0）点所在位置
 *  @param attri    同上
 *
 *  @return 同上
 */
- (UIImage*)imageWaterMarkWithString:(NSString*)str point:(CGPoint)strPoint attribute:(NSDictionary*)attri;

/**
 根据字符串创建二维码

 @param string 字符串
 @param size 图片大小
 @return 返回一个正方形的二维码图片
 */
+ (UIImage *)createQrcodeimageWithDataString:(NSString *)string andImageSize:(CGFloat)size;

/**
 压缩图片小于指定大小

 @param image 需要压缩的图片
 @param maxLength 指定的大小
 @return 压缩后的图片Data
 */
+ (NSData *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;


/**
 压缩图片

 @return 返回压缩图片
 */
- (UIImage *)biySessionCompress ;

- (UIImage *)biyTimelineCompress ;

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *
 *  @return UIImage
 */

+ (UIImage *)cutImageFromImage:(UIImage *)image inRect:(CGRect)rect;


/**
 获取当前的启动图

 @return 启动图
 */
+ (UIImage *)getLaunchImage;

/**
 获取当前的Icon图片

 @return icon
 */
+ (UIImage *)appIcon;

@end
