//
//  JCEmotionTabbarButton.m
//  夏至的微博
//
//  Created by yingyi on 15/8/25.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCEmotionTabbarButton.h"

@implementation JCEmotionTabbarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        // 设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted
{
    //重写setHighlighted方法，让系统的setHighlighted操作失效
}
@end
