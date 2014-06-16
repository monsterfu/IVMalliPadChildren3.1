//
//  AppDelegate.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"
#import "HttpRequest.h"
#import "UserView.h"
#import "BuyView.h"
#import "CollectView.h"
#import "UserInfoView.h"
#import "CustomTabBarCtl.h"
#import "RegistView.h"
#import "ForgetPasswordView.h"
#import "UserLoginModel.h"
#import "RechargeView.h"
#import "RechargeRecordView.h"
#import "VipListView.h"
#import "AboutUsView.h"
#import "PlayHistoryView.h"
#import "PlayTimeView.h"
#import "PersonnalCenter.h"

//支付宝
#import "AlixPayResult.h"
#import "DataVerifier.h"
//支付宝

@class PersonnalCenter;

@interface AppDelegate : UIResponder <UIApplicationDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>
{
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,strong) PersonModel* personModel;
//@property(nonatomic,strong) UserView*userView;
//@property(nonatomic,strong) BuyView*buyView;
//@property(nonatomic,strong)CollectView*collect;
//@property (nonatomic,strong) UserInfoView * userInfomationView;
@property(nonatomic,strong)CustomTabBarCtl*tabBarController;
@property(nonatomic, strong)PersonnalCenter * personView;
@property (nonatomic, strong) RegistView *registView;
@property(nonatomic,assign)BOOL isIOS7;
@property(nonatomic,assign)float countIOS7;
//@property (nonatomic, strong) ForgetPasswordView *forgetPasswordView;
//@property (nonatomic, strong) RechargeView * rechargeView;
//@property (nonatomic, strong) RechargeRecordView * rechargeRecordView;
//@property (nonatomic, strong) VipListView * vipListView;
//@property (nonatomic, strong) AboutUsView * aboutUsView;
//@property (nonatomic, strong) PlayHistoryView * playHistVIew;
//@property (nonatomic, strong) PlayTimeView * playedTimeView;
@property (nonatomic, strong) NSMutableDictionary * selectedDic;
@property (nonatomic, strong) NSString * copyright;
@property (nonatomic, strong) NSString * charge;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *userId;
@property(nonatomic,strong)NSMutableDictionary*deviceInfoDic;

@property (nonatomic,strong)NSString* facState;

@property(nonatomic,assign)CGPoint selctImgCent;
@property(nonatomic,strong)UIAlertView * alertView;
@property(nonatomic,strong)UIAlertView * statcAlertView;
@property(nonatomic,strong)NSMutableArray * cateArray;
//支付宝
@property(nonatomic,strong)NSString* outTradeNo;
@property(nonatomic,assign)double totalFee;
//支付宝
@property(nonatomic,assign)id<rechargeViewReloadDataDelegate>reloadBalanceDelegate;

+(AppDelegate *)App;

-(void)list;
@end
