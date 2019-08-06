//
//  NSAttributedString+BIY.m
//  BIYong
//
//  Created by xuyi on 2018/4/13.
//

#import "NSAttributedString+BIY.h"
#import <CoreText/CoreText.h>

static const void *tagKey = &tagKey;

@implementation NSAttributedString (BIY)

-(NSString *)changeToString {
    NSMutableAttributedString * resutlAtt = [[NSMutableAttributedString alloc]initWithAttributedString:self];
    
    //枚举出所有的附件字符串
    [self enumerateAttributesInRange:NSMakeRange(0, self.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        //key-NSAttachment
        //NSTextAttachment value类型
        NSTextAttachment * textAtt = attrs[@"NSAttachment"];//从字典中取得那一个图片
        if (textAtt)
        {
            UIImage * image = textAtt.image;
            NSString * text = [self stringFromImage:image];
            [resutlAtt replaceCharactersInRange:range withString:text];
            
        }
        
    }];
    
    return resutlAtt.string;
}


//不能直接得到串的名字?
-(NSString *)stringFromImage:(UIImage *)image
{
    NSArray *face=[self getAllImagePaths];
    
    NSData * imageD = UIImagePNGRepresentation(image);
    
    NSString * imageName;
    
    for (int i=0; i<face.count; i++)
    {
        UIImage *image=[UIImage imageNamed:face[i]];
        NSData *data=UIImagePNGRepresentation(image);
        if ([imageD isEqualToData:data])
        {
            imageName=face[i];
            //NSLog(@"匹配成功!");
        }
    }
    
    
    return imageName;
}




-(NSArray *)getAllImagePaths//数组结构还是上述的截图的数组结构
{
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString * path = [bundle pathForResource:@"FaceList" ofType:@"plist"];
    
    NSArray * face = [[NSArray alloc]initWithContentsOfFile:path];
    
    return face;
}



+ (NSAttributedString *)lbd_changeCorlorWithColor:(UIColor *)color TotalString:(NSString *)totalStr SubStringArray:(NSArray *)subArray {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    for (NSString *rangeStr in subArray) {
        NSRange range = [totalStr rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return [attributedStr copy];
}


/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)lbd_changeLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    long number = textSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    return attributedStr;
}

/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)lbd_changeFontAndColor:(UIFont *)font Color:(UIColor *)color andlineSpace:(CGFloat)lineSpace TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    for (NSString *rangeStr in subArray) {
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    
    return attributedStr;
}

-(NSMutableAttributedString *)lbd_changeTextLineSpace:(CGFloat)lineSpace andTextSpace:(CGFloat)textSpace {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedStr length])];
    CGFloat number = textSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    return attributedStr;
}

- (NSMutableAttributedString *)lbd_changeFontAndColor:(UIFont *)font Color:(UIColor *)color andlineSpace:(CGFloat)lineSpace  SubStringArray:(NSArray *)subArray{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    NSString * totalString = self.string;
    for (NSString *rangeStr in subArray) {
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    
    return attributedStr;
}

+ (NSAttributedString *)biy_insertImage:(UIImage *)image insertIndex:(NSInteger)index text:(NSString *)text{
     NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:text];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 图片
    attch.image = image;
    // 图片大小
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    attch.bounds = imageRect;
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:index];
    return attri;
}


@end
