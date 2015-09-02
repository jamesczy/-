//
//  JCEmotionButton.m
//  夏至的微博
//
//  Created by yingyi on 15/8/28.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCEmotionButton.h"
#import "JCEmotion.h"
#import "NSString+Emoji.h"

@implementation JCEmotionButton

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    //让hightlighted点击的时候按钮变灰失效
    self.adjustsImageWhenHighlighted = NO;
}

-(void)setEmotion:(JCEmotion *)emotion
{
    _emotion = emotion;
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else if(emotion.code){
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
        
    }

}
@end
