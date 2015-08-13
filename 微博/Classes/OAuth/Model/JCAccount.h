//
//  JCAccount.h
//  微博
//
//  Created by jamesczy on 15/7/15.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCAccount : NSObject <NSCoding>

@property (nonatomic,copy) NSString * access_token;
@property (nonatomic,copy) NSNumber * expires_in;
@property (nonatomic,copy) NSString * uid;
@property (nonatomic, strong) NSDate *created_time;
@property (nonatomic,copy) NSString *name;
+(instancetype) accountWithDict:(NSDictionary *)dict;

@end
