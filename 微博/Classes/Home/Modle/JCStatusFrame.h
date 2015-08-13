//
//  JCStatusFrame.h
//  微博
//
//  Created by jamesczy on 15/8/3.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//cell的边框宽度
#define JCStatusCellBorderW 10
//cell之间的间距
#define JCStatusCellMargin 15
//昵称字体
#define JCStatusCellNameFront [UIFont systemFontOfSize:15]
//时间字体
#define JCStatusCellTimeFront [UIFont systemFontOfSize:12]
//来源字体
#define JCStatusCellSourceFront [UIFont systemFontOfSize:12]
//正文字体
#define JCStatusCellContentFront [UIFont systemFontOfSize:15]
//转发微博的字体
#define JCstatusCellRetweentContentFont [UIFont systemFontOfSize:15]

@class JCStatuses;

@interface JCStatusFrame : NSObject

@property (nonatomic, strong) JCStatuses *status;
//原创微博整体
@property (nonatomic,assign) CGRect originalViewF;
//头像
@property (nonatomic,assign) CGRect iconViewF;
//会员图标
@property (nonatomic,assign) CGRect vipViewF;
//配图
@property (nonatomic,assign) CGRect photoViewF;
//昵称
@property (nonatomic,assign) CGRect nameLableF;
//时间
@property (nonatomic,assign) CGRect timeLableF;
//来源
@property (nonatomic,assign) CGRect soureLableF;
//正文
@property (nonatomic,assign) CGRect contentLableF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/** 工具条 */
@property (nonatomic,assign) CGRect statusToolbarF;

//cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
@end
