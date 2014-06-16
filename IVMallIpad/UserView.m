////
////  UserView.m
////  IVMall (Ipad)
////
////  Created by sean on 14-2-24.
////  Copyright (c) 2014年 HYQ. All rights reserved.
////
//

#import "UserView.h"
#import "Macro.h"
#import "UIButton+Bootstrap.h"
#import "Commonality.h"
#import "Macro.h"
#import "HttpRequest.h"
#import "AppDelegate.h"
#import "BuyView.h"
#import "MKInfoPanel.h"
#import "UserInfoCell.h"
#import "IVMallPlayer.h"
#import "UIImageView+WebCache.h"
#import "ProgramPackage.h"
#import "MainViewController.h"
#import "ChildrenViewController.h"


#define USERVIEW_WIDTH    (312)
@implementation UserView

-(id)initMy{
    if (self=[super init]) {
        
        rect=[[UIScreen mainScreen] bounds];
        UIViewController * main = [AppDelegate App].tabBarController;
        _myView = [[UIView alloc] init];
        _myView.frame = CGRectMake(main.view.frame.origin.x, main.view.frame.origin.y + 64, USERVIEW_WIDTH, main.view.frame.size.height);
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
        
//        self.frame = CGRectMake(rect.size.width - 140 + 400, [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
        self.frame = CGRectMake(0 , [AppDelegate App].countIOS7 + 0,USERVIEW_WIDTH , rect.size.height-44-[AppDelegate App].countIOS7);

        
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissALLView)];
        tap.numberOfTapsRequired=1;
        [_myView addGestureRecognizer:tap];
        
        self.backgroundColor=color_21;
        
        _loginHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, USERVIEW_WIDTH, 50)];
        _loginHeadView.backgroundColor=[Commonality colorFromHexRGB:@"323232"];
        
//        UILabel*titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 200, 40)];
//        titleLabe.textColor=[UIColor whiteColor];
//        titleLabe.text=@"登录";
//        titleLabe.font=[UIFont boldSystemFontOfSize:HEADVIEW_TITLESIZE];
//        titleLabe.alpha = HEADVIEW_TITLE_ALPHA;
//        titleLabe.textAlignment=NSTextAlignmentCenter;
//        titleLabe.backgroundColor=[UIColor clearColor];
//        [_loginHeadView addSubview:titleLabe];
        
        
        _backButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
        _backButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [_backButton addTarget:self  action:@selector(makeLogInView) forControlEvents:UIControlEventTouchUpInside];
        _backButton.backgroundColor=[UIColor clearColor];
        _backButton.frame=CGRectMake(30, 10, 30, 30);
        [_loginHeadView addSubview:_backButton];
        _backButton.hidden = YES;
        
        [self addSubview:_loginHeadView];
        _loginHeadView.hidden = YES;
        
        _heatView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, USERVIEW_WIDTH, 111)];
        _heatView.backgroundColor=[Commonality colorFromHexRGB:@"46b9de"];
        
        CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
        CGRect newShadowFrame = CGRectMake(0, 0, USERVIEW_WIDTH, 111);
        newShadow.frame = newShadowFrame;
        
        newShadow.colors = [NSArray arrayWithObjects:(id)[[[Commonality colorFromHexRGB:@"46b9de"] colorWithAlphaComponent:0] CGColor],(id)[[[Commonality colorFromHexRGB:@"46b9de"] colorWithAlphaComponent:0.2] CGColor],(id)[[[Commonality colorFromHexRGB:@"1e9bc2"] colorWithAlphaComponent:0.4] CGColor],(id)[[[Commonality colorFromHexRGB:@"1e9bc2"] colorWithAlphaComponent:0.8] CGColor],nil];
        //
        [_heatView.layer addSublayer:newShadow];
        
        UIImageView * heatImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, _heatView.frame.size.height - 10, _heatView.frame.size.width, 15)];
        heatImg.image = [UIImage imageNamed:@"Individual_Cloud.png"];
        heatImg.backgroundColor = [UIColor clearColor];
        [_heatView addSubview:heatImg];
        
        
        _heatImgView=[[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 54, 54)];
        _heatImgView.backgroundColor=[UIColor clearColor];
        _heatImgView.layer.cornerRadius=28;
        _heatImgView.layer.borderWidth=0;
        _heatImgView.clipsToBounds=YES;
        _heatImgView.layer.borderColor=[UIColor grayColor].CGColor;
        _heatImgView.contentMode = UIViewContentModeScaleToFill;
        
        _headBgImgView=[[UIImageView alloc]initWithFrame:CGRectMake(28, 27, 105, 87.5)];
        _headBgImgView.backgroundColor=[UIColor clearColor];
        _headBgImgView.clipsToBounds=YES;
        _headBgImgView.image = [UIImage imageNamed:@"头像.png"];
        _headBgImgView.contentMode = UIViewContentModeScaleToFill;
        
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto)];
        tap1.numberOfTapsRequired = 1;
        _headBgImgView.userInteractionEnabled = YES;
        [_headBgImgView addGestureRecognizer:tap1];
        [_headBgImgView addSubview:_heatImgView];
        [_heatView addSubview:_headBgImgView];
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 30)];
        _nameLabel.backgroundColor=[UIColor clearColor];
        _nameLabel.font=[UIFont boldSystemFontOfSize:17];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.alpha = 0.8;
        if (![[AppDelegate App].personModel.nickname isEqualToString:@""]) {
            _nameLabel.text=[AppDelegate App].personModel.nickname;
        }else{
            _nameLabel.text=[AppDelegate App].personModel.mobile;
        }
        
        
        [_heatView addSubview:_nameLabel];
        
        
        
        _vipLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 20, 80 ,30)];
        _vipLabel.backgroundColor=[UIColor clearColor];
        _vipLabel.font=[UIFont boldSystemFontOfSize:13];
        _vipLabel.text=@"会员";
        _vipLabel.textColor = [UIColor whiteColor];
        _vipLabel.alpha = 0.5;
        [_heatView addSubview:_vipLabel];
        
        _vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _vipBtn.frame = CGRectMake(100, 50, 120, 22);
        [_vipBtn setTitle:@"登录" forState:UIControlStateNormal];
        _vipBtn.titleLabel.font = [UIFont italicSystemFontOfSize:11];
        _vipBtn.backgroundColor = [Commonality colorFromHexRGB:@"f1c07b"];
        [_vipBtn setTitleColor:[Commonality colorFromHexRGB:@"452900"] forState:UIControlStateNormal];
//        _vipBtn.layer.cornerRadius = 11.0;
        [_vipBtn vipStyle];
//        _vipBtn.layer.borderWidth = 1;
//        _vipBtn.layer.borderColor = [UIColor clearColor].CGColor;
//        _vipBtn.layer.shadowOffset = CGSizeMake(0, 0);
//        _vipBtn.layer.shadowRadius = 5;
//        _vipBtn.layer.shadowOpacity = 0.5;
//        _vipBtn.layer.shadowColor = [UIColor grayColor].CGColor;
        _vipBtn.layer.shadowPath = [UIBezierPath bezierPathWithRect:_vipBtn.bounds].CGPath;
        [_vipBtn addTarget:self action:@selector(showVipList) forControlEvents:UIControlEventTouchUpInside];
        
        _dueTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 130, 22)];
        _dueTimeLab.textColor = [UIColor whiteColor];
        _dueTimeLab.backgroundColor = [UIColor clearColor];
        _dueTimeLab.alpha = 0.5;
        _dueTimeLab.font = [UIFont boldSystemFontOfSize:12];
        [_heatView addSubview:_dueTimeLab];
        _dueTimeLab.hidden = YES;
        
        [_heatView addSubview:_vipBtn];
        if (![AppDelegate App].isLogin) {
            _vipBtn.hidden = YES;
        }
    
        _infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _infoBtn.frame = CGRectMake(262, 14, 30, 30);
        _infoBtn.frame = CGRectMake(282, 14, 30, 30);
        [_infoBtn setImage:[UIImage imageNamed:@"编辑.png"] forState:UIControlStateNormal];
        [_heatView addSubview:_infoBtn];
        [_infoBtn addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
        _infoBtn.hidden = YES;

        [self addSubview:_heatView];
        
        [self configControl];
    }
    
    [Commonality setImgViewStyle:self];
    [self makeLogInView];
    selectedBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 51)];
    selectedBackView.backgroundColor = color_18;
    return self;
}

-(void)selectPhoto
{
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(takePhoto)]) {
        [_delegate takePhoto];
    }
    
//    if (![AppDelegate App].isLogin) {
//        return;
//    }
//    
//    [[AppDelegate App].tabBarController takePhoto];
}


-(void)configControl
{
    if (_tableArray) {
        _tableArray = nil;
    }
    if (_imgArr) {
        _imgArr = nil;
    }
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    _myCharge=[userDefaultes objectForKey:@"charge_Ivmall"];
    if (_myCharge && [_myCharge isEqualToString:@"true"]) {
        _tableArray=[[NSArray alloc]initWithObjects:@"观看记录",@"观看时长",@"收藏记录",@"购买记录",@"充值记录",@"帐户余额",@"我要充值",@"修改密码",@"关于我们", nil];
        _imgArr = [[NSMutableArray alloc] initWithObjects:@"clock2.png",@"clock3.png",@"1 (1).png",@"1 (2).png",@"1 (3).png",@"1 (4).png",@"1 (5).png",@"1 (6).png",@"1 (7).png", nil];
    }
    else
    {
        _tableArray=[[NSArray alloc]initWithObjects:@"观看记录",@"观看时长",@"收藏记录",@"修改密码",@"关于我们", nil];
        _imgArr = [[NSMutableArray alloc] initWithObjects:@"clock2.png",@"clock3.png",@"1 (1).png",@"1 (6).png",@"1 (7).png", nil];
    }
}

-(void)dismissALLView
{
    [Commonality dismissAllView];
}

-(void)showVipList
{
        
    if (![AppDelegate App].isLogin) {
        [self mackNoLongInView];
        return;
    }
    

    
//        ProgramPackage * pro = [[ProgramPackage alloc] initWithVipArr:nil andProgramDic:nil];
//        pro.isVipList = YES;
//        [pro show];
    if (_userDatadelegate && [_userDatadelegate respondsToSelector:@selector(showProgramView)]) {
        
        [[AppDelegate App].personView.forgetPasswordView endEditing:YES];//修改BUG 1583
        [[AppDelegate App].personView.rechargeView endEditing:YES];//修改BUG 1583
        
        
        [_userDatadelegate showProgramView];
    }
    

}


-(void)showInfo{
    
    
    if (![AppDelegate App].isLogin) {
        return;
    }
    if (_userInfoDelegate && [_userInfoDelegate respondsToSelector:@selector(showUserInfoView)]) {
        [_userInfoDelegate showUserInfoView];
    }
    
//    if ([AppDelegate App].userInfomationView==nil) {
//        [AppDelegate App].userInfomationView=[[UserInfoView alloc]initMy];
//    }
//
//    [Commonality anmou1View:[AppDelegate App].userInfomationView delegate:[AppDelegate App].tabBarController];
//    [[AppDelegate App].userInfomationView show];
}

-(void)makeLogInView{
    if ([AppDelegate App].isLogin) {
        _dueTimeLab.hidden = YES;
        _backButton.hidden = YES;
        _infoBtn.hidden = NO;
        _vipBtn.hidden = NO;
        _heatView.hidden = NO;
        _vipLabel.hidden = YES;
        _logOutButton.hidden = NO;
        _vipLabel.frame = CGRectMake(220, 20, 80 ,30);
        if (![[AppDelegate App].personModel.nickname isEqualToString:@""]) {
            _nameLabel.text=[AppDelegate App].personModel.nickname;
        }else{
            _nameLabel.text=[AppDelegate App].personModel.mobile;
        }
        if (_phoneTextField) {
            _phoneTextField.hidden = YES;
            _passWordTextField.hidden = YES;
            _logInButton.hidden = YES;
            _registerButton.hidden = YES;
            _forGetButton.hidden = YES;
        }
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        _myCharge=[userDefaultes objectForKey:@"charge_Ivmall"];
        if (!(_myCharge && [_myCharge isEqualToString:@"true"])) {
            _vipBtn.hidden = YES;
            _vipLabel.hidden = YES;
        }
        else
        {
            _vipBtn.hidden = NO;
            _vipLabel.hidden = NO;
        }
        
        _loginHeadView.hidden = YES;
        if (_myTableView==nil) {
            _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 120, USERVIEW_WIDTH, 500)];
            _myTableView.delegate=self;
            _myTableView.dataSource=self;
            _myTableView.backgroundColor=color_21;
            _myTableView.separatorStyle=NO;
            _myTableView.bounces=NO;
            _myTableView.clearsContextBeforeDrawing = NO;
            [_myTableView registerNib:[UINib nibWithNibName:@"UserInfoView" bundle:nil] forCellReuseIdentifier:@"MainCell"];
            [self addSubview:_myTableView];
            
//            首先我有一个UITableViewController，其中每个UITableViewCell点击后都会push另一个ViewController，每次点击Cell的时候，Cell都会被选中，当从push的ViewController返回的时候选中的Cell便会自动取消选中。后来由于某些原因我把这个UITableViewController改成了UIViewController，之后就产生了一个问题：每次返回到TableView的时候，之前选中的Cell不能自动取消选中，经过查找得知：
//            UITableViewController有一个clearsSelectionOnViewWillAppear的property，
//            而当把UITableViewController修改成UIViewController后，这个属性自然就不存在了，因此我们必须手动添加取消选中的功能，方法很简单，在viewWillAppear方法中加入：
//            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
            
        }else{
            _myTableView.hidden=NO;

        }
        
        if (_logOutButton == nil) {
            _logOutButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
//            self.frame.size.height/2 - 128.5 630
            _logOutButton.frame=CGRectMake(30, _myTableView.frame.size.height + _myTableView.frame.origin.y + 5, 257, 51);
            [_logOutButton setTitle:@"退出帐号" forState:(UIControlStateNormal)];
            _logOutButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//            [_logOutButton greyStyle];
            _logOutButton.backgroundColor = color_20;
            
            _logOutButton.alpha = 1;
            [_logOutButton addTarget:self action:@selector(clickLogOut) forControlEvents:UIControlEventTouchUpInside];
            [_logOutButton childrenBtnStyleForBtn:_logOutButton];
            UIView * btnBackView = [Commonality makeButtonShadowViewWhitbtn:_logOutButton];
            [self addSubview:btnBackView];
        }
        _logOutButton.hidden=NO;
        
        [HttpRequest UserInfoRequest:[AppDelegate App].personModel.tokenid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    else
    {
        _dueTimeLab.hidden = YES;
        _backButton.hidden = YES;
        _infoBtn.hidden = YES;
        _vipBtn.hidden = NO;
        _heatView.hidden = NO;
        _vipLabel.hidden = YES;
        _nameLabel.text = @"账户";
        _vipLabel.text = @"未登录";
        _headBgImgView.image = [UIImage imageNamed:@"头像.png"];
        _heatImgView.image = nil;
        if (_logOutButton) {
            _logOutButton.hidden = YES;
        }
        if (_phoneTextField) {
            _phoneTextField.hidden = YES;
            _passWordTextField.hidden = YES;
            _logInButton.hidden = YES;
            _registerButton.hidden = YES;
            _forGetButton.hidden = YES;
        }
        _vipBtn.frame = CGRectMake(100, 50, 70, 22);
        _vipLabel.frame = CGRectMake(150, 20, 80 ,30);
        [_vipBtn setTitle:@"登录" forState:UIControlStateNormal];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        _myCharge=[userDefaultes objectForKey:@"charge_Ivmall"];
        if (!(_myCharge && [_myCharge isEqualToString:@"true"])) {
            _vipBtn.hidden = NO;
            _vipLabel.hidden = YES;
        }
        else
        {
            _vipBtn.hidden = NO;
            _vipLabel.hidden = NO ;
        }
        
        _loginHeadView.hidden = YES;
        if (_myTableView==nil) {
            _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 120, USERVIEW_WIDTH, 500)];
            _myTableView.delegate=self;
            _myTableView.dataSource=self;
            _myTableView.backgroundColor=color_21;
            _myTableView.separatorStyle=NO;
            _myTableView.bounces=NO;
            [_myTableView registerNib:[UINib nibWithNibName:@"UserInfoView" bundle:nil] forCellReuseIdentifier:@"MainCell"];
            [self addSubview:_myTableView];
           
        }else{
            _myTableView.hidden=NO;
//            _logOutButton.hidden=NO;
        }
    }

}

-(void)mackNoLongInView{
    
    if (_userDatadelegate && [_userDatadelegate respondsToSelector:@selector(showLoginView)]) {
        _nameLabel.text=@"账户";
        _vipLabel.text=@"未登录";
        
        if (_phoneTextField==nil) {
            _phoneTextField=[[JYTextField alloc]initWithFrame:CGRectMake(30, 81, 340, 40)
                                                  cornerRadio:6
                                                  borderColor:[Commonality colorFromHexRGB:@"c3c3c3"]
                                                  borderWidth:0.5
                                                   lightColor:nil
                                                    lightSize:0
                                             lightBorderColor:nil];
            
            _passWordTextField=[[JYTextField alloc]initWithFrame:CGRectMake(30, 145, 340, 40)
                                                     cornerRadio:6
                                                     borderColor:[Commonality colorFromHexRGB:@"c3c3c3"]
                                                     borderWidth:0.5
                                                      lightColor:nil
                                                       lightSize:0
                                                lightBorderColor:nil];
        }
        
        [_userDatadelegate showLoginView];
        
        
        
        return;
    }
    
    _infoBtn.hidden = YES;
    _vipBtn.hidden = YES;
    _heatView.hidden = YES;
    _vipLabel.hidden = YES;
    _loginHeadView.hidden = NO;
    if (_myTableView) {
        _myTableView.hidden = YES;
    }
    if (_phoneTextField==nil) {
        _nameLabel.text=@"账户";
        _vipLabel.text=@"未登录";
        _phoneTextField=[[JYTextField alloc]initWithFrame:CGRectMake(30, 81, 340, 40)
                                               cornerRadio:6
                                              borderColor:[Commonality colorFromHexRGB:@"c3c3c3"]
                                              borderWidth:0.5
                                               lightColor:nil
                                                lightSize:0
                                         lightBorderColor:nil];
        [_phoneTextField setPlaceholder:@"手机号码"];
        if ([AppDelegate App].personModel.mobile.length>2) {
            _phoneTextField.text=[AppDelegate App].personModel.mobile;
        }
        _phoneTextField.delegate=self;
        _phoneTextField.tag=2001;
        _phoneTextField.backgroundColor=[UIColor whiteColor];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_phoneTextField];
        
        _passWordTextField=[[JYTextField alloc]initWithFrame:CGRectMake(30, 145, 340, 40)
                                                 cornerRadio:6
                                                 borderColor:[Commonality colorFromHexRGB:@"c3c3c3"]
                                                 borderWidth:0.5
                                                  lightColor:nil
                                                   lightSize:0
                                            lightBorderColor:nil];
        [_passWordTextField setPlaceholder:@"登录密码"];
        _passWordTextField.delegate=self;
        _passWordTextField.tag=2002;
        _passWordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        [_passWordTextField setSecureTextEntry:YES];
        _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passWordTextField.backgroundColor=[UIColor whiteColor];
        [self addSubview:_passWordTextField];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * passWord = [userDefaults objectForKey:@"password2"];
        if (passWord.length > 2) {
            _passWordTextField.text = passWord;
        }
        if (_logInButton == nil) {
            _logInButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
            [_logInButton setTitle:@"登录" forState:(UIControlStateNormal)];
            _logInButton.frame=CGRectMake(30, 210, 340, 38);
            [_logInButton addTarget:self action:@selector(clickLogIn) forControlEvents:UIControlEventTouchUpInside];
            [_logInButton redStyle];
            _logInButton.alpha = 0.8;
            _logInButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
            [self addSubview:_logInButton];
        }
        
        _registerButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [_registerButton setTitle:@"注册" forState:(UIControlStateNormal)];
        _registerButton.frame=CGRectMake(50, 650, 100, 30);
         [_registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _registerButton.backgroundColor = [UIColor clearColor];
        _registerButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [_registerButton addTarget:self action:@selector(showRegistView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_registerButton];
        
        _forGetButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [_forGetButton setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
        _forGetButton.frame=CGRectMake(250, 650, 100, 30);
        [_forGetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _forGetButton.backgroundColor = [UIColor clearColor];
        _forGetButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [_forGetButton addTarget:self action:@selector(showForgetPasswordView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_forGetButton];
    }else{
        _nameLabel.text=@"账户";
        _vipLabel.text=@"未登录";
        _phoneTextField.text=nil;
        if ([AppDelegate App].personModel.mobile.length>2) {
            _phoneTextField.text=[AppDelegate App].personModel.mobile;
        }
        _passWordTextField.text=nil;
        _phoneTextField.hidden=NO;
        _passWordTextField.hidden=NO;
        _logInButton.hidden=NO;
        _registerButton.hidden=NO;
        _forGetButton.hidden=NO;
    }
    
}

-(void)showRegistView
{
//    if ([AppDelegate App].registView==nil) {
//        [AppDelegate App].registView=[[RegistView alloc]initMy];
//    }
//    [[AppDelegate App].registView show];
}

-(void)showForgetPasswordView
{
//    [AppDelegate App].personModel.mobile=self.phoneTextField.text;
//    if ([AppDelegate App].forgetPasswordView == nil) {
//        [AppDelegate App].forgetPasswordView = [[ForgetPasswordView alloc] initMy];
//    }
//    [AppDelegate App].forgetPasswordView.isForgetType = YES;
//    [[AppDelegate App].forgetPasswordView show];
}

-(void)clickLogOut{
    [HttpRequest logOutRequest:[AppDelegate App].personModel.tokenid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    [HttpRequest CannelEquipmentRequest:[AppDelegate App].personModel.tokenid deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:[[AppDelegate App].deviceInfoDic objectForKey:@"drmType"] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
    AppDelegate.App.isLogin=NO;
    AppDelegate.App.personModel.tokenid=@"";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"" forKey:@"password"];
    [userDefaults setObject:@"" forKey:@"password2"];
    [userDefaults synchronize];
    AppDelegate.App.personModel.password=@"";
    _myTableView.hidden=NO;
    _logOutButton.hidden=YES;
    [_myTableView reloadData];
    [self makeLogInView];
    
    switch ([AppDelegate App].tabBarController.viewCtlNum) {
        case 0:
        {
            MainViewController * mainViewCtl = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
            [mainViewCtl markHomeRequest];
        }
            break;
            
        default:
        {
            ChildrenViewController * childrenViewCtl = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:[AppDelegate App].tabBarController.viewCtlNum];
            [childrenViewCtl viewWillAppear:YES];
        }
            break;
    }
}

-(void)clickLogIn{
    
    
    
    [self endEditing:YES];
    if ([Commonality isEnableWIFI]==0) {
        [Commonality showErrorMsg:self type:0 msg:FAIILURE];
        return;
    }
    
    if ([Commonality isEmpty:self.phoneTextField.text]) {
        [Commonality showErrorMsg:self type:0 msg:@"手机号码不能为空哦!"];
        return;
    }
    if ([Commonality isEmpty:self.passWordTextField.text]) {
        [Commonality showErrorMsg:self type:0 msg:@"密码不能为空哦!"];
        return;
    }
    
    if ([Commonality determineCellPhoneNumber:self.phoneTextField.text]==NO) {
        [Commonality showErrorMsg:self type:0 msg:@"请输入正确的手机格式!"];
        return;
    }
    
    if (self.passWordTextField.text.length<6) {
        [Commonality showErrorMsg:self type:0 msg:@"密码至少要6位哦!"];
        return;
    }
//    NSString* passWordText = [NSString stringWithFormat:@"%@$^i@#*Vm!all%@",self.passWordTextField.text,self.phoneTextField.text];
    NSString* passWordText = [NSString stringWithFormat:@"%@$^i@#*Vm!all%@",[Commonality MD5:self.passWordTextField.text],self.phoneTextField.text];
    
    self.md5PassWord= [[Commonality MD5:passWordText]lowercaseString]; //[Commonality MD5:[Commonality MD5:passWordText]];
    
    [HttpRequest LoginRequest:self.phoneTextField.text password:self.md5PassWord delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
}

-(void) GetErr:(ASIHTTPRequest *)request{
    [Commonality showErrorMsg:self type:0 msg:@"网络连接异常，请重试"];
}

-(void) GetResult:(ASIHTTPRequest *)request{
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"error is %@",error);
    if (dictionary==nil) {
        [Commonality showErrorMsg:self type:0 msg:@"网络连接异常，请重试"];
    }else{
        if (request.tag==0) {
             UserLoginModel*usr=[[UserLoginModel alloc]initWithDictionary:dictionary];
            if (usr.result==0) {
                
                if (_userDatadelegate && [_userDatadelegate respondsToSelector:@selector(dismissLoginView)]) {
                    [_userDatadelegate dismissLoginView];
                }
                
                MainViewController * mainViewCtl = [[AppDelegate App].tabBarController.viewControllers objectAtIndex:0];
                [mainViewCtl markHomeRequest];
                
                [self endEditing:NO];
                [AppDelegate App].isLogin=YES;
                [AppDelegate App].personModel.mobile=self.phoneTextField.text;
                [AppDelegate App].personModel.password=self.md5PassWord;
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.phoneTextField.text forKey:@"mobile"];
                [userDefaults setObject:self.md5PassWord forKey:@"password"];
                [userDefaults setObject:self.passWordTextField.text forKey:@"password2"];
                [userDefaults synchronize];
                
                
//                NSString* string = [AppDelegate App].personModel.vipExpiryTime;
//                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
//                [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
//                NSDate* inputDate = [inputFormatter dateFromString:string];
//                
//                NSTimeInterval interval = [inputDate timeIntervalSinceNow];
//                
//                
//                if ([Commonality isEmpty:[AppDelegate App].personModel.vipExpiryTime] || interval < 0) {//非会员状态
//                    _vipBtn.frame = CGRectMake(100, 60, 80, 22);
//                    [_vipBtn setTitle:@"开通会员" forState:UIControlStateNormal];
//                    _vipLabel.userInteractionEnabled = YES;
//                    _vipLabel.text = @"注册用户";
//                    _dueTimeLab.hidden = YES;
//                }
//                else
//                {
//                    _dueTimeLab.frame = CGRectMake(100, 60, 130, 22);
//                    _dueTimeLab.text = [NSString stringWithFormat:@"%@ 会员到期",[self setTime:usr.vipExpiryTime]];
//                    _dueTimeLab.hidden = NO;
//                    
//                    _vipBtn.frame = CGRectMake(230, 60, 60, 22);
//                    [_vipBtn setTitle:@"续费" forState:UIControlStateNormal];
//                    
//                    _vipLabel.userInteractionEnabled = YES;
//                    _vipLabel.text = @"会员";
//                }
                
//                _vipLabel.text=nil;
                _phoneTextField.hidden=YES;
                _passWordTextField.hidden=YES;
                _logInButton.hidden=YES;
                _registerButton.hidden=YES;
                _forGetButton.hidden=YES;
                _vipBtn.hidden = NO;
    
                [HttpRequest BingdingToken:[AppDelegate App].personModel.tokenid delegate:self deviceDRMID:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:[[AppDelegate App].deviceInfoDic  objectForKey:@"drmType"] seral:[[AppDelegate App].deviceInfoDic  objectForKey:@"seiralNo"] macAddr:[[AppDelegate App].deviceInfoDic  objectForKey:@"macAddr"] appVersion:[[AppDelegate App].deviceInfoDic  objectForKey:@"appVersion"] osVersion:[[AppDelegate App].deviceInfoDic  objectForKey:@"osVersion"] deviceInfo:nil inishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
 
                if (isFromHistory) {
//                    [self dismiss];
//                    if ([AppDelegate App].playHistVIew==nil) {
//                        [AppDelegate App].playHistVIew=[[PlayHistoryView alloc]initMy];
//                    }
//                    [[AppDelegate App].playHistVIew show];
                }
                else
                {
                    [self makeLogInView];
                }
                
                NSString* string = [AppDelegate App].personModel.vipExpiryTime;
                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
                [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
                NSDate* inputDate = [inputFormatter dateFromString:string];
                
                NSTimeInterval interval = [inputDate timeIntervalSinceNow];
                
                if ([Commonality isEmpty:[AppDelegate App].personModel.vipExpiryTime] || interval < 0) {//非会员状态
                    _vipBtn.frame = CGRectMake(100, 60, 80, 22);
                    [_vipBtn setTitle:@"开通会员" forState:UIControlStateNormal];
                    _vipLabel.userInteractionEnabled = YES;
                    _vipLabel.text = @"注册用户";
                    _dueTimeLab.hidden = YES;
                }
                else
                {
                    _dueTimeLab.frame = CGRectMake(100, 60, 130, 22);
                    _dueTimeLab.text = [NSString stringWithFormat:@"%@ 会员到期",[self setTime:usr.vipExpiryTime]];
//                    _dueTimeLab.hidden = NO;
                    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                    _myCharge=[userDefaultes objectForKey:@"charge_Ivmall"];
                    if (_myCharge && [_myCharge isEqualToString:@"true"]) {
                        _dueTimeLab.hidden = NO;
                        _vipBtn.frame = CGRectMake(230, 60, 60, 22);
                        [_vipBtn setTitle:@"续费" forState:UIControlStateNormal];
                    }
                    else
                    {
                        _dueTimeLab.hidden = YES;
                        _vipBtn.hidden = YES;
                    }
                    
//                    _vipBtn.frame = CGRectMake(230, 60, 60, 22);
//                    [_vipBtn setTitle:@"续费" forState:UIControlStateNormal];
                    
                    _vipLabel.userInteractionEnabled = YES;
                    _vipLabel.text = @"会员";
                }
                
            }else{
                [Commonality showErrorMsg:self type:usr.result msg:nil];
                
            }
        }else if (request.tag==LOGOUTURLNEW_TYPE){
            if ([[dictionary objectForKey:@"errorCode"]isEqualToString:@"0"]) {
                AppDelegate.App.isLogin=NO;
                   [HttpRequest CannelEquipmentRequest:[AppDelegate App].personModel.tokenid deviceDRMId:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:[[AppDelegate App].deviceInfoDic objectForKey:@"drmType"] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                AppDelegate.App.personModel.tokenid=@"";
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:@"password"];
                [userDefaults removeObjectForKey:@"password2"];
                [userDefaults synchronize];
                AppDelegate.App.personModel.password=@"";
                _myTableView.hidden=NO;
//                _logOutButton.hidden=YES;
                [_myTableView reloadData];
                [self mackNoLongInView];
            }else{
                [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"]intValue] msg:nil];
            }
            
         
        }else if (request.tag==BALANCEURL_TYPE){
            if ([[dictionary objectForKey:@"errorCode"]intValue]==0) {
                NSDictionary* data=[dictionary objectForKey:@"data"];
                [AppDelegate App].personModel.balance=[data objectForKey:@"balance"];
                [self.myTableView reloadData];
            }else{
                [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"]intValue] msg:nil];
            }
        }
        else if (request.tag == USERINFOURL_TYPE){
            
            AppDelegate.App.personModel.address = [[dictionary objectForKey:@"data"] objectForKey:@"address"];
            AppDelegate.App.personModel.balance = [[dictionary objectForKey:@"data"] objectForKey:@"balance"];
            AppDelegate.App.personModel.birthYear = [[dictionary objectForKey:@"data"] objectForKey:@"birthday"];
            AppDelegate.App.personModel.email = [[dictionary objectForKey:@"data"] objectForKey:@"email"];
            AppDelegate.App.personModel.sex = [[dictionary objectForKey:@"data"] objectForKey:@"gender"];
            AppDelegate.App.personModel.lang =[[dictionary objectForKey:@"data"] objectForKey:@"lang"];
            AppDelegate.App.personModel.nickname = [[dictionary objectForKey:@"data"] objectForKey:@"nickname"];
            
            AppDelegate.App.personModel.vipExpiryTime = [[dictionary objectForKey:@"data"] objectForKey:@"vipExpiryTime"];
            
            NSString* string = [AppDelegate App].personModel.vipExpiryTime;
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
            [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
            NSDate* inputDate = [inputFormatter dateFromString:string];
            
            NSTimeInterval interval = [inputDate timeIntervalSinceNow];
            
            
            if (![[AppDelegate App].personModel.nickname isEqualToString:@""]) {
                _nameLabel.text=[AppDelegate App].personModel.nickname;
            }else{
                _nameLabel.text=[AppDelegate App].personModel.mobile;
            }
            
            if ([Commonality isEmpty:[AppDelegate App].personModel.vipExpiryTime]|| interval < 0) {//非会员状态
                
                _vipBtn.frame = CGRectMake(100, 60, 80, 22);
                [_vipBtn setTitle:@"开通会员" forState:UIControlStateNormal];
                _vipLabel.userInteractionEnabled = YES;
                _vipLabel.text = @"注册用户";
                _dueTimeLab.hidden = YES;
            }
            else
            {
//                _vipBtn.frame = CGRectMake(100, 60, 200, 22);
//                [_vipBtn setTitle:[NSString stringWithFormat:@"%@ 会员到期",[self setTime:AppDelegate.App.personModel.vipExpiryTime]] forState:UIControlStateNormal];
                _dueTimeLab.frame = CGRectMake(100, 60, 130, 22);
                _dueTimeLab.text = [NSString stringWithFormat:@"%@ 会员到期",[self setTime:AppDelegate.App.personModel.vipExpiryTime]];
                
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                _myCharge=[userDefaultes objectForKey:@"charge_Ivmall"];
                if (_myCharge && [_myCharge isEqualToString:@"true"]) {
                    _dueTimeLab.hidden = NO;
                    _vipBtn.frame = CGRectMake(230, 60, 60, 22);
                    [_vipBtn setTitle:@"续费" forState:UIControlStateNormal];
                }
                else
                {
                    _dueTimeLab.hidden = YES;
                    _vipBtn.hidden = YES;
                }
                
                
//                _vipBtn.frame = CGRectMake(230, 60, 60, 22);
//                [_vipBtn setTitle:@"续费" forState:UIControlStateNormal];
                _vipLabel.userInteractionEnabled = YES;
                _vipLabel.text = @"会员";
            }
            NSString * img = [[[dictionary objectForKey:@"data"] objectForKey:@"userImg"] stringByReplacingOccurrencesOfString:@"-s.jpg" withString:@".jpg"];
            [_heatImgView setImageWithURL:[NSURL URLWithString: img] placeholderImage:nil];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:AppDelegate.App.personModel.nickname forKey:@"nickname"];
            [userDefaults setObject:AppDelegate.App.personModel.email forKey:@"email"];
            [userDefaults setObject:AppDelegate.App.personModel.sex forKey:@"sex"];
            [userDefaults setObject:AppDelegate.App.personModel.birthYear forKey:@"birthday"];
            [userDefaults setObject:AppDelegate.App.personModel.address forKey:@"address"];
            [userDefaults synchronize];
            [self.myTableView reloadData];
        }
    }
}
#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"MainCell";
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.cellLabel.text = [_tableArray objectAtIndex:indexPath.row];
    [cell.cellImage setImage:[UIImage imageNamed:[_imgArr objectAtIndex:indexPath.row]]];
    cell.goImage.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = color_21;

    if (indexPath.row==5) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goImage.hidden = YES;
        UILabel * balanceLabel = (UILabel *)[cell viewWithTag:700];
        if (balanceLabel == nil) {
            balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(210-88, 6, 150, 40)];
            balanceLabel.font = font_5;
            balanceLabel.textAlignment = NSTextAlignmentRight;
            balanceLabel.textColor = color_17;
            balanceLabel.backgroundColor = [UIColor clearColor];
            balanceLabel.tag = 700;
            [cell addSubview:balanceLabel];
        }
        
        if ([AppDelegate App].isLogin == NO) {
            balanceLabel.text = nil;
        }
        else
        {
            balanceLabel.text = [NSString stringWithFormat:@"%@猫币",[AppDelegate App].personModel.balance];
        }
        
    }else{
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.selectedBackgroundView = selectedBackView;
//        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row != 7) {
//        if (![AppDelegate App].isLogin) {
//            
//            [self mackNoLongInView];
//            _backButton.hidden = NO;
//            
//            return;
//        }
//    }
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    _myTableView.userInteractionEnabled = NO;
    [self performSelector:@selector(releaseTableView) withObject:nil afterDelay:0.8];
    if (_userDatadelegate && [_userDatadelegate respondsToSelector:@selector(clickTableViewIndex:)]) {
        [_userDatadelegate clickTableViewIndex:indexPath.row];
    }

    
    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    _myCharge=[userDefaultes objectForKey:@"charge_Ivmall"];
//    if (_myCharge && [_myCharge isEqualToString:@"true"]) {
//        
//        if (indexPath.row != 7) {
//            if (![AppDelegate App].isLogin) {
//                
//                [self mackNoLongInView];
//                _backButton.hidden = NO;
//                
//                return;
//            }
//        }
//        
//        if (indexPath.row == 0 + 1) {
//            if ([AppDelegate App].playedTimeView==nil) {
//                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PlayTimeView" owner:self options:nil];
//                [AppDelegate App].playedTimeView = [nib objectAtIndex:0];
//            }
//            [[AppDelegate App].playedTimeView show];
//        }
//        if (indexPath.row == 0 + 1+ 1) {
//            if ([AppDelegate App].collect==nil) {
//                [AppDelegate App].collect=[[CollectView alloc]initMy];
//            }
//            [[AppDelegate App].collect show];
//        }
//        else if (indexPath.row == 1 + 1+ 1)
//        {
//            if ([AppDelegate App].buyView==nil) {
//                [AppDelegate App].buyView=[[BuyView alloc]initMy];
//            }
//            [[AppDelegate App].buyView show];
//        }
//        else if (indexPath.row == 2 + 1+ 1)
//        {
//            if ([AppDelegate App].rechargeRecordView==nil) {
//                [AppDelegate App].rechargeRecordView=[[RechargeRecordView alloc]initMy];
//            }
//            [[AppDelegate App].rechargeRecordView show];
//        }
//        else if (indexPath.row == 3 + 1+ 1)
//        {
//            
//        }
//        else if (indexPath.row == 4 + 1+ 1)
//        {
//            if ([AppDelegate App].rechargeView==nil) {
//                [AppDelegate App].rechargeView=[[RechargeView alloc]initMy];
//            }
//            
//            [Commonality anmou1View:[AppDelegate App].rechargeView delegate:[AppDelegate App].tabBarController];        
//            [[AppDelegate App].rechargeView show];
//        }
//        else if (indexPath.row == 5 + 1+ 1)
//        {
//            if ([AppDelegate App].forgetPasswordView==nil) {
//                [AppDelegate App].forgetPasswordView=[[ForgetPasswordView alloc]initMy];
//            }
//            [AppDelegate App].forgetPasswordView.isForgetType = NO;
//            [[AppDelegate App].forgetPasswordView show];
//        }
//        else if (indexPath.row == 6 + 1+ 1)
//        {
//            if ([AppDelegate App].aboutUsView==nil) {
//                [AppDelegate App].aboutUsView=[[AboutUsView alloc]initMy];
//            }
//            [[AppDelegate App].aboutUsView show];
//        }
//    }
//    else
//    {
//        
//        if (indexPath.row != 3+ 1) {
//            if (![AppDelegate App].isLogin) {
//                
//                [self mackNoLongInView];
//                _backButton.hidden = NO;
//                
//                return;
//            }
//        }
//        
//        if (indexPath.row == 0+ 1) {
//            if ([AppDelegate App].playedTimeView==nil) {
//                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PlayTimeView" owner:self options:nil];
//                [AppDelegate App].playedTimeView = [nib objectAtIndex:0];
//            }
//            [[AppDelegate App].playedTimeView show];
//        }
//        if (indexPath.row == 0 + 1+ 1) {
//            if ([AppDelegate App].collect==nil) {
//                [AppDelegate App].collect=[[CollectView alloc]initMy];
//            }
//            [[AppDelegate App].collect show];
//        }
//        else if (indexPath.row == 1 + 1+ 1)
//        {
//            if ([AppDelegate App].forgetPasswordView==nil) {
//                [AppDelegate App].forgetPasswordView=[[ForgetPasswordView alloc]initMy];
//            }
//            [AppDelegate App].forgetPasswordView.isForgetType = NO;
//            [[AppDelegate App].forgetPasswordView show];
//        }
//        else if (indexPath.row == 2 + 1+ 1)
//        {
//            if ([AppDelegate App].aboutUsView==nil) {
//                [AppDelegate App].aboutUsView=[[AboutUsView alloc]initMy];
//            }
//            [[AppDelegate App].aboutUsView show];
//        }
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)releaseTableView
{
    _myTableView.userInteractionEnabled = YES;
}

#pragma mark textfield methods
-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    if (_hihel == YES) {
        return YES;
    }
    if (textField.tag == 2001) {
        if ( textField.text.length > 0 && textField.text.length != 11) {
            [Commonality showErrorMsg:self type:0 msg:@"请输入正确的手机格式！"];
            return  YES;
        }
    }
    else if (textField.tag == 2002)
    {
        if (textField.text.length > 0 && textField.text.length < 6) {
            if (_hihel == YES) {
                return YES;
            }
            [Commonality showErrorMsg:self type:0 msg:@"密码至少要6位哦"];
            return YES;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==2001){
        if (range.location>10)
        {
//            [MKInfoPanel showPanelInView:self type:MKInfoPanelTypeInfo title:@"请输入正确的手机格式！" subtitle:nil hideAfter:2];
//            
//            [MKInfoPanel showPanelInView:self title:@"请输入正确的手机格式！" isMiddleShow:YES];
             [Commonality showErrorMsg:self type:0 msg:@"请输入正确的手机格式！"];
            
            return  NO;
        }
        else
        {
            return YES;
        }
    }else if(textField.tag==2002){
        if(range.location>19){
            [Commonality showErrorMsg:self type:0 msg:@"登录密码输入不能超过20位"];
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

-(void)showFromPlayHistory
{
    isFromHistory = YES;
    _hihel=NO;
    UIViewController * main = [AppDelegate App].tabBarController;

    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(rect.size.width - 140 , [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
                         _myView.alpha = 0.5;
                     }];
    
    [main.view addSubview:_myView];
    _myView.frame = CGRectMake(main.view.frame.origin.y, main.view.frame.origin.x + 54, main.view.frame.size.height, main.view.frame.size.width);
    [main.view addSubview:self];
    
    
    
    if ([AppDelegate App].isLogin) {
        [self makeLogInView];
    }else{
        [self mackNoLongInView];
    }
}

-(void)show{
    _hihel=NO;
    _backButton.hidden = YES;
    UIViewController * main = [AppDelegate App].tabBarController;
    [UIView animateWithDuration:0.5
                     animations:^{

                         self.frame = CGRectMake(rect.size.width - 140 , [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
//                         self.frame = CGRectMake(0 , [AppDelegate App].countIOS7 + 0,400 , rect.size.height-44-[AppDelegate App].countIOS7);
                         _myView.alpha = 0.5;
                     }];
    
    [main.view addSubview:_myView];
    _myView.frame = CGRectMake(main.view.frame.origin.y, main.view.frame.origin.x + 54, main.view.frame.size.height, main.view.frame.size.width);
    [main.view addSubview:self];
    
//    if ([AppDelegate App].isLogin) {
        [self makeLogInView];
//    }else{
//        [self mackNoLongInView];
//    }
}

-(void)reloder{
    if ([AppDelegate App].isLogin) {
        [self makeLogInView];
    }else{
        [self mackNoLongInView];
    }
}

-(void)dismiss{
    _hihel=YES;
    isFromHistory = NO;
    [HttpRequest myCancelAsi];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(rect.size.width - 140 + 400, [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
                         _myView.alpha = 0;
                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                         [_myView removeFromSuperview];
                     }];
    
}

-(NSString *)setTime:(NSString *)timeStr
{
    NSString* string = timeStr;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
//    [outputFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str1 = [outputFormatter stringFromDate:inputDate];
    return str1;
}

@end

