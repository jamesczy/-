//
//  JCComposeView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/17.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCComposeView.h"
#import "UIView+Extension.h"

@implementation JCComposeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        //初始化按钮
        [self setupBtn:@"compose_camerabutton_background" hightImage:@"compose_camerabutton_background_highlighted" type:JCComposeToolbarButtonTypeCamer];
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
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
}

-(void)btnClick
{
    
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
