//
//  JCIconView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/13.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCIconView.h"
#import "JCUser.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface JCIconView()

@property (nonatomic ,weak)UIImageView *verifiedView;
@end

@implementation JCIconView

-(UIImageView *)verifiedView
{
    if (_verifiedView == nil) {
        UIImageView *verifiedView = [[UIImageView alloc]init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setUser:(JCUser *)user
{
    _user = user;
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //设置加v图片
    switch (user.verified_type) {
        case JCUserVerifiedPersonal://个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case JCUserVerifiedOrgEnterprice:
        case JCUserVerifiedOrgMedia:
        case JCUserVerifiedOrgWebsite://官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case JCUserVerifiedDaren://微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;

        default://没有认证
            self.verifiedView.hidden = YES;
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width * 0.6;
    self.verifiedView.y = self.height - self.verifiedView.height * 0.6;
}
@end
