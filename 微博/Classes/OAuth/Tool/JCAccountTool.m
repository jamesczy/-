//
//  JCAccountTool.m
//  微博
//
//  Created by jamesczy on 15/7/16.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

//沙盒路径
#define JCAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.archiver"]


#import "JCAccountTool.h"
#import "JCAccount.h"
#import "JCConst.h"

@implementation JCAccountTool

+(void)saveAccount:(JCAccount *)account{
    //自定义对象的存储方法
    [NSKeyedArchiver archiveRootObject:account toFile:JCAccountPath];
//    NSLog(@"%d",isSave);
}
+(JCAccount *)account
{
    //加载模型
    JCAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:JCAccountPath];
    //验证账号是否过期
    long long expires_in = [account.expires_in longLongValue];
    //获取过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    //获取当前时间
    NSDate *now = [NSDate date];
//    JCLog(@"%@,%@",now,expiresTime);
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}
@end