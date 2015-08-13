//
//  JCStatusCell.m
//  微博
//
//  Created by jamesczy on 15/8/3.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCStatusCell.h"
#import "JCStatusFrame.h"
#import "JCStatuses.h"
#import "JCUser.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "JCPhoto.h"
#import "JCConst.h"
#import "JCStatusToolbar.h"
#import "JCStatusPhotosView.h"

@interface JCStatusCell()

//原创微博整体
@property (nonatomic,weak) UIView *originalView;
//头像
@property (nonatomic,weak) UIImageView *iconView;
//会员图标
@property (nonatomic,weak) UIImageView *vipView;
//配图
@property (nonatomic,weak) JCStatusPhotosView *photoView;
//昵称
@property (nonatomic,weak) UILabel *nameLable;
//时间
@property (nonatomic,weak) UILabel *timeLable;
//来源
@property (nonatomic,weak) UILabel *soureLable;
//正文
@property (nonatomic,weak) UILabel *contentLable;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) JCStatusPhotosView *retweetPhotoView;

/** 工具条 */
@property (nonatomic,weak) JCStatusToolbar * toolbar;

@end
@implementation JCStatusCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    JCStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
//重写setframe实现cell的向下偏移
-(void)setFrame:(CGRect)frame
{
    frame.origin.y += JCStatusCellMargin;
    [super setFrame:frame];
}
/**
*
*/
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setupOrigina];
        
        [self setupRetweet];
        
        [self setupToolbar];
    }
    return  self;
}
/** 初始化原创微博 */
-(void)setupOrigina
{
    //原创微博整体
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    //头像
    UIImageView *iconView = [[UIImageView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    //昵称
    UILabel *nameLable = [[UILabel alloc]init];
    nameLable.font = JCStatusCellNameFront;
    [originalView addSubview:nameLable];
    self.nameLable = nameLable;
    //会员图标
    UIImageView *vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    //时间
    UILabel *timeLable = [[UILabel alloc]init];
    timeLable.font = JCStatusCellTimeFront;
    timeLable.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLable];
    self.timeLable = timeLable;
    //来源
    UILabel *soureLable = [[UILabel alloc]init];
    soureLable.font = JCStatusCellSourceFront;
    [originalView addSubview:soureLable];
    self.soureLable = soureLable;
    //正文
    UILabel *contentLable = [[UILabel alloc]init];
    contentLable.numberOfLines = 0;
    contentLable.font = JCStatusCellContentFront;
    [originalView addSubview:contentLable];
    self.contentLable = contentLable;
    //配图
    JCStatusPhotosView *photoView = [[JCStatusPhotosView alloc]init];
    [originalView addSubview:photoView];
    self.photoView = photoView;

}
/** 初始化转发微博 */
-(void)setupRetweet
{
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor =  JCColor(247, 247, 247);
    [self.contentView addSubview: retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = JCstatusCellRetweentContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    JCStatusPhotosView *retweetPhoto = [[JCStatusPhotosView alloc]init];
    [retweetView addSubview:retweetPhoto];
    self.retweetPhotoView = retweetPhoto;
    
}
-(void)setupToolbar
{
    JCStatusToolbar *toolbar = [[JCStatusToolbar alloc]init];
    [toolbar setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
    
}
-(void)setStatusFrame:(JCStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    JCStatuses *status = statusFrame.status;
    JCUser *user = status.user;
    
    //原创微博整体
    self.originalView.frame = statusFrame.originalViewF;
    //头像
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //会员图标
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    }else{
        self.vipView.hidden = YES;
    }
    
    //昵称
    self.nameLable.text = user.name;
//    self.nameLable.backgroundColor = [UIColor redColor];
    self.nameLable.frame = statusFrame.nameLableF;
/**
    //时间
    self.timeLable.text = status.created_at;
    self.timeLable.frame = statusFrame.timeLableF;
    //来源
    self.soureLable.text = status.source;
//    self.soureLable.backgroundColor = [UIColor greenColor];
    self.soureLable.frame = statusFrame.soureLableF;
 */
    //时间
    self.timeLable.text = status.created_at;
    CGFloat timeX = statusFrame.nameLableF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLableF) + JCStatusCellBorderW;
    CGSize  timeSize = [status.created_at sizeWithFont:JCStatusCellTimeFront];
    //    self.timeLableF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.timeLable.frame = (CGRect){{timeX,timeY},timeSize};
    //来源
    self.soureLable.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLable.frame) + JCStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [status.source sizeWithFont:JCStatusCellSourceFront];
    self.soureLable.frame = (CGRect){{sourceX,sourceY},sourceSize};

    //正文
    self.contentLable.text = status.text;
    self.contentLable.frame = statusFrame.contentLableF;
    //配图
    if (status.pic_urls.count) {
        self.photoView.frame = statusFrame.photoViewF;
        self.photoView.photos = status.pic_urls;
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden =YES;
    }
    
    //被转发的微博
    if (status.retweeted_status) {
        JCStatuses *retweeted_status = status.retweeted_status;
        JCUser *retweeted_status_user = status.user;
        
        self.retweetView.hidden = NO;
        //被转发微博的整体
        self.retweetView.frame = statusFrame.retweetViewF;
        //被转发微博的正文
        NSString *retweetedContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        self.retweetContentLabel.text = retweetedContent;
        //被转发微博的配图
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            self.retweetPhotoView.photos = retweeted_status.pic_urls;
            self.retweetPhotoView.hidden = NO;
        }else{
            self.retweetPhotoView.hidden =YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    
    /** 工具条 */
    self.toolbar.frame =statusFrame.statusToolbarF;
    self.toolbar.status = status;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
