//
//  JCEmotionPopView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/28.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCEmotionPopView.h"
#import "JCEmotionButton.h"
#import "JCEmotion.h"

@interface JCEmotionPopView()
@property (weak, nonatomic) IBOutlet JCEmotionButton *emotionButton;
@end

@implementation JCEmotionPopView

+(instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JCEmotionPopView" owner:nil options:nil]lastObject];
}
-(void)setEmotion:(JCEmotion *)emotion
{
    _emotion = emotion;
    self.emotionButton.emotion = emotion;
}
@end
