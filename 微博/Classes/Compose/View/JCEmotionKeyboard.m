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
#import "JCEmotion.h"
#import "MJExtension.h"

@interface JCEmotionKeyboard()<JCEmotionTabBarDelegate>
@property (nonatomic ,weak)JCEmotionTabBar *tabbar;

/** 容纳表情内容的控件 */
@property (nonatomic, weak) UIView *contentView;
/** 表情内容 */
@property (nonatomic, strong) JCEmotionListView *recentListView;
@property (nonatomic, strong) JCEmotionListView *defaultListView;
@property (nonatomic, strong) JCEmotionListView *emojiListView;
@property (nonatomic, strong) JCEmotionListView *lxhListView;

@end
@implementation JCEmotionKeyboard

-(JCEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[JCEmotionListView alloc]init];
//        _recentListView.backgroundColor = JCRandomColor;
    }
    return _recentListView;
}

-(JCEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[JCEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [JCEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
//        self.defaultListView.backgroundColor = JCRandomColor;
    }
    return  _defaultListView;
}

-(JCEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[JCEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [JCEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
//        self.emojiListView.backgroundColor = JCRandomColor;
    }
    return _emojiListView;
}

-(JCEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[JCEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [JCEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
//        self.lxhListView.backgroundColor = JCRandomColor;
        
    }
    return _lxhListView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //contentView
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        //tabbar
        JCEmotionTabBar *tabbar = [[JCEmotionTabBar alloc]init];
        tabbar.delegate = self;
        [self addSubview:tabbar];
        self.tabbar = tabbar;
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
    self.contentView.width = self.width;
    self.contentView.height = self.height - self.tabbar.height;
    self.contentView.x = self.contentView.y = 0;
    
    //设置自空间的frame
    UIView *child = [self.contentView.subviews lastObject];
    child.frame = self.contentView.bounds;
}
#pragma mark - JCEmotionTabBarDelegate
-(void)emotionTabBar:(JCEmotionTabBar *)tabbar didSelecteBtn:(JCEmotionTabbarButtonType)buttonType
{
    //移除contentView之前显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (buttonType) {
        case JCEmotionTabbarButtonTypeRecent:
   
            [self.contentView addSubview:self.recentListView];
            break;
        case JCEmotionTabbarButtonTypeDefault:

            [self.contentView addSubview:self.defaultListView];
            break;
        case JCEmotionTabbarButtonTypeEmoji:

            [self.contentView addSubview:self.emojiListView];
            break;
        case JCEmotionTabbarButtonTypelxh:

            [self.contentView addSubview:self.lxhListView];
            break;
        default:
            break;
    }
    //etNeedsLayout内部会在恰当的时刻，重新调用layoutSubviews，重新布局子控件
    [self setNeedsLayout];
}
@end
