//
//  JCTitleButton.m
//  微博
//
//  Created by jamesczy on 15/8/5.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCTitleButton.h"
#import "UIView+Extension.h"

#define JCMargin 5

@implementation JCTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
    }
    return self;
}
/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
-(void)setFrame:(CGRect)frame
{
    frame.size.width += JCMargin;
    [super setFrame:frame];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + JCMargin;
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

@end
