//
//  JCEmotionPopView.h
//  夏至的微博
//
//  Created by yingyi on 15/8/28.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCEmotion;

@interface JCEmotionPopView : UIView
+(instancetype)popView;
@property (nonatomic ,strong)JCEmotion *emotion;
@end
