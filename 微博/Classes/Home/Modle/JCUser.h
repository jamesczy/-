//
//  JCUser.h
//  微博
//
//  Created by jamesczy on 15/7/31.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//用户模型

#import <Foundation/Foundation.h>
typedef enum{
    JCUserVerifiedTypeNone = -1,//没有认证
    JCUserVerifiedPersonal = 0, //个人认证
    JCUserVerifiedOrgEnterprice = 2,//企业官方
    JCUserVerifiedOrgMedia = 3,//媒体官方
    JCUserVerifiedOrgWebsite = 5,//网站官方
    
    JCUserVerifiedDaren = 220//微博达人
}JCUserVerifiedType;


@interface JCUser : NSObject
@property (nonatomic,copy) NSString * idstr;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;
/** 认证的类型  */
@property (nonatomic ,assign)JCUserVerifiedType verified_type;
@end
