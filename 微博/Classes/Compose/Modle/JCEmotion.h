//
//  JCEmotion.h
//  夏至的微博
//
//  Created by yingyi on 15/8/26.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;
@end
