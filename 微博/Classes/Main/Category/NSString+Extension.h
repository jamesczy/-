//
//  NSString+Extension.h
//  夏至的微博
//
//  Created by jamesczy on 15/8/8.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;
@end
