//
//  PersonnalCenter.m
//  IVMallHD
//
//  Created by  周传森 on 14-5-7.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "PersonnalCenter.h"

@interface PersonnalCenter ()

@end

@implementation PersonnalCenter

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    //BUG 1632 充值验证码按钮
    if (_registView) {
        [_registView resetCheckCodeBtn];
    }
    if (_forgetPasswordView) {
        [_forgetPasswordView resetCheckCodeBtn];
    }
    if ([_rightView.subviews objectAtIndex:0] == _userInfoView) {
        [_userInfoView show];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setNeedsStatusBarAppearanceUpdate];

    UIView * navGationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.height, 45)];
    navGationBar.backgroundColor = color_6;
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, navGationBar.frame.size.height)];
    lab.text = @"个人中心";
    lab.textColor = [UIColor whiteColor];
    lab.alpha = 0.8;
    lab.font = [UIFont boldSystemFontOfSize:17];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [navGationBar addSubview:lab];
    
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(28, 7, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView* userBgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IndividualCenter_bg.png"]];
    userBgImage.frame=CGRectMake(backBtn.frame.origin.x-10, backBtn.frame.origin.y-10, backBtn.frame.size.height+ 20,backBtn.frame.size.width+20);
    [navGationBar addSubview:userBgImage];
    [navGationBar addSubview:backBtn];
    
    [self.view addSubview:navGationBar];
    
	_userView = [[UserView alloc] initMy];
    _userView.frame = CGRectMake(_userView.frame.origin.x, navGationBar.frame.size.height + 20, _userView.frame.size.width, self.view.frame.size.width - 20 - navGationBar.frame.size.height);
    _userView.delegate = self;
    _userView.userDatadelegate = self;
    _userView.userInfoDelegate = self;
    
    
    _rightView = [[UIView alloc] initWithFrame:CGRectMake(_userView.frame.size.width, navGationBar.frame.size.height + 20, self.view.frame.size.height - _userView.frame.size.width, _userView.frame.size.height)];
    _rightView.backgroundColor = color_21;
    [self.view addSubview:_rightView];
    [self.view addSubview:_userView];
    [self makeLoginView];
    
    if ([AppDelegate App].isLogin) {
//        if (_playHiestoryView == nil) {
//            _playHiestoryView = [[PlayHistoryView alloc] initMyWithFrame:_rightView.bounds];
//        }
//        [_playHiestoryView show];
//        [_rightView addSubview:_playHiestoryView];
        [self showUserInfoView];
    }
    else
    {
        [self showLoginView];
    }

    lastClickIndex = 100;
}

-(void)dismissSelf
{
    [self.navigationController popViewControllerAnimated:YES];
    MainViewController * main =  [[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
    main.view.userInteractionEnabled = YES;
}

-(void)makeLoginView
{
    _loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height)];
//    _loginView.frame = _rightView.frame;
    
    
    UILabel * loginLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, _loginView.frame.size.width, 50)];
    loginLab.backgroundColor = [UIColor clearColor];
    loginLab.font = font_9;
    loginLab.textColor = color_17;
    loginLab.text = @"登录";
    loginLab.textAlignment = NSTextAlignmentCenter;
    [_loginView addSubview:loginLab];
    
    
    _myPhoneTextField=[[JYTextField alloc]initWithFrame:CGRectMake(_rightView.frame.size.width/2 - 208.5, loginLab.frame.origin.y + 50 + 50, 417, 51)
                                          cornerRadio:6
                                          borderColor:[Commonality colorFromHexRGB:@"c3c3c3"]
                                          borderWidth:0.5
                                           lightColor:nil
                                            lightSize:0
                                     lightBorderColor:nil];
    [_myPhoneTextField setPlaceholder:@"手机号码"];
    if ([AppDelegate App].personModel.mobile.length>2) {
        _myPhoneTextField.text=[AppDelegate App].personModel.mobile;
    }
    _myPhoneTextField.delegate=self;
    _myPhoneTextField.tag=2001;
    _myPhoneTextField.backgroundColor=[UIColor whiteColor];
    _myPhoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _myPhoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _userView.phoneTextField = _phoneTextField;
    [_loginView addSubview:_myPhoneTextField];
    
    _myPassWordTextField=[[JYTextField alloc]initWithFrame:CGRectMake(_rightView.frame.size.width/2 - 208.5, _myPhoneTextField.frame.origin.y + 51 + 25, 417, 51)
                                             cornerRadio:6
                                             borderColor:[Commonality colorFromHexRGB:@"c3c3c3"]
                                             borderWidth:0.5
                                              lightColor:nil
                                               lightSize:0
                                        lightBorderColor:nil];
    [_myPassWordTextField setPlaceholder:@"登录密码"];
    _myPassWordTextField.delegate=self;
    _myPassWordTextField.tag=2002;
    _myPassWordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [_myPassWordTextField setSecureTextEntry:YES];
    _myPassWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _myPassWordTextField.backgroundColor=[UIColor whiteColor];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * passWord = [userDefaults objectForKey:@"password2"];
    if (passWord.length > 2) {
        _myPassWordTextField.text = passWord;
    }
//    _userView.passWordTextField = _passWordTextField;
    [_loginView addSubview:_myPassWordTextField];
    
    
    UIButton * logInButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [logInButton setTitle:@"登录" forState:(UIControlStateNormal)];
    logInButton.frame=CGRectMake(_rightView.frame.size.width/2 - 208.5, _myPassWordTextField.frame.origin.y + 51 + 25, 417, 51);
    [logInButton addTarget:self action:@selector(clickLogInBtn) forControlEvents:UIControlEventTouchUpInside];
    logInButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    logInButton.backgroundColor = color_4;
    [logInButton childrenBtnStyleForBtn:logInButton];
    UIView * btnBackView = [Commonality makeButtonShadowViewWhitbtn:logInButton];
    [_loginView addSubview:btnBackView];
    
    
    UIButton * registerButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [registerButton setTitle:@"注册" forState:(UIControlStateNormal)];
    registerButton.frame=CGRectMake(_rightView.frame.size.width/2 - 130, _myPassWordTextField.frame.origin.y + 51 + 25 + 51 + 35, 100, 30);
    [registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    registerButton.backgroundColor = [UIColor clearColor];
    registerButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [registerButton addTarget:self action:@selector(showMyRegistView) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginView addSubview:registerButton];
    
    UIButton * forGetButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [forGetButton setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
    forGetButton.frame=CGRectMake(_rightView.frame.size.width/2 + 30, registerButton.frame.origin.y, 100, 30);
    [forGetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    forGetButton.backgroundColor = [UIColor clearColor];
    forGetButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [forGetButton addTarget:self action:@selector(showMyForgetPasswordView) forControlEvents:UIControlEventTouchUpInside];
    [_loginView addSubview:forGetButton];
}

-(void)clickLogInBtn
{

    if (_userView.phoneTextField == nil) {
        _userView.phoneTextField = [[JYTextField alloc] init];
    }
    if (_userView.passWordTextField == nil) {
        _userView.passWordTextField = [[JYTextField alloc] init];
    }
    _userView.phoneTextField.text = _myPhoneTextField.text;
    _userView.passWordTextField.text = _myPassWordTextField.text;
    if (_userView) {
        [self.view endEditing: YES];
        [_userView clickLogIn];
    }
}

-(void)showMyForgetPasswordView
{
    if (_forgetPasswordView != nil) {
        [_forgetPasswordView removeFromSuperview];
    }
    _forgetPasswordView = [[ForgetPasswordView alloc] initMyWithRect:_rightView.bounds];
    _forgetPasswordView.isForgetType = YES;
    [_forgetPasswordView show];
    [_rightView addSubview:_forgetPasswordView];
}

-(void)showLoginView
{
    _myPassWordTextField.text = @"";
    UIView * view = [_rightView.subviews lastObject];
    if (view) {
        [view removeFromSuperview];
    }
    [_rightView addSubview:_loginView];

}

-(void)dismissLoginView
{
    [_loginView removeFromSuperview];
    [self showDefaultView];
}
-(void)redrawUserView
{
    [_userView reloder];
    [self showUserInfoView];
}
-(void)showMyRegistView
{
    [_loginView removeFromSuperview];
    if (_registView == nil) {
        _registView = [[RegistView alloc] initMyWithFrame:_rightView.bounds];
    }
    _registView.delegate = self;
    [_registView show];
    [_rightView addSubview:_registView];
}

-(void)removeRegistView
{
    [_registView removeFromSuperview];
//    _userView = nil;
//    _userView = [[UserView alloc] initMy];
//    _userView.frame = CGRectMake(_userView.frame.origin.x, 45 + 20, _userView.frame.size.width, self.view.frame.size.width - 20 - 45);
//    _userView.delegate = self;
//    _userView.userDatadelegate = self;
//    _userView.userInfoDelegate = self;
//    [_userView makeLogInView];
    [self clickLogInBtn];
    [self showDefaultView];
}

-(void)showDefaultView
{
    if (_playHiestoryView == nil) {
        _playHiestoryView = [[PlayHistoryView alloc] initMyWithFrame:_rightView.bounds];
    }
    [_playHiestoryView show];
    [_rightView addSubview:_playHiestoryView];
}

-(void)clickTableViewIndex:(int)index
{
    
    if (lastClickIndex == index) {
        return;
    }
    lastClickIndex = index;
    UIView * view = [_rightView.subviews lastObject];
    if (view) {
        if ([view isKindOfClass:[_rechargeView class]]) {
            [_rechargeView removeFromSuperview];
            _rechargeView = nil;
        }
        if (index !=5 ) {
            [view removeFromSuperview];
        }
    }
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString * _myCharge=[userDefaultes objectForKey:@"charge_Ivmall"];
    if (_myCharge && [_myCharge isEqualToString:@"true"]) {
        
        if (index != 7 + 1) {
            if (![AppDelegate App].isLogin) {
                [_userView mackNoLongInView];
                _userView.backButton.hidden = NO;
                return;
            }
        }
        
        if (index == 0) {
            if (_playHiestoryView == nil) {
                _playHiestoryView = [[PlayHistoryView alloc] initMyWithFrame:_rightView.bounds];
            }
            [_playHiestoryView show];
            [_rightView addSubview:_playHiestoryView];
        }
        
        
        else if (index == 0 + 1) {
            if (_playTimeView == nil) {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PlayTimeView" owner:self options:nil];
                _playTimeView = [nib objectAtIndex:0];
                _playTimeView.frame = _rightView.bounds;
            }
            [_playTimeView show];
            [_rightView addSubview:_playTimeView];
        }
       else if (index == 0 + 1+ 1) {
            
            if (_collectView == nil) {
                _collectView = [[CollectView alloc] initMyWithFrame:_rightView.bounds];
                _collectView.showGatherDelegate = self;
                _collectView.showProgramDelegate = self;
            }
            [_collectView show];
            [_rightView addSubview:_collectView];
          
        }
        else if (index == 1 + 1+ 1)
        {
            if (_buyView == nil) {
                _buyView = [[BuyView alloc] initMyWithFrame:_rightView.bounds];
                _buyView.frame = _rightView.bounds;
                _buyView.tabelView.frame = CGRectMake(0, _buyView.tabelView.frame.origin.y, _rightView.frame.size.width - 40 , _buyView.tabelView.frame.size.height);
            }
            [_buyView show];
            [_rightView addSubview:_buyView];
            
        }
        else if (index == 2 + 1+ 1)
        {
            if (_rechargeRecordView == nil) {
                _rechargeRecordView = [[RechargeRecordView alloc] initMyWithFram:_rightView.bounds];
//                _rechargeRecordView.frame = _rightView.bounds;
//                _rechargeRecordView.tableView.frame = CGRectMake(0, _rechargeRecordView.tableView.frame.origin.y, _rightView.frame.size.width - 40 , _rechargeRecordView.tableView.frame.size.width);
            }
            [_rechargeRecordView show];
            [_rightView addSubview:_rechargeRecordView];

        }
        else if (index == 3 + 1+ 1)
        {
            
        }
        else if (index == 4 + 1+ 1)
        {
            [self showRecharView1];
        }
        else if (index == 5 + 1+ 1)
        {
            if (_forgetPasswordView==nil) {
                _forgetPasswordView=[[ForgetPasswordView alloc]initMyWithRect:_rightView.bounds];
//                _forgetPasswordView.frame = _rightView.bounds;
                
            }
            _forgetPasswordView.isForgetType = NO;
            [_forgetPasswordView show];
            [_rightView addSubview:_forgetPasswordView];
        }
        else if (index == 6 + 1+ 1)
        {
            if (_aboutUsView==nil) {
                _aboutUsView=[[AboutUsView alloc]initMyWithFrame:_rightView.bounds];
//                _aboutUsView.frame = _rightView.bounds;
            }
            [_aboutUsView show];
            [_rightView addSubview:_aboutUsView];
        }
    }
    else
    {
        if (index != 3 + 1) {
            if (![AppDelegate App].isLogin) {
                [_userView mackNoLongInView];
                _userView.backButton.hidden = NO;
                return;
            }
        }
        
        if (index != 3+ 2) {
            if (![AppDelegate App].isLogin) {
                
                [_userView mackNoLongInView];
                _userView.backButton.hidden = NO;
                
                return;
            }
        }
        
        if (index == 0) {
            if (_playHiestoryView == nil) {
                _playHiestoryView = [[PlayHistoryView alloc] initMyWithFrame:_rightView.bounds];
            }
            [_playHiestoryView show];
            [_rightView addSubview:_playHiestoryView];
        }
        
        if (index == 0+ 1) {
            if (_playTimeView == nil) {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PlayTimeView" owner:self options:nil];
                _playTimeView = [nib objectAtIndex:0];
                _playTimeView.frame = _rightView.bounds;
            }
            [_playTimeView show];
            [_rightView addSubview:_playTimeView];
        }
        if (index == 0 + 1+ 1) {
            if (_collectView == nil) {
                _collectView = [[CollectView alloc] initMyWithFrame:_rightView.bounds];
                _collectView.showGatherDelegate = self;
                _collectView.showProgramDelegate = self;
            }
            [_collectView show];
            [_rightView addSubview:_collectView];
        }
        else if (index == 1 + 1+ 1)
        {
            if (_forgetPasswordView==nil) {
                _forgetPasswordView=[[ForgetPasswordView alloc]initMyWithRect:_rightView.bounds];
//                _forgetPasswordView.frame = _rightView.bounds;
                
            }
            _forgetPasswordView.isForgetType = NO;
            [_forgetPasswordView show];
            [_rightView addSubview:_forgetPasswordView];
        }
        else if (index == 2 + 1+ 1)
        {
            if (_aboutUsView==nil) {
                _aboutUsView=[[AboutUsView alloc]initMyWithFrame:_rightView.bounds];
//                _aboutUsView.frame = _rightView.bounds;
            }
            [_aboutUsView show];
            [_rightView addSubview:_aboutUsView];
        }
    }
}

-(void)showRecharView1
{
    if (_rechargeView==nil) {
        _rechargeView=[[RechargeView alloc]initMyWithFrame:_rightView.bounds];
    }
    _rechargeView.isFromMainShowing = NO;
    _rechargeView.isFromMainShowingExt = YES;
    _rechargeView.ViewCtl = self;
    [_rechargeView show];
    _rechargeView.indicator.frame = CGRectMake(0, 41.5, 190, 3);
    [_rightView addSubview:_rechargeView];
}
-(void)showRecharView
{
    
//    if (_rechargeView==nil) {
//        _rechargeView=[[RechargeView alloc]initMyWithFrame:_rightView.bounds];
//    }
//    _rechargeView.isFromMainShowing = NO;
//    _rechargeView.ViewCtl = self;
//    [_rechargeView show];
//    _rechargeView.indicator.frame = CGRectMake(0, 41.5, 190, 3);
//    [_rightView addSubview:_rechargeView];
    
    
    RechargeView * rechargeView = [[RechargeView alloc] initMy];
    [Commonality anmou1View:rechargeView delegate:self];
    rechargeView.ViewCtl = self;
    rechargeView.isFromMainShowing = NO;
    rechargeView.isFromMainShowingExt = NO;
    [rechargeView show];
//    if (_rechargeView==nil) {
//        _rechargeView=[[RechargeView alloc]initMy];
//        _rechargeView.frame =CGRectMake(self.view.frame.size.height/2 - 276, self.view.frame.size.width/2 - 209, 552, 354);
//        _rechargeView.myView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        _rechargeView.center = self.view.center;
//    }
//    _rechargeView.isFromMainShowing = NO;
//    [Commonality anmou1View:_rechargeView delegate:[AppDelegate App].tabBarController];
//    _rechargeView.ViewCtl = self;
//    [_rechargeView show];
//    UIView * view1 = [self.view.subviews lastObject];
//    UIView * view2 = [self.view.subviews objectAtIndex:self.view.subviews.count - 2];
//    if (view1 != _userView) {
//        view1.hidden = YES;
//        view2.hidden = YES;
//    }
//    [self.view addSubview:_rechargeView.myView];
//    _rechargeView.myView.alpha = 0.3;
//    [self.view addSubview:_rechargeView];
}
-(void)showRechargeSuccessView:(NSString*)balance
{
    
    //代码实在太乱  维护个毛！
    if (_rechargeSucessView == nil) {
        _rechargeSucessView = [[RechargeSucessView alloc]initWithFrame:_rightView.bounds isPop:NO isMain:NO];
    }
    _rechargeSucessView.isPop = NO;
    _rechargeSucessView.isMain = NO;
    [Commonality anmou1View:_rechargeSucessView delegate:self];
    [_rechargeSucessView setButtonBlock:^(UIButton *button){
        //
        
    }];
    [_rechargeSucessView setBalanceText:balance];
    [_rechargeSucessView show];
}
-(void)showRechargeSucessViewPop:(NSString*)balance isMain:(BOOL)isMain
{
    if (_rechargeSucessView == nil) {
        _rechargeSucessView = [[RechargeSucessView alloc]initWithFrame:[[UIScreen mainScreen] bounds] isPop:YES isMain:isMain];
    }
    _rechargeSucessView.isPop = YES;
    _rechargeSucessView.isMain = isMain;
    [Commonality anmou1View:_rechargeSucessView delegate:self];
    [_rechargeSucessView setButtonBlock:^(UIButton *button){
        //
        
    }];
    [_rechargeSucessView setBalanceText:balance];
    [_rechargeSucessView show];
}
-(void)buyVipViewWillShowWithTitle:(NSString *)title andPoints:(NSString *)points andVipID:(NSString *)vipID
{
    if (_buyVipView == nil) {
        _buyVipView = [[BuyVipView alloc] initMy];
//        _buyVipView.frame = _rightView.bounds;
        _buyVipView.myView.frame = self.view.frame;
        _buyVipView.backgroundView.frame = CGRectMake(-10, -10, _buyVipView.frame.size.width + 20, _buyVipView.frame.size.height + 30);
        _buyVipView.center = self.view.center;
        _buyVipView.myView.alpha = 0.5;
        _buyVipView.hihel = YES;
    }
    [Commonality anmou1View:_buyVipView delegate:[AppDelegate App].tabBarController];
    _buyVipView.buyVipDelegate = self;
    _buyVipView.isFromMainShowing = NO;
    _buyVipView.vipID = vipID;
    _buyVipView.points = points;
    _buyVipView.vipTitleLab.text = title;
    _buyVipView.accountLab.text = [NSString stringWithFormat:@"爱V猫帐号：%@",[AppDelegate App].personModel.mobile];
    _buyVipView.balanceLab.text = [NSString stringWithFormat:@"帐号余额：%@猫币",[AppDelegate App].personModel.balance];
    _buyVipView.pointsLab.text = [NSString stringWithFormat:@"%@猫币",points];
    
    UIView * view1 = [self.view.subviews lastObject];
    UIView * view2 = [self.view.subviews objectAtIndex:self.view.subviews.count - 2];
    if (view1 != _userView) {
        view1.hidden = YES;
        view2.hidden = YES;
    }
    
    [self.view addSubview:_buyVipView.myView];
    [self.view addSubview:_buyVipView];
    
}

-(void)buyVipViewWillDismiss
{   
    _buyVipView.hihel=YES;
    [_buyVipView removeFromSuperview];
    [_buyVipView.myView removeFromSuperview];
    
    UIView * view1 = [self.view.subviews lastObject];
    UIView * view2 = [self.view.subviews objectAtIndex:self.view.subviews.count - 2];
    view1.hidden = NO;
    view2.hidden = NO;
    
}

-(void)showProgramView
{
    ProgramPackage * pro = [[ProgramPackage alloc] initWithVipArr:nil andProgramDic:nil];
    pro.isVipList = YES;
    pro.viewCtl = self;
    pro.isShowFromMain = NO;
    [pro show];
}

-(void)showProgramViewWithProID:(NSString *)productId
{
    ProgramPackage * pro = [[ProgramPackage alloc] initWithVipArr:nil andProgramDic:nil];
    pro.productId = productId;
    pro.viewCtl = self;
    pro.isVipList = NO;
    pro.isShowFromMain = NO;
    [pro show];

}

-(void)showGatherView:(NSString *)guid
{
    [_collectView.gat showFormFav:guid];
    [self.view addSubview:_collectView.gat];
}

-(void)showUserInfoView
{
    if (_userInfoView != nil) {
        [_userInfoView removeFromSuperview];
    }
    _userInfoView = [[UserInfoView alloc] initMyWithFrame:_rightView.bounds];
    [_userInfoView show];
    [_rightView addSubview:_userInfoView];
    
   
}

-(void)takePhoto
{
    if (![AppDelegate App].isLogin) {
        [self showLoginView];
        return;
    }
    if (![Commonality isEnableWIFI]) {
        [Commonality showErrorMsg:self.view type:0 msg:LINGKERROR];
    }
    
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
                
                [AppDelegate App].tabBarController.isTakingPhoto = YES;
                
                UIImagePickerController *imgPickerVC = [[UIImagePickerController alloc] init];
                [imgPickerVC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                [imgPickerVC.navigationBar setBarStyle:UIBarStyleBlack];
                [imgPickerVC setDelegate:self];
                [imgPickerVC setAllowsEditing:YES];
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
    [AppDelegate App].tabBarController.isTakingPhoto = NO;
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
    
//    [NSThread detachNewThreadSelector:@selector(postImageData:) toTarget:self withObject:pickImg];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self postImageData:pickImg];
    }];
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
        _userView.heatImgView.image = image;
    }
    else if ([urlResponese statusCode] ==0)
    {
        
//        [AppDelegate App].tabBarController.isTakingPhoto = YES;
        [Commonality showErrorMsg:self.view type:0 msg:LINGKERROR];
//        [AppDelegate App].tabBarController.isTakingPhoto = NO;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSelector:@selector(dismisViewCtl) withObject:nil afterDelay:0.5];
}

-(void)dismisViewCtl
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        return YES;
    }
    else
    {
        if ([AppDelegate App].tabBarController.isTakingPhoto == YES ) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return YES;
    
}

//为了支持iOS6
-(BOOL)shouldAutorotate
{
    if (IOS7) {
        return NO;
    }
    return YES;
}

//为了支持iOS6
-(NSUInteger)supportedInterfaceOrientations
{
    if (IOS7) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskAll;
}

#pragma mark textfield methods
-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
   
    if (textField.tag == 2001) {
        if ( textField.text.length > 0 && textField.text.length != 11) {
            [Commonality showErrorMsg:self.view type:0 msg:@"请输入正确的手机格式！"];
            return  YES;
        }
    }
    else if (textField.tag == 2002)
    {
        if (textField.text.length > 0 && textField.text.length < 6) {
            [Commonality showErrorMsg:self.view type:0 msg:@"密码至少要6位哦"];
            return YES;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==2001){
        if (range.location>10)
        {
            [Commonality showErrorMsg:self.view type:0 msg:@"请输入正确的手机格式！"];
            
            return  NO;
        }
        else
        {
            return YES;
        }
    }else if(textField.tag==2002){
        if(range.location>19){
            [Commonality showErrorMsg:self.view type:0 msg:@"登录密码输入不能超过20位"];
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}


@end
