//
//  JCEmotion.m
//  夏至的微博
//
//  Created by yingyi on 15/8/26.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCEmotion.h"
#import "MJExtension.h"

@interface JCEmotion()<NSCoding>

@end
@implementation JCEmotion
//把模型中的属性写入／读出沙盒
MJCodingImplementation

-(BOOL)isEqual:(JCEmotion *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}
@end
