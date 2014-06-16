//
//  AppDelegate.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "AppDelegate.h"
#import "ChildrenViewController.h"
#import "HttpRequest.h"
#import "Macro.h"
#import "Commonality.h"
#import "MainViewController.h"
#import "GuideViewController.h"
#import "CustomTabBarCtl.h"
#import "IVMallPlayer.h"
#import "AppConfigModel.h"
#import "BPush.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configControl];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent
                                                animated:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerInit:@"locodrm-server.locostream.com.cn":nil];
    _deviceInfoDic = [[IVMallPlayer sharedIVMallPlayer] IVMallPlayerGetLocalInfo];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
        _isIOS7=YES;
        self.countIOS7=20.0;
    }else{
        _isIOS7=NO;
        self.countIOS7=0;
    }
    
    [self initPerosonInfo];
//    _userView=[[UserView alloc]initMy];
//    _userView.hihel=YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    
    MainViewController*rootViewController=[[MainViewController alloc]init];
    ChildrenViewController*chaldrenViewController=[[ChildrenViewController alloc]init];

    NSMutableArray * titleArr = [NSMutableArray arrayWithObjects:@"推荐",@"语言沟通",@"肢体律动",@"社会情绪",@"百科认知",@"幼幼乐园",nil];
    NSMutableArray * viewCtlArr1 = [NSMutableArray arrayWithObjects:rootViewController,chaldrenViewController,chaldrenViewController,chaldrenViewController,chaldrenViewController,chaldrenViewController,nil];

    _tabBarController = [[CustomTabBarCtl alloc] initWithCtl:viewCtlArr1 andTitleStr:titleArr andImgDic:nil];
    _tabBarController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    
    _personView = [[PersonnalCenter alloc] init];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:_tabBarController];
    self.window.rootViewController=nav;
    
    nav.navigationBarHidden = YES;
//    self.window.rootViewController=_tabBarController;
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Tabbar_RotateNum"];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
  
    
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
    [application setApplicationIconBadgeNumber:0];
    [application  registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert
     | UIRemoteNotificationTypeBadge
     | UIRemoteNotificationTypeSound];
    
    [self commitDownloadTimes];
    
    _cateArray = [[NSMutableArray alloc] init];
    if ([Commonality isEnableWIFI]) {
        [self list];
    }

    return YES;
}

-(void)list
{
    [HttpRequest categoryRequestChannelCode:@"children" pag:1 delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

- (void)onMethod:(NSString*)method response:(NSDictionary*)data {
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    if ([BPushRequestMethod_Bind isEqualToString:method]) {
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
//        NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        
        if (returnCode == BPushErrorCode_Success) {
            self.appId = appid;
            self.channelId = channelid;
            self.userId = userid;
        }
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
        }
    }
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [BPush registerDeviceToken: deviceToken];
    [BPush bindChannel];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"error is %@",error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"爱V猫提醒您"
                                                            message:[NSString stringWithFormat:@"%@", alert]
                                                           delegate:self
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    [application setApplicationIconBadgeNumber:0];
    
    [BPush handleNotification:userInfo];
}

-(void)commitDownloadTimes
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString * isCommit = [userDefaultes objectForKey:@"isCommited"];
    NSString* deviceDRMId = [_deviceInfoDic objectForKey:@"deviceDRMId"];
    if (![isCommit isEqualToString:@"YES"]) {
        [HttpRequest appInstallTimesRequestDeviceDRMId:deviceDRMId delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
}

-(void)configControl
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    _copyright=[userDefaultes objectForKey:@"copyright_Ivmall"];
    _charge=[userDefaultes objectForKey:@"charge_Ivmall"];
    if (_copyright == nil || _charge == nil) {
        
        ASIHTTPRequest* asiRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:CONFIG]];
        asiRequest.tag=CONFIG_TYPE;
        [asiRequest appendPostData:[[NSString stringWithFormat:@"{\"client\":\"%@\",\"appVersion\":\"%@\",}",@"ipad",IVMALL_VERSION] dataUsingEncoding:NSUTF8StringEncoding]];
        [asiRequest setUseSessionPersistence:YES];
        [asiRequest setUseCookiePersistence:YES];
        [asiRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [asiRequest setDelegate:self];
        [asiRequest setDidFinishSelector:@selector(GetResult:)];
        [asiRequest setDidFailSelector:@selector(GetErr:)];
//        [asiRequest startSynchronous];//同步
        [asiRequest startAsynchronous];
//        sleep(6);
    }
//    else if([_copyright isEqualToString:@"true"] && [_charge isEqualToString:@"true"])
//    {
//        [BPush setupChannel:launchOptionsDic];
//        [BPush setDelegate:self];
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//        [[UIApplication sharedApplication]  registerForRemoteNotificationTypes:
//         UIRemoteNotificationTypeAlert
//         | UIRemoteNotificationTypeBadge
//         | UIRemoteNotificationTypeSound];
//    }
    
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _alertView) {
        if (buttonIndex == 0) {
            exit(0);
        }
    }
}


-(void)initPerosonInfo{
    _isLogin=NO;
    _personModel=[[PersonModel alloc]init];
    _selectedDic = [[NSMutableDictionary alloc] init];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    _personModel.nickname = [userDefaultes stringForKey:@"nickname"];
    _personModel.email = [userDefaultes stringForKey:@"email"];
    _personModel.lang = [userDefaultes stringForKey:@"lang"];
    _personModel.sex = [userDefaultes stringForKey:@"sex"];
    _personModel.birthYear=[userDefaultes stringForKey:@"birthday"];
    _personModel.mobile=[userDefaultes stringForKey:@"mobile"];
    _personModel.password=[userDefaultes stringForKey:@"password"];
    _personModel.address=[userDefaultes stringForKey:@"address"];
    
    
    if ([Commonality isEmpty:_personModel.balance]) {
        _personModel.balance=@"";
    }
    _personModel.tokenid=@"";
    
    if ([Commonality isEmpty:_personModel.nickname]) {
        _personModel.nickname=@"";
    }
    
    if ([Commonality isEmpty:_personModel.email]) {
        _personModel.email=@"";
    }
    
    if ([Commonality isEmpty:_personModel.birthYear]) {
        _personModel.birthYear=@"";
    }
    
    if ([Commonality isEmpty:_personModel.sex]) {
        _personModel.sex=@"M";
    }
    
    if ([Commonality isEmpty:_personModel.lang]) {
        _personModel.lang=@"zh-cn";
    }
    
    [userDefaultes setObject:IVMALL_VERSION forKey:@"NO.1"];
    [userDefaultes synchronize];
    
    if (![Commonality isEmpty:_personModel.mobile]&&![Commonality isEmpty:_personModel.password]) {
        [HttpRequest LoginRequest:_personModel.mobile password:_personModel.password delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
}

-(void)showError
{
    ChildrenViewController * childreViewCtl = [_tabBarController.viewControllers objectAtIndex:1];
    if (childreViewCtl.isWifiResume == NO) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"当前网络异常，请先退出应用配置网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        [alert show];
        return;
    }
}

-(void) GetErr:(ASIHTTPRequest *)request{
//    if (request.tag == CONFIG_TYPE) {
//        
//        if (!_alertView) {
//            _alertView = [[UIAlertView alloc] initWithTitle:nil message:@"当前网络异常，请先退出应用配置网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            _alertView.delegate = self;
//            [_alertView show];
//            return;
//        }
//    }
}

-(void) GetResult:(ASIHTTPRequest *)request{
    NSData *responseData = [request responseData];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"%@",[dictionary description]);
    if (dictionary==nil) {
        if (request.tag == CONFIG_TYPE) {
            if (!_alertView) {
                _alertView = [[UIAlertView alloc] initWithTitle:nil message:@"当前网络异常，请先退出应用配置网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                _alertView.delegate = self;
                [_alertView show];
                return;
            }
            
        }
    }else{
        if (request.tag==0) {
            UserLoginModel*usr=[[UserLoginModel alloc]initWithDictionary:dictionary];
  
            if (usr.result==0) {
                _isLogin=YES;
                NSLog(@"MainViewController * mainViewCtl = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];");
                MainViewController * mainViewCtl = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
                [mainViewCtl markHomeRequest];
                [self bindingEquipment];
            }else{
                _isLogin=NO;
            }

        }else if(request.tag==BINDING_TYPE){
            NSLog(@"进入时绑定");
        }
        else if (request.tag == CONFIG_TYPE)
        {
            AppConfigModel*config=[[AppConfigModel alloc]initWithDictionary:dictionary];
            if (config.result==0) {
                _copyright=config.copyright;//版权
                _charge = config.charge;//收费
                NSLog(@"_charge is %@",_charge);
                NSLog(@"_copyright i s%@",_copyright);
//                _copyright = @"true";
//                _charge = @"true";
//                _copyright = @"true2312";
//                _charge = @"true13";
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                [userDefaultes setObject:_copyright forKey:@"copyright_Ivmall"];
                [userDefaultes setObject:_charge forKey:@"charge_Ivmall"];
                [userDefaultes synchronize];
            }
            if ( [_charge isEqualToString:@"true"] && [_copyright isEqualToString:@"true"]) {
                
                [_tabBarController chooseView];
//                [_userView configControl];
//                if (_userView.myTableView) {
//                    [_userView.myTableView reloadData];
//                }
            
            }
            
        }
        else if (request.tag == APPINSTALLTIMES_TYPE)
        {
            if ([[dictionary objectForKey:@"errorCode"] intValue] == 0) {
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                [userDefaultes setObject:@"YES" forKey:@"isCommited"];
            }
        }
        else if (request.tag == ALIPAYTRADERESULT_TYPE)
        {
//            [_rechargeView reloadUI:dictionary];
            if (_reloadBalanceDelegate && [_reloadBalanceDelegate respondsToSelector:@selector(reloadBalance:)]) {
                [_reloadBalanceDelegate reloadBalance:dictionary];
            }
        }
        else if (request.tag == CATEGORY_TYPE)
        {
            [self passGory:dictionary];
        }
        
    }
    
}

-(void)passGory:(NSDictionary*)dic{
    ChannelCategoryListModel*cat=[[ChannelCategoryListModel alloc]initWithDictionary:dic modelList:_cateArray page:1];
    if (cat.result==0) {
        
        NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
        [user setObject:dic forKey:@"children_heat_cache"];
        [user synchronize];
        
        NSMutableArray * titleArr = [[NSMutableArray alloc] init];
        [titleArr addObject:@"推荐"];
        
        for (int i=0; i<[_cateArray count]; i++) {
            CHECK_NONERETURN(i < _cateArray.count);
            ChannelCategoryListModel*cah=[_cateArray objectAtIndex:i];
            
            if ([cah.categoryName rangeOfString:@"直播"].location != NSNotFound) {
                return;
            }
            [titleArr addObject:cah.categoryName];
            
        }
        NSMutableArray * ViewCtlArr = [[NSMutableArray alloc] init];
        MainViewController * main = [[MainViewController alloc] init];
        [ViewCtlArr addObject:main];
        for (int i = 0; i < titleArr.count; i++) {
            ChildrenViewController * children = [[ChildrenViewController alloc] init];
            [ViewCtlArr addObject:children];
        }
        
        [_tabBarController reloadViewCtlsWithTitleArr:titleArr andViewCtlArr:ViewCtlArr];
        
        
    }else{
//        [Commonality showErrorMsg:self.view type:cat.result msg:@"网络连接异常，请重试"];
    }
}

#pragma mark -
-(void)bindingEquipment{
    NSString* modelStr = [_deviceInfoDic objectForKey:@"deviceDRMId"];
    [HttpRequest BingdingToken:self.personModel.tokenid delegate:self deviceDRMID:modelStr DRMType:[_deviceInfoDic objectForKey:@"drmType"] seral:[_deviceInfoDic objectForKey:@"seiralNo"] macAddr:[_deviceInfoDic objectForKey:@"macAddr"] appVersion:[_deviceInfoDic objectForKey:@"appVersion"] osVersion:[_deviceInfoDic objectForKey:@"osVersion"] deviceInfo:nil inishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}


+(AppDelegate *)App{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)applicationWillResignActive:(UIApplication *)application{
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    [AppDelegate App].tabBarController.view.alpha = 1;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [self configControl];
    [self commitDownloadTimes];
}

- (void)applicationWillTerminate:(UIApplication *)application{
    [[IVMallPlayer sharedIVMallPlayer]IVMallPlayerDestroy];
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (_tabBarController.isTakingPhoto == YES)
    {
        return UIInterfaceOrientationMaskAll;
    }
    else
    {
       return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [self parse:url application:application];
    return YES;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
            [HttpRequest AlipayTradeResultRequestToken:self.personModel.tokenid outTradeNo:self.outTradeNo price:self.totalFee delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}


@end
