//
//  JCLoadMoreFoot.m
//  微博
//
//  Created by jamesczy on 15/8/1.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCLoadMoreFoot.h"

@implementation JCLoadMoreFoot


+(instancetype)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:@"JCLoadMoreFoot" owner:nil options:nil]lastObject];
}
@end
