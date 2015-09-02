//
//  JCHomeViewController.m
//  微博
//
//  Created by jamesczy on 15/7/12.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "AFNetworking.h"
#import "JCAccountTool.h"
#import "JCAccount.h"
#import "JCConst.h"
#import "JCDropdownMenu.h"
#import "UIView+Extension.h"
#import "JCTitleMenuViewController.h"
#import "UIImageView+WebCache.h"
#import "JCStatuses.h"
#import "JCUser.h"
#import "MJExtension.h"
#import "JCLoadMoreFoot.h"
#import "JCStatusCell.h"
#import "JCStatusFrame.h"
#import "JCTitleButton.h"

@interface JCHomeViewController ()
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation JCHomeViewController
-(NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
    CGFloat viewBtnX = [UIScreen mainScreen].bounds.size.width - 90;
    CGFloat viewBtnY = [UIScreen mainScreen].bounds.size.height *0.8;
    CGFloat viewBtnWH = 80;
    CGRect viewBtnF = CGRectMake(viewBtnX, viewBtnY, viewBtnWH, viewBtnWH);
    
    
    UIButton *viewBtn = [[UIButton alloc]initWithFrame:viewBtnF];
    [viewBtn setBackgroundColor:[UIColor redColor]];
    */
    
    self.tableView.backgroundColor = JCColor(211, 211, 211);
    //设置tableview与导航栏之间的间距
//    self.tableView.contentInset = UIEdgeInsetsMake(JCStatusCellMargin, 0, 0, 0);
    
    //设置导航栏内容
    [self setupNav];
    //设置用户信息
    [self setupUserInfo];
    
    //加载最新的微博数据
//    [self loadNewStatus];
    
    //集成下拉刷新控件
    [self setupRefresh];
    //集成上拉刷新
    [self setDownRefresh];
}

-(void)setDownRefresh
{
    JCLoadMoreFoot *footer = [JCLoadMoreFoot footer];
    self.tableView.tableFooterView = footer;
    self.tableView.tableFooterView.hidden = YES;
    
}
-(void)setupRefresh
{
    //添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    //马上进入刷新状态
    [control beginRefreshing];
    //马上加载数据
    [self loadNewStatus:control];
    
}
//上拉显示更多的老数据
-(void)loadMoreStatus
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //拼接请求参数
    JCAccount *account = [JCAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //获取上次刷新的最前面多微博（最新的微博的id最大）
    JCStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        long long max_id = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(max_id);
    }
    //    params[@"count"] = @5; //默认20条
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //        JCLog(@"请求成功－－>%@",responseObject);
        //取得微博数组
        NSArray *newStatuses = [JCStatuses objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSMutableArray * newFrames =  [self statusFramesWithStatus:newStatuses];
        
        [self.statusFrames addObjectsFromArray:newFrames];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        self.tableView.tableFooterView.hidden = YES;

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        JCLog(@"请求失败－－>%@",error);
        self.tableView.tableFooterView.hidden = YES;
    }];
}
//将JCStatus模型转为JCStatusFrames
-(NSMutableArray *)statusFramesWithStatus:(NSArray *)statuses
{
    NSMutableArray *newFrames = [NSMutableArray array];
    for (JCStatuses *status in statuses) {
        JCStatusFrame *f = [[JCStatusFrame alloc]init];
        f.status = status;
        [newFrames addObject:f];
    }
    return newFrames;
}
-(void)refreshStateChange:(UIRefreshControl *)control
{
//    NSLog(@"refreshStateChange____>");
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //拼接请求参数
    JCAccount *account = [JCAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //获取上次刷新的最前面多微博（最新的微博的id最大）
    JCStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    //    params[@"count"] = @5; //默认20条
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //        JCLog(@"请求成功－－>%@",responseObject);
        //取得微博数组
        NSArray *newStatuses = [JCStatuses objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSMutableArray * newFrames =  [self statusFramesWithStatus:newStatuses];
        
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [control endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        JCLog(@"请求失败－－>%@",error);
        [control endRefreshing];
    }];
    
}
//加载刷新提示
-(void)showNewStatusCount:(NSInteger)count
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    if (count == 0) {
        label.text = @"没有新的微博数据";
        
    }else{
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",count];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    //添加
    label.y = 64 - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //动画
    CGFloat duration = 1.0;  //动画时长
    [UIView animateWithDuration:duration animations:^{
//        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    }completion:^(BOOL finished) {
        CGFloat delay = 1.0; //延时时长
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

-(void)loadNewStatus:(UIRefreshControl *)control
{
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //拼接请求参数
    JCAccount *account = [JCAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博
    JCStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        JCLog(@"请求成功－－>%@",responseObject);
        //取得微博数组
        NSArray *newStatuses = [JCStatuses objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSMutableArray * newFrames =  [self statusFramesWithStatus:newStatuses];
        
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [control endRefreshing];
        //显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        JCLog(@"请求失败－－>%@",error);
    }];
    
}

-(void)setupUserInfo
{
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //拼接请求参数
    JCAccount *account = [JCAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uid"] = account.uid;
    params[@"access_token"] = account.access_token;

    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        JCLog(@"请求成功－－>%@",responseObject);
        JCUser *user = [JCUser objectWithKeyValues:responseObject];
//        NSString *name =  responseObject[@"name"];
        self.navigationItem.title = user.name;
        //将获取的昵称存入沙盒
        account.name = user.name;
        [JCAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        JCLog(@"请求失败－－>%@",error);
    }];
    
}
-(void)setupNav
{
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //设置中间标题按钮
    JCTitleButton *titltButton = [[JCTitleButton alloc]init];
    NSString *name = [JCAccountTool account].name;
    [titltButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    //监听标题点击按钮
    [titltButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titltButton;
}

-(void)titleClick:(UIButton *)titltButton
{
    JCDropdownMenu *menu = [JCDropdownMenu menu];
    menu.delegate = self;
    JCTitleMenuViewController *vc = [[JCTitleMenuViewController alloc]init];
    vc.view.width = 150;
    vc.view.height = 150;
    menu.contentController = vc;
    [menu showFrom:titltButton];
}
- (void)friendsearch {
    NSLog(@"%s",__func__ );
}

-(void)more
{
    NSLog(@"%s",__func__);
}

#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    JCStatusCell *cell = [JCStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom -scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) {
        self.tableView.tableFooterView.hidden = NO;
        [self loadMoreStatus];
    }
//    NSLog(@"scrollViewDidScroll：－－%lf",judgeOffsetY);
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

@end
