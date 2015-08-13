//
//  JCUser.h
//  微博
//
//  Created by jamesczy on 15/7/31.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//用户模型

#import <Foundation/Foundation.h>

@interface JCUser : NSObject
@property (nonatomic,copy) NSString * idstr;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;
@end
