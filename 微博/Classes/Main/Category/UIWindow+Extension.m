//
//  UIWindow+Extension.m
//  微博
//
//  Created by jamesczy on 15/7/16.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "JCNewFeatrueViewController.h"
#import "JCTabBarViewController.h"

@implementation UIWindow(Extension)
-(void)switchRootWindowController
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *LastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    NSString *currenVersion = [NSBundle mainBundle].infoDictionary[key];
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currenVersion isEqualToString:LastVersion]) {
        self.rootViewController = [[JCTabBarViewController alloc]init];
    }else{
        //将当前版本号存入沙盒
        [[NSUserDefaults standardUserDefaults]setObject:currenVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
        self.rootViewController = [[JCNewFeatrueViewController alloc]init];
    }
}
@end
