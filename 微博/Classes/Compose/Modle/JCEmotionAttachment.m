//
//  JCEmotionAttachment.m
//  夏至的微博
//
//  Created by yingyi on 15/9/1.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCEmotionAttachment.h"
#import "JCEmotion.h"

@implementation JCEmotionAttachment

-(void)setEmotion:(JCEmotion *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
