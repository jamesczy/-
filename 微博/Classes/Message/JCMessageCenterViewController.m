//
//  JCMessageCenterViewController.m
//  微博
//
//  Created by jamesczy on 15/7/12.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCMessageCenterViewController.h"
#import "UIBarButtonItem+Extension.h"


@interface JCMessageCenterViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation JCMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composMeg)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}


- (void)composMeg {
    NSLog(@"%s",__func__);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

//    NSLog(@"%s",__func__);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    NSLog(@"%s",__func__);
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    NSLog(@"%s",__func__);
    static  NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"测试数据－－－－－》%ld",indexPath.row];

    return cell;
}


@end
