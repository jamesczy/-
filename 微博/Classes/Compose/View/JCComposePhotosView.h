//
//  JCComposePhotosView.h
//  夏至的微博
//
//  Created by yingyi on 15/8/24.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCComposePhotosView : UIView

@property (nonatomic, strong, readonly) NSMutableArray *photos;
-(void)addPhotos:(UIImage *)photo;
@end
