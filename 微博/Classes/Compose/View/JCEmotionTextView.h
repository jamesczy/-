//
//  JCEmotionTextView.h
//  夏至的微博
//
//  Created by yingyi on 15/8/31.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCTextView.h"
@class JCEmotion;
@interface JCEmotionTextView : JCTextView
-(void)insertEmotion:(JCEmotion *)emotion;

-(NSString *)fullText;
@end
