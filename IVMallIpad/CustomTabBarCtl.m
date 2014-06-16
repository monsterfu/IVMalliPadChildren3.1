//
//  CustomTabBarCtl.m
//  CustomTabBarController
//
//  Created by qianfeng on 13-9-5.
//  Copyright (c) 2013年 qianfeng. All rights reserved.
//

#import "CustomTabBarCtl.h"
#import "Commonality.h"
#import "Macro.h"
#import "AppDelegate.h"
#import "ChildrenViewController.h"
@interface CustomTabBarCtl ()

@end


static UIButton*slectButton;
#define degreesToRadian(x) (M_PI * (x) / 180.0)
@implementation CustomTabBarCtl

-(id) initWithCtl:(NSMutableArray *)viewCtlArr andTitleStr:(NSMutableArray *)titleArr andImgDic:(NSMutableDictionary *)imgDic
{
    self = [super init];
    if (self) {
        _viewControllers = [viewCtlArr mutableCopy];
        _titleArr = [titleArr mutableCopy];
        _imgDic = [imgDic mutableCopy];
        _viewCtlNum = 0;
        _isTakingPhoto = NO;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    _isTakingPhoto = NO;
//    if (AppDelegate.App.collect.isPlayHidend == YES) {
//        AppDelegate.App.userView.hidden = NO;
//        AppDelegate.App.userView.myView.hidden = NO;
//        AppDelegate.App.collect.hidden = NO;
//        AppDelegate.App.collect.myView.hidden = NO;
//        AppDelegate.App.collect.isPlayHidend = NO;
//    }
//    if (AppDelegate.App.playHistVIew.isPlayHidend == YES) {
//        AppDelegate.App.userView.hidden = NO;
//        AppDelegate.App.userView.myView.hidden = NO;
//        AppDelegate.App.playHistVIew.hidden = NO;
//        AppDelegate.App.playHistVIew.myView.hidden = NO;
//        AppDelegate.App.playHistVIew.isPlayHidend = NO;
//    }
}

-(void)reloadViewCtlsWithTitleArr:(NSMutableArray *)titleArr andViewCtlArr:(NSMutableArray *)viewCtlArr
{
    if (_tabBar) {
        [_tabBar removeFromSuperview];
        _tabBar = nil;
    }
    [_viewControllers removeAllObjects];
    _viewControllers = [viewCtlArr mutableCopy];
    [_titleArr removeAllObjects];
    _titleArr = [titleArr mutableCopy];
    _viewCtlNum = 0;
    _isTakingPhoto = NO;
    [self chooseView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.view.exclusiveTouch = YES;
    CGRect rect=[UIScreen mainScreen].bounds;
    int count=20;
    if(IOS7){
        count=0;
    }
    
    _customContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.height, rect.size.width-count)];
    _customContentView.backgroundColor = [UIColor clearColor];
    [self chooseView];
    
    if (![Commonality isEnableWIFI]) {
        _noWifiAlertView = [[UIAlertView alloc]initWithTitle:nil message:NOWIFIERROR delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [_noWifiAlertView show];
        return;
    }
}

-(void)chooseView
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString* copyright=[userDefaultes objectForKey:@"copyright_Ivmall"];
    
    if ( copyright && [copyright isEqualToString:@"true"] ) {
        NSLog(@"UIViewController * ctl = [_viewControllers objectAtIndex:0]");
        CHECK_NONERETURN(_viewControllers.count > 0);
        UIViewController * ctl = [_viewControllers objectAtIndex:0];
        CGRect rect1 = _customContentView.frame;
        ctl.view.frame = rect1;
        _viewCtlNum = 0;
        
        if (_customContentView.superview != self.view) {
            [self.view addSubview:_customContentView];
        }
        for (int i = 0; i < _customContentView.subviews.count; i++) {
            UIView * v = [_customContentView.subviews objectAtIndex:i];
            [v removeFromSuperview];
            v = nil;
        }
        
        [_customContentView addSubview:ctl.view];
        
    }else{
       
        
        _viewCtlNum = 1;
        
        for (int i = 0; i < _customContentView.subviews.count; i++) {
            UIView * v = [_customContentView.subviews objectAtIndex:i];
            [v removeFromSuperview];
            v = nil;
        }
        
        
        UIViewController * ctl = [_viewControllers objectAtIndex:0];
        CGRect rect1 = _customContentView.frame;
        ctl.view.frame = rect1;
        [_customContentView addSubview:ctl.view];
        if (_customContentView.superview != self.view) {
            [self.view addSubview:_customContentView];
        }
        
    }
    if (_tabBar == nil) {
        _tabBar = [[UIView alloc] initWithFrame:CGRectMake(200, 23.5, _customContentView.frame.size.width - 400, 41)];
        _tabBar.backgroundColor = color_2;
        _tabBar.layer.cornerRadius = 20;
        
        _tabBarScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _customContentView.frame.size.width - 400 , 40)];
        _tabBarScroll.contentSize = CGSizeMake(110 * _titleArr.count, 40);
        _tabBarScroll.showsHorizontalScrollIndicator = NO;
        _tabBarScroll.showsVerticalScrollIndicator = NO;
        _tabBarScroll.layer.cornerRadius = 20;
        _tabBarScroll.pagingEnabled = NO;
        [_tabBar addSubview:_tabBarScroll];
        
        [self.view addSubview:_tabBar];
    }
    
    for (int i = 0; i < _titleArr.count; i++) {
        if (_titleArr.count == 0) {
            break;
        }
        UIButton * b = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [b setFrame:CGRectMake(110*i, 0, 110, 40)];
        b.tag = 100 + i;
        [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [b setTitle:[_titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [b setTitleColor:color_14 forState:UIControlStateNormal];
        b.titleLabel.font = font_5;
        b.backgroundColor=[UIColor clearColor];
//        b.alpha = ALOPH;
        b.layer.cornerRadius = 20;
        [_tabBarScroll addSubview:b];
    }
    
    if (_animationView) {
        [_animationView removeFromSuperview];
        _animationView = nil;
    }
    _animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, 110, 39)];
    _animationView.backgroundColor = color_3;
    _animationView.alpha = 1.0;
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _animationView.frame.size.width, _animationView.frame.size.height)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = color_14;
    _titleLabel.text = @"推荐";
    _titleLabel.font = font_5;
    [_animationView addSubview:_titleLabel];
    [Commonality setImgViewStyle:_animationView];
    UIButton*button=(UIButton*)[_tabBar viewWithTag:100];
    slectButton=button;
    
//    _animationView.layer.borderWidth = 1;
//    _animationView.layer.borderColor = [UIColor clearColor].CGColor;
//    _animationView.layer.shadowOffset = CGSizeMake(0, 0);
//    _animationView.layer.shadowRadius = 10;
//    _animationView.layer.shadowOpacity = 0.5;
//    _animationView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_animationView.bounds].CGPath;
    [_tabBarScroll addSubview:_animationView];
}

- (void)click:(UIButton *)b{
    [slectButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//    [b setTitleColor:[Commonality colorFromHexRGB:MANETIONCOLOL] forState:(UIControlStateNormal)];
    
    

    
    slectButton=b;
    
    for (int i = 0; i < _customContentView.subviews.count; i++) {
        UIView * v = [_customContentView.subviews objectAtIndex:i];
        [v removeFromSuperview];
        v = nil;
    }
    
//    UIViewController * ctl = [_viewControllers objectAtIndex:b.tag-100];
//    CGRect rect = _customContentView.frame;
//    ctl.view.frame = rect;
//    [_customContentView addSubview:ctl.view];
//    _viewCtlNum = b.tag - 100;
    
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.4];
//    [_animationView setFrame:CGRectMake(b.frame.origin.x + 5, _animationView.frame.origin.y , 90, 36)];
//    _titleLabel.text = [_titleArr objectAtIndex:b.tag - 100];
//    [UIView commitAnimations];
    [_animationView setFrame:CGRectMake(b.frame.origin.x, 0.5, 110, 39)];
    _titleLabel.text = [_titleArr objectAtIndex:b.tag - 100];
    UIViewController * ctl = [_viewControllers objectAtIndex:b.tag-100];
    CGRect rect = _customContentView.frame;
    ctl.view.frame = rect;
    if ([ctl isKindOfClass:[ChildrenViewController class]]) {
        ChildrenViewController * children = (ChildrenViewController *)ctl;
        [children clickClassButton:b.tag - 101];
    }
    [_customContentView addSubview:ctl.view];
    _viewCtlNum = b.tag - 100;
    
}


#pragma mark  横屏

static NSUInteger RotateNum = 0; //增加此静态变量为了解决当rotate sensor为face up/down时 popup无法知道当前tabbar的已转向
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    int i = 0; for (UIView *view in window.subviews)
    {
        if (i != 0)
        {
//            UIWindow*wind=(UIWindow*)[[UIApplication sharedApplication]delegate].window;
//            view.center = _customContentView.center;
            
            [UIView animateWithDuration:duration animations:^(void){
                CGAffineTransform transform = view.transform;
                transform = CGAffineTransformRotate(transform, degreesToRadian(180));
                view.transform = transform;
                if (toInterfaceOrientation == 3) {
                    view.frame = CGRectOffset(view.frame, 0, 0);
                }
                else if (toInterfaceOrientation == 4)
                {
                    view.frame = CGRectOffset(view.frame, 0, 0);
                }
                
            }];
            
        }
        i++;
        RotateNum ++;
        [[NSUserDefaults standardUserDefaults]setInteger:RotateNum forKey:@"Tabbar_RotateNum"];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        return YES;
    }
    else
    {
        if (_isTakingPhoto == YES) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
    
}

//为了支持iOS6
-(BOOL)shouldAutorotate
{
    return YES;
}

//为了支持iOS6
-(NSUInteger)supportedInterfaceOrientations
{
//    if (_isTakingPhoto == NO) {
//        return UIInterfaceOrientationMaskLandscape;
//    }
//    else
//    {
//       return UIInterfaceOrientationMaskPortrait;
//    }
//    
    
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)takePhoto
{
    UIActionSheet *photoBtnActionSheet =
    [[UIActionSheet alloc] initWithTitle:nil
                                delegate:self
                       cancelButtonTitle:@"Cancel"
                  destructiveButtonTitle:nil
                       otherButtonTitles:@"拍照",@"选择本地图片", nil];
    [photoBtnActionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    [photoBtnActionSheet showInView:self.view];
    photoBtnActionSheet.tintColor = [UIColor blackColor];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        @try {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                UIImagePickerController *imgPickerVC = [[UIImagePickerController alloc] init];
                [imgPickerVC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                [imgPickerVC.navigationBar setBarStyle:UIBarStyleBlack];
                [imgPickerVC setDelegate:self];
                [imgPickerVC setAllowsEditing:YES];
                _isTakingPhoto = YES;
                [self presentViewController:imgPickerVC animated:YES completion:nil];
            }else {
//                [Commonality showErrorMsg:self.view type:0 msg:@"IVmall没有权限访问相册"];
            }
        }
        @catch (NSException *exception) {
//            [Commonality showErrorMsg:self.view type:0 msg:@"IVmall没有权限访问相册"];
        }
    }
    if (buttonIndex == 0) {
        @try {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *cameraVC = [[UIImagePickerController alloc] init];
                [cameraVC setSourceType:UIImagePickerControllerSourceTypeCamera];
                [cameraVC.navigationBar setBarStyle:UIBarStyleBlack];
                [cameraVC setDelegate:self];
                [cameraVC setAllowsEditing:YES];
                [self presentViewController:cameraVC animated:YES completion:nil];
                
            }else {
//                [Commonality showErrorMsg:self.view type:0 msg:@"IVmall没有权限调用摄像头"];
            }
        }
        @catch (NSException *exception) {
//            [Commonality showErrorMsg:self.view type:0 msg:@"IVmall没有权限调用摄像头"];
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    if (![Commonality isEnableWIFI]) {
////        [Commonality showErrorMsg:self.view type:0 msg:LINGKERROR];
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:LINGKERROR delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
////        [self dismissViewControllerAnimated:YES completion:nil];
//        return;
//    }
    
    UIImage * img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (img == nil) {
        img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
//    [AppDelegate App].userView.heatImgView.image = img;
    UIImage *pickImg = img;
//    UIImage *pickImg = [info objectForKey:UIImagePickerControllerEditedImage];
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    // 绘制改变大小的图片
    [pickImg drawInRect:CGRectMake(0, 0, 200, 200)];
    // 从当前context中创建一个改变大小后的图片
    pickImg = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    [NSThread detachNewThreadSelector:@selector(postImageData:) toTarget:self withObject:pickImg];

//    NSData *data;
//    NSString *ext;
//    //判断图片是不是png格式的文件
//    if (UIImagePNGRepresentation(pickImg)) {
//        //返回为png图像。
//        ext = @".png";
//        data = UIImagePNGRepresentation(pickImg);
//    }else {
//        //返回为JPEG图像。
//        ext = @".jpg";
//        data = UIImageJPEGRepresentation(pickImg, 1.0);
//    }
//    //找图片路径
//    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *uploadPath = [cachePath stringByAppendingPathComponent:@"upload"];
//    NSString *iconFile = [[uploadPath stringByAppendingPathComponent:@"icon"]stringByAppendingString:ext];
//    [[NSFileManager defaultManager] createFileAtPath:iconFile contents:data attributes:nil];
//    //iconChoice 是之前实例化的一个控制器，用来控制是否上传图片的。
//    UIImageView *iconImg = [iconChoice.subviews objectAtIndex:0];
//    //将剪裁好的图片显示到UI
//    [iconImg setImage:pickImg];
//    //iconData是用来保存图片数据的，用来上传到服务器，iocnExt是图片后缀
//    iconData = data;
//    iconExt = ext;
    
    //上传刚才保存好的图片数据
//    [postData appendData:iconData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)postImageData:(UIImage *)image
{
    NSString* url = [NSString stringWithFormat:@"%@/user/updateAvatar.action?token=%@",BASE,[AppDelegate App].personModel.tokenid];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //得到图片的data
    NSData* data;
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    NSMutableString *body=[[NSMutableString alloc]init];
    [body appendFormat:@"%@\r\n",MPboundary];
    
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",@"file",@"file"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/png\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    [myRequestData appendData:data];
    
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    
    NSHTTPURLResponse *urlResponese = nil;
    NSError *error = [[NSError alloc]init];
    NSData* resultData = [NSURLConnection sendSynchronousRequest:request   returningResponse:&urlResponese error:&error];
    NSString* result= [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    NSLog(@"返回结果=====%@,urlResponese statusCode=%d",result,[urlResponese statusCode]);
    if([urlResponese statusCode] ==200){
//        [AppDelegate App].userView.heatImgView.image = image;
    }
    else if ([urlResponese statusCode] ==0)
    {
//        [Commonality showErrorMsg:self.view type:0 msg:LINGKERROR];
//        [self performSelector:@selector(showPhotoError) withObject:nil afterDelay:1];
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _noWifiAlertView) {
        abort();
    }
    [self performSelector:@selector(dismisViewCtl) withObject:nil afterDelay:0.5];
}

-(void)dismisViewCtl
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
