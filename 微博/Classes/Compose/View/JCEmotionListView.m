//
//  JCEmotionListView.m
//  夏至的微博
//
//  Created by yingyi on 15/8/25.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCEmotionListView.h"
#import "JCEmotionPageView.h"
#import "UIView+Extension.h"

@interface JCEmotionListView()<UIScrollViewDelegate>
@property (nonatomic ,weak)UIScrollView *scrollView;
@property (nonatomic ,weak)UIPageControl *pageControl;
@end

@implementation JCEmotionListView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加scollview
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        //去除scrollview的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //添加pagecontrol
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.userInteractionEnabled = NO;
        //设置内部原点的图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return  self;
}
-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
//    NSLog(@"%lu",emotions.count);
    NSUInteger count = (emotions.count + JCEmotionPageSize - 1) / JCEmotionPageSize;
    self.pageControl.numberOfPages = count;
    
    for (int i = 0; i < count; i++) {
        JCEmotionPageView *pageView = [[JCEmotionPageView alloc]init];
        //计算每一页表情的数量
        NSRange range;
        range.location = i * JCEmotionPageSize;
        if (i == count - 1) {
            range.length = emotions.count - JCEmotionPageSize * i;
        }else{
            range.length = JCEmotionPageSize;
        }
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    //scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.height - self.pageControl.height;
    self.x = self.y =0;
    
    //scrollView中的每一个页面的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        JCEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    //设置scrollview的contentsize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
}

#pragma mark -scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}
@end
