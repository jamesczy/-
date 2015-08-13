//
//  AppDelegate.m
//  微博
//
//  Created by jamesczy on 15/7/11.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "AppDelegate.h"
#import "JCConst.h"
#import "JCOAuthViewController.h"
#import "JCAccount.h"
#import "UIWindow+Extension.h"
#import "JCAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //设置根控制器
    JCAccount *account = [JCAccountTool account];

    //显示窗口
    [self.window makeKeyAndVisible];
    if (account) {
        //再沙盒中读取之前的版本和当前版本对比
        [self.window switchRootWindowController];
    }else{
        self.window.rootViewController = [[JCOAuthViewController alloc]init];
    }


    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //1.取消下载
    [mgr cancelAll];
    //2.清除内存中的图片
    [mgr.imageCache clearMemory];
}
@end
