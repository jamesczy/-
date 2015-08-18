//
//  JCComposeViewController.m
//  夏至的微博
//
//  Created by yingyi on 15/8/14.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCComposeViewController.h"
#import "JCNavigationController.h"
#import "JCAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "JCAccount.h"
#import "UIView+Extension.h"
#import "JCTextView.h"
#import "JCComposeView.h"

@interface JCComposeViewController ()

@end

@implementation JCComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setnavUp];
    [self setTextView];
    [self setupToolbar];
}
-(void)setTextView
{
    JCTextView *textView = [[JCTextView alloc]init];
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.placeholder = @"发送新鲜事……";
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
}
//设置导航栏
-(void)setnavUp
{
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(concle)];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [JCAccountTool account].name ;
    NSString *prefix = @"发微博";
    NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
    if (name) {
        UILabel *titleView = [[UILabel alloc]init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        // 自动换行
        titleView.numberOfLines = 0;
        //创建一个带有属性的字符串(字体／颜色／大小／还可以添加图片)
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        //添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[str rangeOfString:name]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    }else{
        self.title = prefix;
    }
}
-(void)setupToolbar
{
    JCComposeView *toolbar = [[JCComposeView alloc]init ];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.x = 0;
    [self.view addSubview:toolbar];
}
-(void)concle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)send
{
    
}
@end
