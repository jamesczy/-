//
//  JCComposeView.h
//  夏至的微博
//
//  Created by yingyi on 15/8/17.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    JCComposeToolbarButtonTypeCamera,//拍照
    JCComposeToolbarButtonTypePicture,//相册
    JCComposeToolbarButtonTypeMention,//@
    JCComposeToolbarButtonTypeTrend,//#
    JCComposeToolbarButtonTypeEmotion //表情
}JCComposeToolbarButtonType;
@class JCComposeView;

@protocol JCComposeViewDelegate <NSObject>

@optional
-(void)composeView:(JCComposeView *)composeView didClickButton:(JCComposeToolbarButtonType)buttonType;
@end

@interface JCComposeView : UIView
@property (nonatomic ,weak) id<JCComposeViewDelegate> delegate;
/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;
@end
