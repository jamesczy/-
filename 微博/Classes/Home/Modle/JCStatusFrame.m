//
//  JCStatusFrame.m
//  微博
//
//  Created by jamesczy on 15/8/3.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//  

#import "JCStatusFrame.h"
#import "JCStatuses.h"
#import "JCUser.h"
#import "JCStatusCell.h"
#import "NSString+Extension.h"
#import "JCStatusPhotosView.h"

@implementation JCStatusFrame

/**
//返回给定文字和字体的size
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}
*/
-(void)setStatus:(JCStatuses *)status
{
    _status = status;

    JCUser *user = status.user;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    //头像
    CGFloat iconWH = 40;
    CGFloat iconX = JCStatusCellBorderW;
    CGFloat iconY = JCStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + JCStatusCellBorderW;
    CGFloat nameY = iconX;
    CGSize  nameSize = [user.name sizeWithFont:JCStatusCellNameFront];
//    self.nameLableF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    self.nameLableF = (CGRect){{nameX,nameY},nameSize};
    //会员图标
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLableF) + JCStatusCellBorderW;
        CGFloat vipY = iconY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLableF) + JCStatusCellBorderW;
    CGSize  timeSize = [status.created_at sizeWithFont:JCStatusCellTimeFront];
//    self.timeLableF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.timeLableF = (CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLableF) + JCStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [status.source sizeWithFont:JCStatusCellSourceFront];
    self.soureLableF = (CGRect){{sourceX,sourceY},sourceSize};

    //正文
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLableF)) + JCStatusCellBorderW;
    CGFloat maxW = [UIScreen mainScreen].bounds.size.width - 2 * JCStatusCellBorderW;
    CGSize  contentSize = [status.text sizeWithFont:JCStatusCellContentFront maxW:maxW];
    self.contentLableF = (CGRect){{contentX,contentY},contentSize};
    //配图
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLableF) + JCStatusCellBorderW;
        CGSize photoSize = [JCStatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photoViewF = (CGRect){{photoX, photoY}, photoSize};
        
        originalH = CGRectGetMaxY(self.photoViewF) + JCStatusCellBorderW;
    }else{
        originalH = CGRectGetMaxY(self.contentLableF) + JCStatusCellBorderW;
    }

    //原创微博整体
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    //被转发微博
    CGFloat toolbarY = 0;
    if (status.retweeted_status) {
        JCStatuses *retweeted_status = status.retweeted_status;
        
        JCUser *retweeted_status_user = retweeted_status.user;
        //被转发打正文
        CGFloat retweetedContentX = JCStatusCellBorderW;
        CGFloat retweetedContentY = 0;
        NSString *retweetedContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
//        NSLog(@"%@",retweetedContent);
        CGSize retweetedSize = [retweetedContent sizeWithFont:JCstatusCellRetweentContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetedContentX,retweetedContentY},retweetedSize};
        //被转发的微博的图片
        CGFloat retweetH = 0;
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retweetedPhotoX = retweetedContentX;
            CGFloat retweetedPhotoY = CGRectGetMaxY(self.retweetContentLabelF);
            CGSize photoSize = [JCStatusPhotosView sizeWithCount:status.retweeted_status.pic_urls.count];
            
            self.retweetPhotoViewF = (CGRect){{retweetedPhotoX, retweetedPhotoY}, photoSize};
            
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + JCStatusCellBorderW;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + JCStatusCellBorderW;
        }
        //被转发微博的整体
        
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
//        self.cellHeight = CGRectGetMaxY(self.retweetViewF);
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    }else{
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    //工具条
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    
    self.statusToolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    //cell的高度
    self.cellHeight = CGRectGetMaxY(self.statusToolbarF) + JCStatusCellMargin;
}

@end
