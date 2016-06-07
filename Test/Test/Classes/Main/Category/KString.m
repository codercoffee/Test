//
//  KString.m
//  NSString
//
//  Created by wk on 15/12/22.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "KString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation KString

/**
 *  获取字符串所占空间大小CGSize
 *
 *  @param text 字符串内容
 *  @param font 字号
 *  @param maxW 最大宽度
 *
 *  @return 计算之后的字符串所占空间大小
 */
+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font andMaxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/**
 *  获取字符串所占空间大小CGSize
 *
 *  @param text 字符串内容
 *  @param font 字号
 *
 *  @return 计算之后的字符串所占空间大小
 */
+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font
{
    return [KString kSizeOfText:text withFont:font andMaxW:MAXFLOAT];
}

/**
 *  获取字符串所占空间大小CGSize
 *
 *  @param text      字符串内容
 *  @param font      字号
 *  @param size      字符串约束的范围的宽度和高度 CGSizeMake(SCREEN_WIDTH, MAXFLOAT)
 *  @param lineSpace 行间距
 *  @param color     颜色
 *
 *  @return 计算之后的字符串所占空间大小
 */
+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font andSize:(CGSize)size andLineSpace:(CGFloat)lineSpace andColor:(UIColor *)color
{
    CGSize resSize = CGSizeZero;
    NSMutableAttributedString *attStr = [KString createAttributeStringWithText:text LineSpace:lineSpace andFont:font andColor:color];
    resSize = [attStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return resSize;
}

+ (NSMutableAttributedString *) createAttributeStringWithText:(NSString *)text LineSpace:(CGFloat)lineSpace andFont:(UIFont *)font andColor:(UIColor *)color
{
    if(nil == text)
        return nil;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    //设置字体颜色
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length)];
    //设置行距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;//行距
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    return attStr;
}

/**
 *  判断字符串中是否含有另一个字符串，包含则返回从左到右开始，第一个该字符位置开始，并包括之后的全部字符的新字符串,否则返回原字符串
 *
 *  @param originalString  原字符串
 *  @param specifiedString 判断是否含有的另一个字符串
 *
 *  @return 截取的新字符串或原字符串
 */
+ (NSString *)kInterceptOriginalString:(NSString *)originalString withSpecifiedString:(NSString *)specifiedString
{
    NSRange range = [originalString rangeOfString:specifiedString];
    if (range.location != NSNotFound)
    {
//        NSLog(@"Location:%i,Leigth:%i",range.location,range.length);
        return [originalString substringFromIndex:range.location + 1];
    }
    else
    {
        NSLog(@"该字符串中不包含: %@",specifiedString);
        return originalString;
    }
}

/**
 *  MD5加密
 *
 *  @return 加密后的32位字符串
 */
+ (NSString *)kMD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i ++)
    {
        [result appendFormat:@"%02x", digest[i]];// 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
    }
    return result;
}

@end
