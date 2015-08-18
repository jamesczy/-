//
//  JCTabBarViewController.m
//  微博
//
//  Created by jamesczy on 15/7/12.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCTabBarViewController.h"
#import "JCConst.h"
#import "JCHomeViewController.h"
#import "JCMessageCenterViewController.h"
#import "JCDiscoverViewController.h"
#import "JCProfileViewController.h"
#import "JCNavigationController.h"
#import "JCTabBar.h"
#import "JCComposeViewController.h"

@interface JCTabBarViewController ()<JCTabBarDelegate>

@end

@implementation JCTabBarViewController


-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = JCColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
//    childVc.view.backgroundColor = JCRandomColor;
    //先把外面传进来的控制器包装一个导航器
    UINavigationController *nav = [[JCNavigationController alloc]initWithRootViewController:childVc];
    //添加自控制器
    [self addChildViewController:nav];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    JCHomeViewController *home = [[JCHomeViewController alloc]init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    JCMessageCenterViewController *message =[[JCMessageCenterViewController alloc]init];
    [self addChildVc:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    JCDiscoverViewController *discover = [[JCDiscoverViewController alloc]init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    JCProfileViewController *profile = [[JCProfileViewController alloc]init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];

    //更换系统自带的tabbar
    JCTabBar *tabBar = [[JCTabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    // Do any additional setup after loading the view.
}
#pragma mark -JCtabBar的代理
-(void)tababBarDidClickPlusButton:(JCTabBar *)tabBar
{
    JCComposeViewController *vc = [[JCComposeViewController alloc]init];
    JCNavigationController *nav = [[JCNavigationController alloc]initWithRootViewController:vc];
//    vc.view.backgroundColor = [UIColor yellowColor];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
