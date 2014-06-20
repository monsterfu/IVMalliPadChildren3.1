////
////  ForgetPasswordView.m
////  IVMall (Ipad)
////
////  Created by  周传森 on 14-3-3.
////  Copyright (c) 2014年 HYQ. All rights reserved.
////


//
//  ForgetPasswordView.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ForgetPasswordView.h"
#import "AppDelegate.h"
#import "UIButton+Bootstrap.h"

@implementation ForgetPasswordView

-(id) initMyWithRect:(CGRect)newRect{
    if (self=[super init]) {
        int count=0;
        if (IOS7) {
            count=20;
        }
        _isShowing = NO;
        isNoticed = NO;
        rect=[[UIScreen mainScreen] bounds];
//        _myView=[[UIView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - 80, rect.size.height)];
//        _myView.alpha=0.1;
//        _myView.userInteractionEnabled=YES;
        UIViewController * main = [AppDelegate App].tabBarController;
        _myView = [[UIView alloc] init];
        _myView.frame = main.view.frame;
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissALLView)];
        tap.numberOfTapsRequired=1;
        [_myView addGestureRecognizer:tap];
        
        self.frame = newRect;
        self.backgroundColor=color_22;
        tmpRect=self.frame;
        
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 67, newRect.size.width, newRect.size.height - 67)];
        _myScrollView.contentSize = CGSizeMake(newRect.size.width, newRect.size.height - 67);
        _myScrollView.pagingEnabled = NO;
        _myScrollView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_myScrollView];
    }
    
    [Commonality setImgViewStyle:self];
    
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(tapAnywhereToDismissKeyboard:)];
    [self addGestureRecognizer:singleTapGR];
    
    
    self.lowLab.textColor = [UIColor whiteColor];
    self.midLab.textColor = [UIColor whiteColor];
    self.hightLab.textColor = [UIColor whiteColor];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boxValueChanged) name:UITextFieldTextDidChangeNotification object:nil];
    
    _phoneTextField = [[JYTextField alloc]initWithFrame:CGRectMake(newRect.size.width/2 - 195, 0, 390, 51)
                                            cornerRadio:10
                                            borderColor:[UIColor whiteColor]
                                            borderWidth:0.5
                                             lightColor:nil
                                              lightSize:0
                                       lightBorderColor:nil];
    [_phoneTextField setPlaceholder:@"手机号码"];
    
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.backgroundColor = [Commonality colorFromHexRGB:@"ffffff"];
    _phoneTextField.tag = 2001;
    _phoneTextField.delegate = self;
    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	[_myScrollView addSubview:_phoneTextField];
    
    _passWordField = [[JYTextField alloc]initWithFrame:CGRectMake(newRect.size.width/2 - 195, 76, 390, 51)
                                           cornerRadio:6
                                           borderColor:[Commonality colorFromHexRGB:@"323232"]
                                           borderWidth:0.5
                                            lightColor:nil
                                             lightSize:0
                                      lightBorderColor:nil];
    [_passWordField setPlaceholder:@"新密码"];
    _passWordField.keyboardType=UIKeyboardTypeASCIICapable;
    _passWordField.backgroundColor =[Commonality colorFromHexRGB:@"ffffff"];
    _passWordField.tag = 2002;
    _passWordField.delegate = self;
    [_passWordField setSecureTextEntry:YES];
    _passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
	[_myScrollView addSubview:_passWordField];
    
    
    _lowLab = [[UILabel alloc] initWithFrame:CGRectMake(newRect.size.width/2 - 195, _passWordField.frame.origin.y +_passWordField.frame.size.height + 25 , 73, 14)];
    _lowLab.text = @"低";
    _lowLab.textAlignment = NSTextAlignmentCenter;
    _lowLab.font = [UIFont boldSystemFontOfSize:12];
    _lowLab.layer.cornerRadius = 7;
    _lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
    [_myScrollView addSubview:_lowLab];
    
    _verifyPassWordField = [[JYTextField alloc]initWithFrame:CGRectMake(newRect.size.width/2 - 195, _lowLab.frame.origin.y + 14 + 25, 390, 51)
                                                 cornerRadio:6
                                                 borderColor:[Commonality colorFromHexRGB:@"323232"]
                                                 borderWidth:0.5
                                                  lightColor:nil
                                                   lightSize:0
                                            lightBorderColor:nil];
    [_verifyPassWordField setPlaceholder:@"确认新密码"];
    _verifyPassWordField.keyboardType=UIKeyboardTypeASCIICapable;
    _verifyPassWordField.backgroundColor = [Commonality colorFromHexRGB:@"ffffff"];
    _verifyPassWordField.tag = 2003;
    _verifyPassWordField.delegate = self;
    [_verifyPassWordField setSecureTextEntry:YES];
    _verifyPassWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
	[_myScrollView addSubview:_verifyPassWordField];
    
    _checkCodeField = [[JYTextField alloc]initWithFrame:CGRectMake(newRect.size.width/2 - 195, 228, 390, 51)
                                            cornerRadio:6
                                            borderColor:[Commonality colorFromHexRGB:@"323232"]
                                            borderWidth:0.5
                                             lightColor:nil
                                              lightSize:0
                                       lightBorderColor:nil];
    [_checkCodeField setPlaceholder:@"验证码"];
    _checkCodeField.keyboardType=UIKeyboardTypeASCIICapable;
    _checkCodeField.backgroundColor = [Commonality colorFromHexRGB:@"ffffff"];
    _checkCodeField.tag = 2004;
    _checkCodeField.delegate = self;
    
    _checkCodeField.frame = CGRectMake(self.frame.size.width/2 - 195, _verifyPassWordField.frame.origin.y + _verifyPassWordField.frame.size.height + 25, 390, 51);
    
	[_myScrollView addSubview:_checkCodeField];
    
    _checkCodeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [_checkCodeBtn setFrame:CGRectMake(_checkCodeField.frame.origin.x + _checkCodeField.frame.size.width - 100 - 5, _checkCodeField.frame.origin.y+2, 100, _checkCodeField.frame.size.height-4)];
    
    [_checkCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    _checkCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _checkCodeBtn.alpha = 0.6;
    [_checkCodeBtn addTarget:self action:@selector(getCheckCode:) forControlEvents:(UIControlEventTouchDown)];
    _checkCodeBtn.backgroundColor = color_20;
    [_checkCodeBtn childrenBtnStyleForBtn:_checkCodeBtn];
    _checkCodeBtnBackView = [Commonality makeButtonShadowViewWhitbtn:_checkCodeBtn];
    [_myScrollView addSubview:_checkCodeBtnBackView];
    
    _phoneTextField.delegate=self;
    _passWordField.delegate=self;
    _verifyPassWordField.delegate=self;
    _checkCodeField.delegate=self;
    
    
    second = 120;
    
//    _lowLab = [[UILabel alloc] initWithFrame:CGRectMake(newRect.size.width/2 - 195, _passWordField.frame.origin.y +_passWordField.frame.size.height + 25 , 73, 14)];
//    _lowLab.text = @"低";
//    _lowLab.textAlignment = NSTextAlignmentCenter;
//    _lowLab.font = [UIFont boldSystemFontOfSize:12];
//    _lowLab.layer.cornerRadius = 7;
//    _lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
//    [_myScrollView addSubview:_lowLab];
    
    _midLab = [[UILabel alloc] initWithFrame:CGRectMake(newRect.size.width/2 - 195 + 74, _lowLab.frame.origin.y, 73, 14)];
    _midLab.text = @"中";
    _midLab.textAlignment = NSTextAlignmentCenter;
    _midLab.font = [UIFont boldSystemFontOfSize:12];
    _midLab.layer.cornerRadius = 7;
    _midLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
    [_myScrollView addSubview:_midLab];
    
    _hightLab = [[UILabel alloc] initWithFrame:CGRectMake(newRect.size.width/2 - 195 + 74 + 74, _lowLab.frame.origin.y, 73, 14)];
    _hightLab.text = @"高";
    _hightLab.textAlignment = NSTextAlignmentCenter;
    _hightLab.font = [UIFont boldSystemFontOfSize:12];
    _hightLab.layer.cornerRadius = 7;
    _hightLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
    [_myScrollView addSubview:_hightLab];
    
    
    _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registBtn.frame = CGRectMake(newRect.size.width/2 - 195, 400, 390, 51);
    [_registBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    _registBtn.layer.cornerRadius = 10;
    _registBtn.alpha = 1;
    [_registBtn setTitle:@"确定" forState:UIControlStateNormal];
    _registBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _registBtn.backgroundColor = color_4;
//    [_registBtn redStyle];
    [_registBtn childrenBtnStyleForBtn:_registBtn];
    _btnBackView = [Commonality makeButtonShadowViewWhitbtn:_registBtn];
    [self addSubview:_btnBackView];
    
    return self;
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    [self endEditing:YES];
}
//
-(void)dismissALLView
{
    [Commonality dismissAllView];
}
//
-(void)show{
    
    _hihel=YES;

    
    if (_isForgetType) {
        _titleLabe.text=@"忘记密码";
        _phoneTextField.placeholder = @"手机号码";
        _phoneTextField.secureTextEntry = NO;
        _passWordField.text = nil;
        _verifyPassWordField.text = nil;
        _checkCodeField.text = nil;
        _lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
        _midLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
        _hightLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
        _phoneTextField.text = [AppDelegate App].personModel.mobile;
        _checkCodeBtn.hidden = NO;
        _checkCodeField.hidden = NO;
        _btnBackView.frame = CGRectMake(tmpRect.size.width/2 - 195, _checkCodeField.frame.origin.y + _checkCodeField.frame.size.height + 150, 390, 51);
        
    }
    else
    {
        _titleLabe.text=@"修改密码";
        _passWordField.text = nil;
        _verifyPassWordField.text = nil;
        _lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
        _midLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
        _hightLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
        _phoneTextField.placeholder = @"旧密码";
        _phoneTextField.secureTextEntry = YES;
        _phoneTextField.text = nil;
        _checkCodeBtn.hidden = YES;
        _checkCodeField.hidden = YES;
        _btnBackView.frame = CGRectMake(tmpRect.size.width/2 - 195, 360, 390, 51);
//        _checkCodeField.frame = CGRectMake(self.frame.size.width/2 - 195, 228, 390, 51);
        
        
    }
//    UIViewController * main = [AppDelegate App].tabBarController;
//    [main.view addSubview:_myView];
//    [main.view addSubview:self];
}
//
- (IBAction)getCheckCode:(id)sender {
    [self endEditing:YES];
    if (_timer!=nil) {
        return;
    }
    if ([Commonality isEmpty:_phoneTextField.text]) {
        [Commonality showErrorMsg:self type:0 msg:@"手机号码不能为空哦!"];
        return;
    }
    if ([Commonality determineCellPhoneNumber:_phoneTextField.text]==NO) {
        [Commonality showErrorMsg:self type:0 msg:@"手机号码格式不正确!"];
        return;
    }
    self.httptype=2;
    [_checkCodeBtn setEnabled:NO];
    ASIHTTPRequest* asiRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:CHECKMOBILEURL]];
    NSString*str=[NSString stringWithFormat:@"{\"mobile\":\"%@\"}",_phoneTextField.text];
    asiRequest.tag=CHECKMOBILEURL_TYPE;
    [asiRequest appendPostData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    [asiRequest setUseSessionPersistence:YES];
    [asiRequest setUseCookiePersistence:YES];
    [asiRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [asiRequest setDelegate:self];
    [asiRequest setDidFinishSelector:@selector(GetResult:)];
    [asiRequest setDidFailSelector:@selector(GetErr:)];
    [asiRequest startSynchronous];
    
}
//
- (IBAction)regist:(id)sender {
    [self endEditing:YES];
    if ([Commonality isEnableWIFI]==0) {
        [Commonality showErrorMsg:self type:0 msg:FAIILURE];
        return;
    }
    
    
    self.httptype=0;
    if ([Commonality isEmpty:_phoneTextField.text]) {
        
        if (_isForgetType) {
            if (isNoticed == YES) {
                return;
            }
            [Commonality showErrorMsg:self type:0 msg:@"手机号码不能为空哦!"];
            return;
        }
        else
        {
            if (isNoticed == YES) {
                return;
            }
            [Commonality showErrorMsg:self type:0 msg:@"旧密码不能为空哦!"];
            return;
        }
        
    }
    if (_passWordField.text == nil || [_passWordField.text  isEqualToString:@""]) {
        if (isNoticed == YES) {
            return;
        }
        [Commonality showErrorMsg:self type:0 msg:@"密码不能为空哦!"];
        return;
    }
    
    if (_passWordField.text.length<6 || (_verifyPassWordField.text.length<6 && _verifyPassWordField.text.length > 0)) {
        if (isNoticed == YES) {
            return;
        }
        [Commonality showErrorMsg:self type:0 msg:@"密码至少要6位哦!"];
        return;
    }
    
    if ([Commonality isEmpty:_verifyPassWordField.text]) {
        if (isNoticed == YES) {
            return;
        }
        [Commonality showErrorMsg:self type:0 msg:@"确认密码不能为空哦!"];
        return;
    }
    if (_checkCodeField.text == nil || [_checkCodeField.text isEqualToString:@""]) {
        
        if (_isForgetType) {
            if (isNoticed == YES) {
                return;
            }
            [Commonality showErrorMsg:self type:0 msg:@"验证码不能为空哦!"];
            return;
        }
        
    }
    
    if ([Commonality determineCellPhoneNumber:_phoneTextField.text]==NO) {
        
        if (_isForgetType) {
            if (isNoticed == YES) {
                return;
            }
            [Commonality showErrorMsg:self type:0 msg:@"请输入正确的手机格式!"];
            return;
        }
        
        
    }
    
    if ([_passWordField.text isEqualToString:_verifyPassWordField.text]==NO){
        if (isNoticed == YES) {
            return;
        }
        [Commonality showErrorMsg:self type:0 msg:@"2次输入密码不一样，请重新输入!"];
        return;
    }
    
    if (_checkCodeField.text.length!=6) {
        
        if (_isForgetType) {
            if (isNoticed == YES) {
                return;
            }
            [Commonality showErrorMsg:self type:0 msg:@"验证码只能6位哦!"];
            return;
        }
        
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([_phoneTextField.text isEqualToString:[userDefaults objectForKey:@"password2"]]==NO) {
        if (!_isForgetType) {
            if (isNoticed == YES) {
                return;
            }
            [Commonality showErrorMsg:self type:0 msg:@"旧密码输入错误"];
            return;
        }
        
    }

    if (_isForgetType) {
//        [Commonality showErrorMsg:self type:0 msg:@"正在找回密码......"];
        NSMutableString*str=[NSMutableString stringWithString:_passWordField.text];
        
        NSString* passWordText = [NSString stringWithFormat:@"%@$^i@#*Vm!all%@",[Commonality MD5:str],_phoneTextField.text];
        
        self.md5PassWord= [Commonality MD5:passWordText];
        
//        self.md5PassWord= [Commonality MD5:str];
        
        [HttpRequest forGetPassWordRequestPhone:_phoneTextField.text validateCode:_checkCodeField.text passwode:_md5PassWord delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    else
    {
//        [Commonality showErrorMsg:self type:0 msg:@"正在修改密码......"];
        
        NSMutableString*str=[NSMutableString stringWithString:_verifyPassWordField.text];
        
        NSString* passWordText = [NSString stringWithFormat:@"%@$^i@#*Vm!all%@",[Commonality MD5:str],_phoneTextField.text];
        
        self.md5PassWord= [Commonality MD5:passWordText];
        
        NSMutableString*str2=[NSMutableString stringWithString:_phoneTextField.text];
        
        passWordText = [NSString stringWithFormat:@"%@$^i@#*Vm!all%@",[Commonality MD5:str2],_phoneTextField.text];
        
        NSString*old=[Commonality MD5:passWordText];
        
        [HttpRequest amendUserRequest:[AppDelegate App].personModel.tokenid newPassword:self.md5PassWord wornPassword:old delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    
    
}
//

-(void)dismiss{
    [HttpRequest myCancelAsi];
    _hihel=NO;
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(rect.size.width - 140 + 400, [AppDelegate App].countIOS7 + 44,400 , rect.size.height-44-[AppDelegate App].countIOS7);
                         _myView.alpha = 0;
                     } completion:^(BOOL finished) {
//                         _hihel=NO;
                         [self removeFromSuperview];
                         [_myView removeFromSuperview];
                         [[AppDelegate App].personView makeLoginView];
                         [[AppDelegate App].personView showLoginView];
                     }];
}

#pragma mark asihttprequest
-(void) GetErr:(ASIHTTPRequest *)request
{
    [_checkCodeBtn setEnabled:YES];
    [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
    
}
-(void)bindingEquipment{
    
    //    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //    [self.view addSubview:HUD];
    //    HUD.delegate = self;
    //    HUD.labelText = @"正在绑定......";
    //    [HUD show:YES];
    
    //    NSMutableDictionary* deviceInfoDic = [[LocoClient_Player sharedInstance] LocoClient_Player_GetLocalInfo];
    //    NSString* modelStr = [deviceInfoDic objectForKey:@"deviceDRMId"];
    
    //    [HttpRequest BingdingToken:[AppDelegate App].personModel.tokenid delegate:self deviceDRMID:modelStr DRMType:[deviceInfoDic objectForKey:@"drmType"] seral:[deviceInfoDic objectForKey:@"seiralNo"] macAddr:[deviceInfoDic objectForKey:@"macAddr"] appVersion:[deviceInfoDic objectForKey:@"appVersion"] osVersion:[deviceInfoDic objectForKey:@"osVersion"] deviceInfo:nil inishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}
-(void) GetResult:(ASIHTTPRequest *)request{
    
    //    if (HUD!=nil) {
    //        [HUD setHidden:YES];
    //    }
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    if(dictionary==nil){
        [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
    }else{
        if (_httptype==5) {//请求验证吗
            //            [Commonality showErrorMsg:self type:0 msg:@"已请求验证码，请留意短信!"];
            
            second = 120;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
            return;
        }
        if (request.tag==CHECKMOBILEURL_TYPE) {
            if ([[dictionary objectForKey:@"errorCode"] isEqualToString:@"102"]) {
                [Commonality showErrorMsg:self type:0 msg:@"该手机号码未注册，请先注册"];
                [_checkCodeBtn setEnabled:YES];
            }else{
                _httptype=5;
                [HttpRequest CheckCodeRequest:_phoneTextField.text delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
            }
            return;
        }
        
        if (request.tag==FORGETPASSWORD_TYPE) {//点击找回密码
            if ([[dictionary objectForKey:@"errorCode"]isEqualToString:@"0"]) {
                
                //                [AppDelegate.App.viewController showMainView];
                
                [Commonality showErrorMsg:self type:0 msg:@"已修改新密码!"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.md5PassWord forKey:@"password"];
                [userDefaults setObject:_verifyPassWordField.text forKey:@"password2"];
                [userDefaults synchronize];
                [AppDelegate App].personModel.mobile = self.phoneTextField.text;
                _checkCodeBtn.userInteractionEnabled = YES;
                [_checkCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
                [self releaseTImer];
                
                [self dismiss];
            }
            else{
                if ([[dictionary objectForKey:@"errorCode"]isEqualToString:@"307"]) {
                    [Commonality showErrorMsg:self type:0 msg:@"验证码不正确"];
                    return;
                }
                
                if ([[dictionary objectForKey:@"errorCode"] isEqualToString:@"102"]) {
                    [Commonality showErrorMsg:self type:0 msg:@"该手机号码未注册，请先注册"];
                    return;
                }
                
                else
                {
                    [Commonality showErrorMsg:self type:0 msg:@"修改新密码失败!"];
                }
            }
        }
        if (request.tag==MODIFYPSWURL_TYPE) {
            if ([[dictionary objectForKey:@"errorCode"]isEqualToString:@"0"]) {
                [Commonality showErrorMsg:self type:0 msg:@"修改密码成功!"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.md5PassWord forKey:@"password"];
                [userDefaults setObject:_verifyPassWordField.text forKey:@"password2"];
                [userDefaults synchronize];
                
                _checkCodeBtn.userInteractionEnabled = YES;
                [_checkCodeBtn setEnabled:YES];
                [_checkCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
                [self releaseTImer];
                
                [self performSelector:@selector(show) withObject:self afterDelay:0.6];
            }
        }
        
    }
    
    
}
#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isNoticed = NO;
}

#pragma mark textfield methods

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _verifyPassWordField||textField == _checkCodeField) {
        [_myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (_hihel == NO) {
        return YES;
    }
    if (textField.tag == 2001) {
        if (textField.text.length > 0 && textField.text.length != 11) {
            if (_isForgetType) {
//                [Commonality showErrorMsg:self type:0 msg:@"请输入正确的手机格式！"];
                UIAlertView *alvIew = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机格式！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alvIew show];
                isNoticed = YES;
            }
            return  YES;
        }
    }
    else if (textField.tag == 2002)
    {
        if (textField.text.length > 0 && textField.text.length < 6) {
//            [Commonality showErrorMsg:self type:0 msg:@"密码至少要6位哦"];
            UIAlertView *alvIew = [[UIAlertView alloc] initWithTitle:nil message:@"密码至少要6位哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alvIew show];
            isNoticed = YES;
            return YES;
        }
    }
    else if (textField.tag == 2003)
    {
        if ([_passWordField.text isEqualToString:_verifyPassWordField.text]==NO && _passWordField.text.length != 0 && _verifyPassWordField.text.length != 0){
            
//            [Commonality showErrorMsg:self type:0 msg:@"2次输入密码不一样，请重新输入!"];
            UIAlertView *alvIew = [[UIAlertView alloc] initWithTitle:nil message:@"2次输入密码不一样，请重新输入!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alvIew show];
            isNoticed = YES;
            return YES;
        }
    }
    else if(textField.tag==2004)
    {
        if( textField.text.length > 0 && textField.text.length != 6){
//            [Commonality showErrorMsg:self type:0 msg:@"验证码只能6位哦"];
            UIAlertView *alvIew = [[UIAlertView alloc] initWithTitle:nil message:@"验证码只能6位哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alvIew show];
            isNoticed = YES;
            return YES;
        }
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2002) {
        _isPasswordFiledEdting = YES;
    }
    
    if (textField == _verifyPassWordField||textField == _checkCodeField){
        [_myScrollView setContentOffset:CGPointMake(0, 60) animated:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 2002) {
        _isPasswordFiledEdting = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==2001){
        if (_isForgetType) {
            if (range.location>10)
            {
                [Commonality showErrorMsg:self type:0 msg:@"手机号码只有11位哦!"];
                return  NO;
            }
            else
            {
                return YES;
            }
        }
        else
        {
            if (range.location>19)
            {
                [Commonality showErrorMsg:self type:0 msg:@"密码输入不能超过20位"];
                return  NO;
            }
            else
            {
                return YES;
            }
        }
        
    }else if(textField.tag==2002){
        [self boxValueChanged:string];
        if(range.location>19){
            [Commonality showErrorMsg:self type:0 msg:@"密码输入不能超过20位"];
            return NO;
        }else{
            return YES;
        }
    }else if(textField.tag==2003){
        if(range.location>19){
            [Commonality showErrorMsg:self type:0 msg:@"密码输入不能超过20位"];
            return NO;
        }else{
            return YES;
        }
    }else if(textField.tag==2004){
        if(range.location>5){
            [Commonality showErrorMsg:self type:0 msg:@"验证码输入不能超过6位"];
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    //    if (textField.tag == 2004) {
    [self endEditing:YES];
    [_myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)boxValueChanged:(NSString*)str
{
    if (_isPasswordFiledEdting) {
        NSString* finalStr;
        UITextField * textField = (UITextField *)[self viewWithTag:2002];
        if (str.length == 0) {
            finalStr = [textField.text substringToIndex:textField.text.length -1];
        }else{
            finalStr = [textField.text stringByAppendingString:str];
        }
        int ret=[Commonality judgePasswordStrength:finalStr];
        
        switch (ret) {
            case 0:
                self.lowLab.backgroundColor=[Commonality colorFromHexRGB:@"fb3f3e"];
                self.midLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
                self.hightLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
                break;
            case 1:
                self.lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
                self.midLab.backgroundColor=[Commonality colorFromHexRGB:@"25a0dc"];
                self.hightLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
                break;
            case 2:
                self.lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
                self.midLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
                self.hightLab.backgroundColor=[Commonality colorFromHexRGB:@"81a511"];
                break;
            default:
                break;
        }
        if (finalStr.length == 0) {
            self.lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
            self.midLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
            self.hightLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
        }
    }
    
}


#pragma mark MBProgressHUDDelegate methods

//- (void)hudWasHidden:(MBProgressHUD *)hud {
//    // Remove HUD from screen when the HUD was hidded
//    [HUD removeFromSuperview];
//    [HUD release];
//	HUD = nil;
//
//}

//倒计时方法验证码实现倒计时300秒，300秒后按钮变换开始的样子
-(void)timerFireMethod:(NSTimer *)theTimer {
    if (second == 1) {
        [_timer invalidate];
        second = 120;
        _timer=nil;
        [_checkCodeBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
        _checkCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_checkCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkCodeBtn setEnabled:YES];
        return;
    }else{
        second--;
        NSString *title = [NSString stringWithFormat:@"%d秒后重试",second];
        _checkCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_checkCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_checkCodeBtn setEnabled:NO];
        [_checkCodeBtn setTitle:title forState:UIControlStateNormal];
        [_checkCodeBtn setTitle:title forState:UIControlStateDisabled];
        _checkCodeBtn.titleLabel.textColor = [Commonality colorFromHexRGB: @"656565"];
        _checkCodeBtn.titleLabel.shadowColor = [Commonality colorFromHexRGB:@"acacac"];
        _checkCodeBtn.titleLabel.shadowOffset = CGSizeMake(0.5,0.5);
        return;
    }
}
//如果登陆成功，停止验证码的倒数，
- (void)releaseTImer {
    if (_timer) {
        [_timer invalidate];
        second = 120;
        _timer=nil;
    }
    [_checkCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_checkCodeBtn setEnabled:YES];
}

-(void)resetCheckCodeBtn
{
    [_timer invalidate];
    second = 120;
    _timer=nil;
    [_checkCodeBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
    _checkCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_checkCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_checkCodeBtn setEnabled:YES];
}


@end

