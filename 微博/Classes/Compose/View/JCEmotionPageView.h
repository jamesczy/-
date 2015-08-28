//
//  JCEmotionPageView.h
//  夏至的微博
//
//  Created by yingyi on 15/8/27.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>
#define JCEmotionMaxRows 3
#define JCEmotionMaxCols 7
#define JCEmotionPageSize (JCEmotionMaxRows * JCEmotionMaxCols - 1)
@interface JCEmotionPageView : UIView
/** 这一页显示的表情（里面都是JCEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;
@end
