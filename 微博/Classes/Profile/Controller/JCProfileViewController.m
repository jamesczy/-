//
//  JCProfileViewController.m
//  微博
//
//  Created by jamesczy on 15/7/12.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCProfileViewController.h"

@interface JCProfileViewController ()

@end

@implementation JCProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(nextShow)];
}
-(void)nextShow
{
    NSLog(@"%s",__func__);
}



@end
