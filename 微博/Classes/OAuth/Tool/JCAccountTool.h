//
//  JCAccountTool.h
//  微博
//
//  Created by jamesczy on 15/7/16.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//  处理和账号相关到信息

#import <Foundation/Foundation.h>
@class JCAccount;

@interface JCAccountTool : NSObject 

+(void)saveAccount:(JCAccount *)account;

+(JCAccount *)account;
@end
