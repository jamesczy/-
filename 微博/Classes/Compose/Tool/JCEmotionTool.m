//
//  JCEmotionTool.m
//  夏至的微博
//
//  Created by yingyi on 15/9/1.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//
#define JCRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "JCEmotionTool.h"
#import "JCEmotion.h"

static NSMutableArray *_recentEmotions;

@implementation JCEmotionTool
+(void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:JCRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}
+(void)addRecentEmotion:(JCEmotion *)emotion
{
    //加载沙盒中的表情数据
    [_recentEmotions removeObject:emotion];
    //将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    //将所有表情写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:JCRecentEmotionsPath];
}
//返回装有jcemotion的数组
+(NSArray *)recentEmotions
{
    return _recentEmotions;
}
@end
