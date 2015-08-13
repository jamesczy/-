//
//  JCStatusCell.h
//  微博
//
//  Created by jamesczy on 15/8/3.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCStatusFrame;

@interface JCStatusCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) JCStatusFrame *statusFrame;
@end
