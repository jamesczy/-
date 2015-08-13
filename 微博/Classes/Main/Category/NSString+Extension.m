//
//  NSString+Extension.m
//  夏至的微博
//
//  Created by jamesczy on 15/8/8.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

//返回给定文字和字体的size
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
@end
