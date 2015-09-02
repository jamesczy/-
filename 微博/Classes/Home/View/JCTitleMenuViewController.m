//
//  JCTitleMenuViewController.m
//  微博
//
//  Created by jamesczy on 15/7/20.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCTitleMenuViewController.h"

@interface JCTitleMenuViewController ()

@end

@implementation JCTitleMenuViewController

-(id)initWithStyle:(UITableViewStyle)style
{
    self =  [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"密友";
    }else if (indexPath.row == 2){
        cell.textLabel.text =@"全部";
    }
    return cell;
}



@end
