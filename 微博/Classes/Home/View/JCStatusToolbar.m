//
//  JCStatusToolbar.m
//  夏至的微博
//
//  Created by jamesczy on 15/8/6.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCStatusToolbar.h"
#import "UIView+Extension.h"
#import "JCStatuses.h"

@interface JCStatusToolbar()
/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic,weak) UIButton * repostBtn;
@property (nonatomic,weak) UIButton * commentBtn;
@property (nonatomic,weak) UIButton * attitudeBtn;
@end

@implementation JCStatusToolbar

-(NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)dividers
{
    if (_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}
+(instancetype)toolbar
{
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        self.repostBtn = [self setupBtn:@"timeline_icon_retweet" title:@"转发"];
        self.commentBtn = [self setupBtn:@"timeline_icon_comment" title:@"评论"];
        self.attitudeBtn = [self setupBtn:@"timeline_icon_unlike" title:@"赞"];
        
        //添加分割线
        
        [self setupDividers];
    }
    return self;
}
-(void)setupDividers
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}
/**
 *初始化一个按钮
 */
-(UIButton *)setupBtn:(NSString *)icon title:(NSString *)title
{
    UIButton *retweetBtn = [[UIButton alloc]init];
    [retweetBtn setTitle:title forState:UIControlStateNormal];
    [retweetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    retweetBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [retweetBtn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [retweetBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    retweetBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:retweetBtn];
    [self.btns addObject:retweetBtn];
    
    return retweetBtn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    NSInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width =btnW;
        btn.x = i * btnW;
        btn.height = self.height;
    }
    //设置分割线frame
    NSInteger dividerCount = self.dividers.count;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
    
}

-(void)setStatus:(JCStatuses *)status
{
    _status = status;
    //转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    //评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    //赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
}

-(void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        }else{
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
    
}
@end
