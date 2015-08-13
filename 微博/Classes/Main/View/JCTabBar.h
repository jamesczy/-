//
//  JCTabBar.h
//  微博
//
//  Created by jamesczy on 15/7/22.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCTabBar;

@protocol  JCTabBarDelegate <UITabBarDelegate>
@optional
-(void)tababBarDidClickPlusButton:(JCTabBar *)tabBar;
@end

@interface JCTabBar : UITabBar
@property (nonatomic,weak) id<JCTabBarDelegate> delegate;
@end
