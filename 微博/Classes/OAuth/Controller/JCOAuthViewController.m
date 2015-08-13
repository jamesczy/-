//
//  JCOAuthViewController.m
//  微博
//
//  Created by jamesczy on 15/7/15.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "JCAccount.h"
#import "UIWindow+Extension.h"
#import "JCAccountTool.h"

@interface JCOAuthViewController ()<UIWebViewDelegate>

@end

@implementation JCOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    //用webview加载登陆页面
    webView.delegate =self;
    /**
     请求
     https://api.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=http://www.example.com/response&response_type=code
     
     同意授权后会重定向
     http://www.example.com/response&code=CODE
    */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=663335365&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark -webView的代理方法

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSLog(@"webViewDidFinishLoad");
    [MBProgressHUD hideHUD];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSLog(@"webViewDidStartLoad");
    [MBProgressHUD showMessage:@"正在加载……"];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //获取URL
    NSString *url = request.URL.absoluteString;
    //判断是否是回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        //截取code后面的参数
        int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
//        NSLog(@"%@,%@",code,url);
        [self accessTokenWithCode:code];
        return NO;
    }
    //c12c3aa70d269326811458dbf0f40133
    return YES;
}
-(void)accessTokenWithCode:(NSString *)code
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"client_id"] = @"278967917";
//    params[@"client_secret"] = @"1e61dde8291559f08b68d7d29aeb86a3";
    params[@"client_id"] = @"663335365";
    params[@"client_secret"] = @"9e2fc3fa12bd17753eac712533844c73";

    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://";
    params[@"code"] = code;
    NSLog(@"@%s",code);
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        //返回账号字典数据
        JCAccount *account = [JCAccount accountWithDict:responseObject];
        //储存账号信息
        [JCAccountTool saveAccount:account];
        //切换根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootWindowController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
    }];
     /**
      "access_token" = "2.00hTKyOD0XSWsSbba97e1b85gLMNAD";
      "expires_in" = 157679999;
      "remind_in" = 157679999;
      uid = 2969607161;
      */
}
@end
