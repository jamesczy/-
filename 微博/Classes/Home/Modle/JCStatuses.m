//
//  JCStatuses.m
//  微博
//
//  Created by jamesczy on 15/7/31.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCStatuses.h"
#import "JCUser.h"
#import "JCPhoto.h"
#import "NSDate+Extension.h"

@implementation JCStatuses

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [JCPhoto class]};
}
-(NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init ];
    
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //微博的创建时间
    NSDate *createdDate = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    //日历格式(获取当前的日历)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit枚举：想要获取哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createdDate toDate:now options:0];
    
    //获取创建的年月日，时分秒
//    NSDateComponents *createdCmps = [calendar components:unit fromDate:createdDate];
    
//    NSLog(@"%@ %@ %@",createdDate,now,cmps);
    
    if ([createdDate isThisYear]) {//是否是今年
        if ([createdDate isYesterday]) {//是否是昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createdDate];
        }else if([createdDate isToday]){//是否是今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前",cmps.hour];
            }else if(cmps.minute >= 1 ){
                return [NSString stringWithFormat:@"%d分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{//今年其他时候
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createdDate];
        }
    }else{//不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
//    return [fmt stringFromDate:createdDate];
}
-(void)setSource:(NSString *)source
{
    if (source.length) {
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
//        NSLog(@"%@:lenght  -> %lu",source,range.length);        
        _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
    }
    
}

@end
