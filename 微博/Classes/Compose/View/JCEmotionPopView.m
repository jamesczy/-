//
//  JCEmotionPopView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/28.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCEmotionPopView.h"
#import "JCEmotionButton.h"
#import "JCEmotion.h"
#import "UIView+Extension.h"

@interface JCEmotionPopView()
@property (weak, nonatomic) IBOutlet JCEmotionButton *emotionButton;
@end

@implementation JCEmotionPopView

+(instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JCEmotionPopView" owner:nil options:nil]lastObject];
}

-(void)showFrom:(JCEmotionButton *)button
{
    if (button == nil) return;
    self.emotionButton.emotion = button.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.centerX = CGRectGetMidX(btnFrame);
}

@end
