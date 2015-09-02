//
//  JCComposeViewController.m
//  夏至的微博
//
//  Created by yingyi on 15/8/14.
//  Copyright (c) 2015年 jamesczy. All rights reserved.
//

#import "JCComposeViewController.h"
#import "JCNavigationController.h"
#import "JCAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "JCAccount.h"
#import "UIView+Extension.h"
#import "JCTextView.h"
#import "JCComposeView.h"
#import "AFNetworking.h"
#import "JCComposePhotosView.h"
#import "JCEmotionKeyboard.h"
#import "JCConst.h"
#import "JCEmotion.h"
#import "NSString+Emoji.h"
#import "JCEmotionTextView.h"

@interface JCComposeViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,JCComposeViewDelegate,UITextViewDelegate>
@property (nonatomic, weak) JCEmotionTextView *textView;
@property (nonatomic ,weak)JCComposeView *toolbar;
/** 相册（存放拍照或者相册中选择的图片） */
@property (nonatomic, weak) JCComposePhotosView *photosView;
/** 表情键盘 */
@property (nonatomic ,strong)JCEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘 */
@property (nonatomic ,assign)BOOL switchingKeyboard;
@end

@implementation JCComposeViewController
-(JCEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[JCEmotionKeyboard alloc]init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
    }
    return _emotionKeyboard;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setnavUp];
    [self setTextView];
    [self setupToolbar];
    [self setupPhotoView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}
-(void)setTextView
{
    JCEmotionTextView *textView = [[JCEmotionTextView alloc]init];
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.placeholder = @"发送新鲜事……";
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    self.textView = textView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    //接受键盘改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //接受表情键盘点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:JCEmotionDidSelectNotification object:nil];
    //接受表情键盘删除的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDelete) name:JCEmotionDidDeleteNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//设置导航栏
-(void)setnavUp
{
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(concle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [JCAccountTool account].name ;
    NSString *prefix = @"发微博";
    NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
    if (name) {
        UILabel *titleView = [[UILabel alloc]init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        // 自动换行
        titleView.numberOfLines = 0;
        //创建一个带有属性的字符串(字体／颜色／大小／还可以添加图片)
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        //添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[str rangeOfString:name]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    }else{
        self.title = prefix;
    }

}
-(void)setupToolbar
{
    JCComposeView *toolbar = [[JCComposeView alloc]init ];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.x = 0;
    toolbar.delegate =self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}
-(void)setupPhotoView
{
    JCComposePhotosView *photoView = [[JCComposePhotosView alloc]init];
    photoView.x = 0;
    photoView.y = 100;
    photoView.width = self.view.width;
    photoView.height = self.view.height - photoView.y;
    [self.textView addSubview:photoView];
    self.photosView = photoView;
}
#pragma mark - 监听方法

-(void)emotionDidSelect:(NSNotification *)notification
{
    JCEmotion *emotion = notification.userInfo[JCSelectEmotionKey];
    [self.textView insertEmotion:emotion];
}
-(void)emotionDidDelete
{
    [self.textView deleteBackward];
}
-(void)concle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)send
{
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendWithImage
{
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JCAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    //发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.photosView.photos firstObject];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showMessage:@"发送成功"];
        [self concle];
        [MBProgressHUD hideHUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        [self concle];
        [MBProgressHUD hideHUD];
        
    }];

}

-(void)sendWithoutImage
{
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JCAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    //发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showMessage:@"发送成功"];
        [self concle];
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        [self concle];
        [MBProgressHUD hideHUD];
    }];
    
}
-(void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.switchingKeyboard) return ;
    
    NSDictionary *userInfo = notification.userInfo;
    //动画执行的时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        //工具条的y值 ＝ 键盘的y值 － 工具条的高度
        if (keyboardF.origin.y > self.view.height) {
            self.toolbar.y = self.view.height - self.toolbar.height;
        }else{
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }

    }];
}
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

-(void)composeView:(JCComposeView *)composeView didClickButton:(JCComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case JCComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case JCComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
        case JCComposeToolbarButtonTypeMention:
            NSLog(@"JCComposeToolbarButtonTypeMention");
            break;
        case JCComposeToolbarButtonTypeTrend:
            NSLog(@"JCComposeToolbarButtonTypeTrend");
            break;
        case JCComposeToolbarButtonTypeEmotion:
            
            [self switchKeyboard];
            break;
        default:
            break;
    }
}

#pragma mark - 其他方法
-(void)switchKeyboard
{
    if (self.textView.inputView == nil) {
        
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.showKeyboardButton = YES;
    }else{
        self.textView.inputView = nil;
        self.toolbar.showKeyboardButton = NO;
    }
    self.switchingKeyboard = YES;
    [self.textView endEditing:NO];
    self.switchingKeyboard = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //弹出键盘
        [self.textView becomeFirstResponder];
        //结束键盘
        self.switchingKeyboard = NO;
    });
    
}

-(void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

-(void)openAlbum
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate 代理
/** 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕） */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.photosView addPhotos:info[UIImagePickerControllerOriginalImage]];
}
@end
