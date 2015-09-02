//
//  JCEmotionTextView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/31.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCEmotionTextView.h"
#import "JCEmotion.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"
#import "JCEmotionAttachment.h"

@implementation JCEmotionTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)insertEmotion:(JCEmotion *)emotion
{
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    }else if(emotion.png){
        //加载图片
        JCEmotionAttachment *attch = [[JCEmotionAttachment alloc]init];
        
        attch.emotion = emotion;
        
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        //根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        //讲属性文字插到光标位置::注意此处使用的是block
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0,attributedText.length)];
        }];
        
    }
}

-(NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        JCEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) {//图片
            [fullText appendString:attch.emotion.chs];
        }else{//普通文字和emoji
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    return fullText;
}

@end
