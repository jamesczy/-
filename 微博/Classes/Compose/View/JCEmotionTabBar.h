//
//  JCEmotionTabBar.h
//  夏至的微博
//
//  Created by yingyi on 15/8/25.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    JCEmotionTabbarButtonTypeRecent,//最近
    JCEmotionTabbarButtonTypeDefault,//默认
    JCEmotionTabbarButtonTypeEmoji,//Emoji
    JCEmotionTabbarButtonTypelxh    //浪小花
}JCEmotionTabbarButtonType;
@class JCEmotionTabBar;
@protocol JCEmotionTabBarDelegate <NSObject>
@optional
-(void)emotionTabBar:(JCEmotionTabBar *)tabbar didSelecteBtn:(JCEmotionTabbarButtonType)buttonType;
@end

@interface JCEmotionTabBar : UIView
@property (nonatomic ,weak) id<JCEmotionTabBarDelegate> delegate;
@end
