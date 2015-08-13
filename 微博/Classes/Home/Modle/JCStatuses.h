//
//  JCStatuses.h
//  微博
//
//  Created by jamesczy on 15/7/31.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>
@class JCUser;

@interface JCStatuses : NSObject
@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *text;
@property (nonatomic, strong) JCUser *user;

//微博创建时间
@property (nonatomic,copy) NSString *created_at;
//微博的来源设备
@property (nonatomic,copy) NSString *source;
/** 微博配图地址,多图返回链接，无图返回“［］” */
@property (nonatomic, strong) NSArray *pic_urls;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic, strong) JCStatuses *retweeted_status;

/** 转发数量 */
@property (nonatomic,assign) int  reposts_count;
/** 评论数量 */
@property (nonatomic,assign) int  comments_count;
/** 表态数量 ：赞？不赞 */
@property (nonatomic,assign) int  attitudes_count;
@end
