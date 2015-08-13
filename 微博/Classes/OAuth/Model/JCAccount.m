//
//  JCAccount.m
//  微博
//
//  Created by jamesczy on 15/7/15.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCAccount.h"


@implementation JCAccount

+(instancetype)accountWithDict:(NSDictionary *)dict
{
    JCAccount *account = [[self alloc]init ];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    account.created_time = [NSDate date];
    return  account;
}
/**
 *  当对象归档进沙盒时调用次方法
 *  确定对象的那些属性能归档
 */
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}

/**
 *  当沙盒中解档一个对象时调用
 *  确定对象的那些属性要解档
 */
-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return  self;
}
@end
