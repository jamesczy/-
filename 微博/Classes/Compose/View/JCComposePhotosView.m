//
//  JCComposePhotosView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/24.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCComposePhotosView.h"
#import "UIView+Extension.h"

@implementation JCComposePhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (imageWH + imageMargin);
        
        int row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}

-(void)addPhotos:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
    
    // 存储图片
    //    [_photos addObject:photo];
    [self.photos addObject:photo];
}
@end
