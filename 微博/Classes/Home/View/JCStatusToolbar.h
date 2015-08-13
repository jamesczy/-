//
//  JCStatusToolbar.h
//  夏至的微博
//
//  Created by jamesczy on 15/8/6.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCStatuses;
@interface JCStatusToolbar : UIView

+(instancetype)toolbar;
@property (nonatomic, strong) JCStatuses *status;
@end
