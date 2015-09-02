//
//  UITextView+Extension.m
//  夏至的微博
//
//  Created by yingyi on 15/8/31.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
-(void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接图片
    NSUInteger loc = self.selectedRange.location;
//    [attributedText insertAttributedString:text atIndex:loc];
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    //调用外面传进来的代码块
    if (settingBlock) {
        settingBlock(attributedText);
    }
    self.attributedText = attributedText;
    
    // 移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
-(void)insertAttributedText:(NSAttributedString *)text
{
    [self insertAttributedText:text settingBlock:nil];
}
@end
