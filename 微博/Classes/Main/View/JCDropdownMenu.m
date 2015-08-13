//
//  JCDropdownMenu.m
//  微博
//
//  Created by jamesczy on 15/7/17.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCDropdownMenu.h"
#import "UIView+Extension.h"

@interface JCDropdownMenu ()
//用来显示具体内容的容器
@property (nonatomic, weak) UIImageView *contentView;
@end

@implementation JCDropdownMenu

-(UIImageView *)contentView
{
    if (_contentView == nil)
    {
        UIImageView *contentView = [[UIImageView alloc]init];
        contentView.image = [UIImage imageNamed:@"popover_background"];
//        contentView.width = 217;
//        contentView.height = 217;
        contentView.userInteractionEnabled = YES;
        [self addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}

-(void)setContent:(UIView *)content
{
    _content = content;
    content.x = 10;
    content.y = 15;
    self.contentView.height = CGRectGetMaxY(content.frame) + 11;
    self.contentView.width = CGRectGetMaxX(content.frame) + 10;
    [self.contentView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

+(instancetype)menu
{
    return [[self alloc]init];
}

-(void)showFrom:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    self.frame = window.bounds;
    
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.contentView.centerX = CGRectGetMidX(newFrame);
    self.contentView.y = CGRectGetMaxY(newFrame);
    
    
}

-(void)dismiss
{
    [self removeFromSuperview];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
