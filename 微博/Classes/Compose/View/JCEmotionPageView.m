//
//  JCEmotionPageView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/27.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCEmotionPageView.h"
#import "JCEmotion.h"
#import "NSString+Emoji.h"
#import "UIView+Extension.h"
#import "JCEmotionPopView.h"
#import "JCEmotionButton.h"
#import "JCConst.h"

@interface JCEmotionPageView()
/** 点击表情弹出的视图  */
@property (nonatomic ,strong)JCEmotionPopView *popView;

@end

@implementation JCEmotionPageView

-(JCEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [JCEmotionPopView popView];
    }
    return _popView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger count = emotions.count;
    for (int i = 0 ; i < count; i++) {
        JCEmotionButton *btn = [[JCEmotionButton alloc]init];
         btn.emotion = emotions[i];
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - (2 * inset)) / JCEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / JCEmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % JCEmotionMaxCols) * btnW;
        btn.y = inset + (i / JCEmotionMaxCols) * btnH;
    }
}
-(void)btnClick:(JCEmotionButton *)btn
{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    self.popView.emotion = btn.emotion;
    
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    self.popView.centerX = CGRectGetMidX(btnFrame);
    
    // 等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[JCSelectEmotionKey] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:JCEmotionDidSelectNotification object:nil userInfo:userInfo];
    
}
@end
