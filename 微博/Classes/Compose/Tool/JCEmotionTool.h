//
//  JCEmotionTool.h
//  夏至的微博
//
//  Created by yingyi on 15/9/1.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JCEmotion;
@interface JCEmotionTool : NSObject

+ (void)addRecentEmotion:(JCEmotion *)emotion;
+ (NSArray *)recentEmotions;

@end
