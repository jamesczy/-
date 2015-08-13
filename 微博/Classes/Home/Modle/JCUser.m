//
//  JCUser.m
//  微博
//
//  Created by jamesczy on 15/7/31.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCUser.h"

@implementation JCUser
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

@end
