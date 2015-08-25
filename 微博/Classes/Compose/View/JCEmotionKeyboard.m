//
//  JCEmotionKeyboard.m
//  夏至的微博
//
//  Created by yingyi on 15/8/25.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//  

#import "JCEmotionKeyboard.h"
#import "JCEmotionTabBar.h"
#import "JCEmotionListView.h"
#import "UIView+Extension.h"
#import "JCConst.h"

@interface JCEmotionKeyboard()<JCEmotionTabBarDelegate>
@property (nonatomic ,weak)JCEmotionTabBar *tabbar;
@property (nonatomic ,weak)JCEmotionListView *listView;
@end
@implementation JCEmotionKeyboard

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //tabbar
        JCEmotionTabBar *tabbar = [[JCEmotionTabBar alloc]init];
//        tabbar.backgroundColor = JCRandomColor;
        [self addSubview:tabbar];
        self.tabbar = tabbar;
        //listView
        JCEmotionListView *listView = [[JCEmotionListView alloc]init];
        listView.backgroundColor = JCRandomColor;
        [self addSubview:listView];
        self.listView = listView;
    }
    return  self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //tabbar
    self.tabbar.width = self.width;
    self.tabbar.height = 37;
    
    self.tabbar.x = 0;
    self.tabbar.y = self.height - self.tabbar.height;
    
    //listView
    self.listView.width = self.width;
    self.listView.height = self.height - self.tabbar.height;
    self.listView.x = self.listView.y = 0;
    
}
#pragma mark - JCEmotionTabBarDelegate
-(void)emotionTabBar:(JCEmotionTabBar *)tabbar didSelecteBtn:(JCEmotionTabbarButtonType)buttonType
{
    switch (buttonType) {
        case JCEmotionTabbarButtonTypeRecent:
            
            break;
        case JCEmotionTabbarButtonTypeDefault:
            
            break;
        case JCEmotionTabbarButtonTypeEmoji:
            
            break;
        case JCEmotionTabbarButtonTypelxh:
            
            break;
            
        default:
            break;
    }
}
@end
