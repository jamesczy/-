//
//  JCDropdownMenu.h
//  微博
//
//  Created by jamesczy on 15/7/17.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCDropdownMenu;

@protocol  JCDropdownMenuDelegate<NSObject>
@optional
- (void)dropdownMenuDidDismiss:(JCDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(JCDropdownMenu *)menu;
@end


@interface JCDropdownMenu : UIView

@property (nonatomic,weak) id<JCDropdownMenuDelegate> delegate;

+(instancetype)menu;
-(void)showFrom:(UIView *)from;
-(void)dismiss;
@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UIViewController *contentController;
@end
