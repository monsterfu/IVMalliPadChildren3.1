//
//  PersonnalCenter.h
//  IVMallHD
//
//  Created by  周传森 on 14-5-7.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserView.h"
#import "PlayHistoryView.h"
#import "PlayTimeView.h"
#import "CollectView.h"
#import "BuyView.h"
#import "RechargeRecordView.h"
#import "RechargeView.h"
#import "ForgetPasswordView.h"
#import "AboutUsView.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "UserInfoView.h"
#import "ProgramPackage.h"
#import "BuyVipView.h"
#import "UIButton+Bootstrap.h"
#import "RegistView.h"
#import "RechargeSucessView.h"

@interface PersonnalCenter : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,TakePhotoDelegate,showUserDataDelegate,showGatherViewDelegate,showUserInfoDelegate,buyVipDelegate,showProgramViewDelegate,registViewDelegate,UITextFieldDelegate>
{
    UIView * _rightView;
    UserView * _userView;
    PlayHistoryView * _playHiestoryView;
    PlayTimeView * _playTimeView;
    CollectView * _collectView;
    BuyView * _buyView;
    RechargeRecordView * _rechargeRecordView;
    AboutUsView * _aboutUsView;
    UserInfoView * _userInfoView;
//    ProgramPackage * _programView;
    BuyVipView * _buyVipView;
    UIView * _loginView;
    JYTextField * _myPhoneTextField;
    JYTextField * _myPassWordTextField;
    RegistView * _registView;
    int lastClickIndex;
    
    RechargeSucessView* _rechargeSucessView; //added by Monster;
    
}
@property (nonatomic ,strong)UserView * userView;
@property (nonatomic, strong)ForgetPasswordView * forgetPasswordView;
@property (nonatomic, strong)RechargeView * rechargeView;
//@property (nonatomic, strong)
-(void)takePhoto;
-(void)clickTableViewIndex:(int)index;
-(void)showGatherView:(NSString *)guid;
-(void)showUserInfoView;
-(void)showProgramView;
-(void)showLoginView;

-(void)buyVipViewWillShowWithTitle:(NSString *)title andPoints:(NSString *)points andVipID:(NSString *)vipID;
-(void)buyVipViewWillDismiss;
-(void)showProgramViewWithProID:(NSString *)productId;
-(void)showRecharView;

-(void)showRechargeSuccessView:(NSString*)balance;
-(void)showRechargeSucessViewPop:(NSString*)balance isMain:(BOOL)isMain;

-(void)removeRegistView;

-(void)showMyRegistView;
-(void)redrawUserView;
@end


