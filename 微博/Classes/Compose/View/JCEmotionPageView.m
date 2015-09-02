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
#import "JCEmotionTool.h"

@interface JCEmotionPageView()
/** 点击表情弹出的视图  */
@property (nonatomic ,strong)JCEmotionPopView *popView;
@property (nonatomic ,weak)UIButton *deleteBtn;

@end
const CGFloat inset = 20;
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
        UIButton *deleteBtn = [[UIButton alloc]init];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        
        //添加长按手势
        
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}
//通过位置返回手指所按的按钮
-(JCEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        JCEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
        }
    }
    return nil;
}

//处理长按手势
-(void)longPressPageView:(UILongPressGestureRecognizer *)recongnizer
{
    CGPoint location = [recongnizer locationInView:recongnizer.view];
    JCEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recongnizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.popView removeFromSuperview];
            if (btn) {
                //发出通知
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[JCSelectEmotionKey] = btn.emotion;
                [[NSNotificationCenter defaultCenter] postNotificationName:JCEmotionDidSelectNotification object:nil userInfo:userInfo];
            }
            break;
        case UIGestureRecognizerStateChanged:
        case UIGestureRecognizerStateBegan:
            [self.popView showFrom:btn];
//            NSLog(@"btn.emotion--->%@",btn.emotion.chs);
            break;
        default:
            break;
    }
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
-(void)deleteClick
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:JCEmotionDidDeleteNotification object:nil];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - (2 * inset)) / JCEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / JCEmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % JCEmotionMaxCols) * btnW;
        btn.y = inset + (i / JCEmotionMaxCols) * btnH;
        
        //删除按钮
        self.deleteBtn.width = (self.width - (2 * inset)) / JCEmotionMaxCols;
        self.deleteBtn.height= (self.height - inset) / JCEmotionMaxRows;
        self.deleteBtn.x = self.width - btn.width - inset;
        self.deleteBtn.y = self.height - btn.height;
    }
}
-(void)btnClick:(JCEmotionButton *)btn
{
    [self.popView showFrom:btn];
    
    // 等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    //发出通知
    [self selectEmotion:btn.emotion];
    
}

-(void)selectEmotion:(JCEmotion *)emotion
{
    //把表情存进沙盒
    [JCEmotionTool addRecentEmotion:emotion];
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[JCSelectEmotionKey] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:JCEmotionDidSelectNotification object:nil userInfo:userInfo];
}

@end
