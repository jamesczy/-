//
//  JCEmotionTabBar.m
//  夏至的微博
//
//  Created by yingyi on 15/8/25.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//  自定义键盘的底部多tabbar

#import "JCEmotionTabBar.h"
#import "JCEmotionTabbarButton.h"
#import "UIView+Extension.h"

@interface JCEmotionTabBar()
@property (nonatomic ,strong)JCEmotionTabbarButton *selectedButton;
@end

@implementation JCEmotionTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:JCEmotionTabbarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:JCEmotionTabbarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:JCEmotionTabbarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:JCEmotionTabbarButtonTypelxh];
    }
    return  self;
}
-(JCEmotionTabbarButton *)setupBtn:(NSString *)title buttonType:(JCEmotionTabbarButtonType)buttonType
{
    JCEmotionTabbarButton *btn = [[JCEmotionTabbarButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = buttonType;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    // 选中“默认”按钮
    if (buttonType == JCEmotionTabbarButtonTypeDefault) {
        [self btnClick:btn];
    }
    
    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    return btn;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        JCEmotionTabbarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}

-(void)btnClick:(JCEmotionTabbarButton *)btn
{
    self.selectedButton.enabled = YES;
    btn.enabled = NO;
    self.selectedButton = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelecteBtn:)]) {
        [self.delegate emotionTabBar:self didSelecteBtn:(JCEmotionTabbarButtonType)btn.tag];
    }
}
@end
