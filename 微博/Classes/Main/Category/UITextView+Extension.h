//
//  UITextView+Extension.h
//  夏至的微博
//
//  Created by yingyi on 15/8/31.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *attributedText))settingBlock;
@end
