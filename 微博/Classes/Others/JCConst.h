//
//  JCConst.h
//  微博
//
//  Created by jamesczy on 15/7/12.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//


#ifndef ___JCConst_h
#define ___JCConst_h

#ifdef DEBUG
#define JCLog(...) NSLog(__VA_ARGS__)
#else
#define JCLog(...)
#endif


//自定义颜色
#define JCColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//随机色
#define JCRandomColor JCColor(arc4random_uniform(256), arc4random_uniform(256),arc4random_uniform(256))

//表情按钮被选中的通知
#define JCEmotionDidSelectNotification @"JCEmotionDidSelectNotification"
#define JCSelectEmotionKey @"JCSelectEmotionKey"
//删除按钮点击通知
#define JCEmotionDidDeleteNotification @"JCEmotionDidDeleteNotification"
#endif
