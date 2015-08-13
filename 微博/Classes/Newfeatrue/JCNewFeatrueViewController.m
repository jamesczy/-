//
//  JCNewFeatrueViewController.m
//  微博
//
//  Created by jamesczy on 15/7/13.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCNewFeatrueViewController.h"
#import "JCTabBarViewController.h"
#import "UIView+Extension.h"
#import "JCConst.h"

#define JCNewfeatrueCount 4

@interface JCNewFeatrueViewController () <UIScrollViewDelegate>
@property (nonatomic , strong)UIPageControl *pageControl;

@end

@implementation JCNewFeatrueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.delegate =self;
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(JCNewfeatrueCount * scrollView.width, 0);
    [self.view addSubview:scrollView];
    CGFloat scrollH = scrollView.height;
    CGFloat scrollW = scrollView.width;
    for (int i = 0; i < JCNewfeatrueCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.height = scrollH;
        imageView.width = scrollW;
        imageView.y = 0;
        imageView.x = i * scrollView.width;
        //显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        if (i == JCNewfeatrueCount - 1) {
            [self setupLastView:imageView];
        }
        
    }
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    UIPageControl *page = [[UIPageControl alloc]init];
    page.numberOfPages = JCNewfeatrueCount;
    page.height = 50;
    page.width = 100;
    page.centerX = scrollW * 0.5;
//    NSLog(@"%f--%f",page.centerX,scrollW);
    page.centerY = scrollH - 50;
//    page.backgroundColor = [UIColor redColor];
    page.pageIndicatorTintColor = JCColor(189, 189, 189);
    page.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self.view addSubview:page];
    self.pageControl = page;
    
}
-(void)setupLastView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    //checkbox分享给大家
    UIButton *sharBtn = [[UIButton alloc]init];
    [sharBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [sharBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [sharBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [sharBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sharBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sharBtn.width = 105;
    sharBtn.height = 30;
    sharBtn.centerX = imageView.width * 0.5;
    sharBtn.centerY = imageView.height *0.65;
    sharBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [sharBtn addTarget:self action:@selector(sharClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:sharBtn];
    
    //开始体验
    UIButton *startBtn = [[UIButton alloc]init];
//    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
//    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setBackgroundColor:[UIColor orangeColor]];
//    startBtn.size = sharBtn.currentBackgroundImage.size;

    startBtn.width = 105;
    startBtn.height = 36;
    startBtn.centerX = sharBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;

    [startBtn setTitle:@"开始体验" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

-(void)sharClick:(UIButton *)sharBtn
{
    sharBtn.selected = !sharBtn.isSelected;
}
-(void)startClick
{
    UIWindow *window= [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[JCTabBarViewController alloc]init];
}
#pragma mark - sccrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage =((int)(scrollView.contentOffset.x / scrollView.width + 0.5)) % JCNewfeatrueCount;
}

@end
