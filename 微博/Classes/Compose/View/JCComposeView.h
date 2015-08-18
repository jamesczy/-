//
//  JCComposeView.h
//  夏至的微博
//
//  Created by yingyi on 15/8/17.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    JCComposeToolbarButtonTypeCamer,//拍照
    JCComposeToolbarButtonTypePicture,//相册
    JCComposeToolbarButtonTypeMention,//@
    JCComposeToolbarButtonTypeTrend,//#
    JCComposeToolbarButtonTypeEmotion //表情
}JCComposeToolbarButtonType;

@interface JCComposeView : UIView

@end
