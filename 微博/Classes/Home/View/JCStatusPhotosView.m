//
//  JCStatusPhotosView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/13.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCStatusPhotosView.h"
#import "JCPhoto.h"
#import "JCStatusPhotoVIew.h"
#import "UIView+Extension.h"

#define JCStatusPhotoWH  90
#define JCStatusPhotoMargin 10
#define JCStatusPhotoMaxCol(count) ((count == 4)? 2 : 3)

@implementation JCStatusPhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    NSUInteger photosCount = photos.count;
    //创建显示所要的图片
    while (self.subviews.count < photosCount) {
        JCStatusPhotoVIew *photoView = [[JCStatusPhotoVIew alloc]init];
        [self addSubview:photoView];
    }
    
    //遍历所有的图片控件，给空间添加图片
    for (int i = 0; i < self.subviews.count; i++) {
        JCStatusPhotoVIew *photoView = self.subviews[i];
        if (i < photosCount) {
            photoView.photo = photos[i];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger photosCount = self.photos.count;
    int maxCol = JCStatusPhotoMaxCol(photosCount);
    for (int i = 0; i < photosCount;i++) {
        JCStatusPhotoVIew *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = col * (JCStatusPhotoWH + JCStatusPhotoMargin);
        int row = i / maxCol;
        photoView.y = row * (JCStatusPhotoWH + JCStatusPhotoMargin);
        photoView.width = JCStatusPhotoWH;
        photoView.height = JCStatusPhotoWH;
    }
}

+ (CGSize)sizeWithCount:(int)count
{
    int maxCols = JCStatusPhotoMaxCol(count);
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    
    CGFloat photosW = cols * JCStatusPhotoWH + (cols - 1) * JCStatusPhotoMargin;
    
    NSInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * JCStatusPhotoWH + (rows - 1) * JCStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
