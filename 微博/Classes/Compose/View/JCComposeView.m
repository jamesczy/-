//
//  JCComposeView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/17.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCComposeView.h"
#import "UIView+Extension.h"
@interface JCComposeView()

@property (nonatomic ,weak)UIButton *emotionButton;
@end

@implementation JCComposeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        //初始化按钮
        [self setupBtn:@"compose_camerabutton_background" hightImage:@"compose_camerabutton_background_highlighted" type:JCComposeToolbarButtonTypeCamera];
        [self setupBtn:@"compose_toolbar_picture" hightImage:@"compose_toolbar_picture_highlighted" type:JCComposeToolbarButtonTypePicture];
        [self setupBtn:@"compose_mentionbutton_background" hightImage:@"compose_mentionbutton_background_highlighted" type:JCComposeToolbarButtonTypeMention];
        [self setupBtn:@"compose_trendbutton_background" hightImage:@"compose_trendbutton_background_highlighted" type:JCComposeToolbarButtonTypeTrend];
        [self setupBtn:@"compose_emoticonbutton_background" hightImage:@"compose_emoticonbutton_background_highlighted" type:JCComposeToolbarButtonTypeEmotion];
    }
    return self;
}
//创建按钮
-(void) setupBtn:(NSString *)image hightImage:(NSString *)hightImage type:(JCComposeToolbarButtonType)type
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
}

-(void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeView:didClickButton:)]) {
        [self.delegate composeView:self didClickButton:(JCComposeToolbarButtonType)btn.tag];
    }
}
- (void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
//    // 默认的图片名
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
//
    // 显示键盘图标
    if (showKeyboardButton) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
        
    }

    // 设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置所有按钮的frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
    }
}
@end
