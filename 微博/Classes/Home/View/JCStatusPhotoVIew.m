//
//  JCStatusPhotoVIew.m
//  夏至的微博
//
//  Created by yingyi on 15/8/13.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCStatusPhotoVIew.h"
#import "JCPhoto.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface JCStatusPhotoVIew()
@property (nonatomic ,weak)UIImageView *gifView;
@end

@implementation JCStatusPhotoVIew

-(UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds =YES;
    }
    return self;
}
-(void)setPhoto:(JCPhoto *)photo
{
    _photo = photo;
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //判断是否显示图片，如果后缀是gif就显示，不是隐藏
//    NSLog(@"%@",photo.thumbnail_pic.lowercaseString);
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width ;
    self.gifView.y = self.height - self.gifView.height ;
}
@end
