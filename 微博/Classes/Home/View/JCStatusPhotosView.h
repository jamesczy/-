//
//  JCStatusPhotosView.h
//  夏至的微博
//
//  Created by yingyi on 15/8/13.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCStatusPhotosView : UIView

@property (nonatomic ,strong)NSArray *photos;
/**
 *根据图片个数计算相册的尺寸
 */
+(CGSize)sizeWithCount:(int)count;
@end
