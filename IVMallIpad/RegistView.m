//
//  RegistView.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-2-28.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "RegistView.h"
#import "AppDelegate.h"
#import "UIButton+Bootstrap.h"

@implementation RegistView

-(id) initMyWithFrame:(CGRect )newRect{
    if (self=[super init]) {
        int count=0;
        if (IOS7) {
            count=20;
        }
        _isShowing = NO;
        rect=[[UIScreen mainScreen] bounds];
        
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
        self.backgroundColor=color_21;
        


        
//        _backButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
//        [_backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
//        _backButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
//        [_backButton addTarget:self  action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//        _backButton.backgroundColor=[UIColor clearColor];
//        _backButton.frame=CGRectMake(30, 10, 30, 30);
//        [self addSubview:_backButton];
        
        
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 208.5, 70, self.frame.size.width, rect.size.width-44-count-50)];
        _myScrollView.contentSize = CGSizeMake(self.frame.size.width, rect.size.width-44-count-50);
        _myScrollView.scrollEnabled = YES;
        _myScrollView.pagingEnabled = NO;
        _myScrollView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_myScrollView];
    }
    
    [Commonality setImgViewStyle:self];
    
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(tapAnywhereToDismissKeyboard:)];
    [self addGestureRecognizer:singleTapGR];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boxValueChanged) name:UITextFieldTextDidChangeNotification object:nil];
    
    _phoneTextField = [[JYTextField alloc]initWithFrame:CGRectMake(0, 0, 417, 51)
                                            cornerRadio:6
                                            borderColor:[Commonality colorFromHexRGB:@"323232"]
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
    
    _passWordField = [[JYTextField alloc]initWithFrame:CGRectMake(0, 51 + 25, 417, 51)
                                           cornerRadio:6
                                           borderColor:[Commonality colorFromHexRGB:@"323232"]
                                           borderWidth:0.5
                                            lightColor:nil
                                             lightSize:0
                                      lightBorderColor:nil];
    [_passWordField setPlaceholder:@"密码至少6位"];
    _passWordField.keyboardType=UIKeyboardTypeASCIICapable;
    _passWordField.backgroundColor =[Commonality colorFromHexRGB:@"ffffff"];
    _passWordField.tag = 2002;
    _passWordField.delegate = self;
    [_passWordField setSecureTextEntry:YES];
    _passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
	[_myScrollView addSubview:_passWordField];
    
    _verifyPassWordField = [[JYTextField alloc]initWithFrame:CGRectMake(0, 127 + 50 + 14, 417, 51)
                                                 cornerRadio:6
                                                 borderColor:[Commonality colorFromHexRGB:@"323232"]
                                                 borderWidth:0.5
                                                  lightColor:nil
                                                   lightSize:0
                                            lightBorderColor:nil];
    [_verifyPassWordField setPlaceholder:@"再次输入密码"];
    _verifyPassWordField.keyboardType=UIKeyboardTypeASCIICapable;
    _verifyPassWordField.backgroundColor = [Commonality colorFromHexRGB:@"ffffff"];
    _verifyPassWordField.tag = 2003;
    _verifyPassWordField.delegate = self;
    [_verifyPassWordField setSecureTextEntry:YES];
    _verifyPassWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
	[_myScrollView addSubview:_verifyPassWordField];
    
    _checkCodeField = [[JYTextField alloc]initWithFrame:CGRectMake(0, 178 + 75 + 14, 417, 51)
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
	[_myScrollView addSubview:_checkCodeField];
    
    _checkCodeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [_checkCodeBtn setFrame:CGRectMake(_checkCodeField.frame.origin.x + _checkCodeField.frame.size.width - 100 - 5, _checkCodeField.frame.origin.y+2, 100, _checkCodeField.frame.size.height-4)];
//    [_checkCodeBtn greyStyle];
    
    _checkCodeBtn.alpha = 0.6;
    [_checkCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    _checkCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_checkCodeBtn addTarget:self action:@selector(getCheckCode:) forControlEvents:(UIControlEventTouchDown)];
    _checkCodeBtn.backgroundColor = color_20;
    [_checkCodeBtn childrenBtnStyleForBtn:_checkCodeBtn];
    UIView * viewq = [Commonality makeButtonShadowViewWhitbtn:_checkCodeBtn];
    [_myScrollView addSubview:viewq];
    
    
    _privilegesField = [[JYTextField alloc]initWithFrame:CGRectMake(0, 229 + 100 + 14, 417, 51)
                                             cornerRadio:6
                                             borderColor:[Commonality colorFromHexRGB:@"323232"]
                                             borderWidth:0.5
                                              lightColor:nil
                                               lightSize:0
                                        lightBorderColor:nil];
    [_privilegesField setPlaceholder:@"优惠码（非必填）"];
    _privilegesField.keyboardType=UIKeyboardTypeASCIICapable;
    _privilegesField.backgroundColor = [Commonality colorFromHexRGB:@"ffffff"];
    _privilegesField.delegate = self;
    _privilegesField.clearButtonMode = UITextFieldViewModeWhileEditing;
	[_myScrollView addSubview:_privilegesField];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString * myCharge=[userDefaultes objectForKey:@"charge_Ivmall"];
    if (myCharge && [myCharge isEqualToString:@"true"]) {
        _privilegesField.hidden = NO;
    }
    else
    {
        _privilegesField.hidden = YES;
    }
    
    
    _phoneTextField.delegate=self;
    _passWordField.delegate=self;
    _verifyPassWordField.delegate=self;
    _checkCodeField.delegate=self;
    _privilegesField.delegate = self;
    
//    [self.checkCodeBtn greyStyle];
    
    second = 120;
    
    _lowLab = [[UILabel alloc] initWithFrame:CGRectMake(11, 102 + 50, 73, 14)];
    _lowLab.text = @"低";
    _lowLab.textAlignment = NSTextAlignmentCenter;
    _lowLab.font = [UIFont boldSystemFontOfSize:12];
    _lowLab.layer.cornerRadius = 7;
    _lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
    [_myScrollView addSubview:_lowLab];
    
    _midLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 102 + 50, 73, 14)];
    _midLab.text = @"中";
    _midLab.textAlignment = NSTextAlignmentCenter;
    _midLab.font = [UIFont boldSystemFontOfSize:12];
    _midLab.layer.cornerRadius = 7;
    _midLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
    [_myScrollView addSubview:_midLab];
    
    _hightLab = [[UILabel alloc] initWithFrame:CGRectMake(159, 102 + 50, 73, 14)];
    _hightLab.text = @"高";
    _hightLab.textAlignment = NSTextAlignmentCenter;
    _hightLab.font = [UIFont boldSystemFontOfSize:12];
    _hightLab.layer.cornerRadius = 7;
    _hightLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
    [_myScrollView addSubview:_hightLab];
    
    
    
    _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registBtn.frame = CGRectMake(self.frame.size.width/2 - 208.5, 359 + 165, 417, 51);
//    CGRectMake(11, 289, 340, 35);
    _registBtn.backgroundColor = [UIColor redColor];
    [_registBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    _registBtn.layer.cornerRadius = 10;
    [_registBtn redStyle];
    _registBtn.alpha = 0.8;
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    _registBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    _registBtn.backgroundColor = color_4;
    [_registBtn childrenBtnStyleForBtn:_registBtn];
    UIView * view2 = [Commonality makeButtonShadowViewWhitbtn:_registBtn];
    [self addSubview:view2];
    
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
-(void)clearTextFiled
{
    _phoneTextField.text = nil;
    _passWordField.text = nil;
    _verifyPassWordField.text = nil;
    _checkCodeField.text = nil;
    _privilegesField.text = nil;
    _lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
    _midLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
    _hightLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
}

-(void)show{
    [self clearTextFiled];
    _hihel=YES;
    
    
    
//    UIViewController * main = [AppDelegate App].tabBarController;
//    
//    
//    [main.view addSubview:_myView];
//    [main.view addSubview:self];
}

- (IBAction)getCheckCode:(id)sender {
    if (_timer!=nil) {
        return;
    }
    self.httptype=1;
    if ([Commonality isEmpty:_phoneTextField.text]) {
        [Commonality showErrorMsg:self type:0 msg:@"手机号码不能为空哦!"];
        return;
    }
    
    if (_phoneTextField.text.length!=11) {
        [Commonality showErrorMsg:self type:0 msg:@"手机号码只有11位哦!"];
        return;
    }
    
    if ([Commonality determineCellPhoneNumber:_phoneTextField.text]==NO) {
        [Commonality showErrorMsg:self type:0 msg:@"请输入正确的手机格式!"];
        return;
    }
    
    if ([Commonality isMobileNumber:_phoneTextField.text]==NO) {
        [Commonality showErrorMsg:self type:0 msg:@"请输入正确的手机格式!"];
        return;
    }
    _checkCodeBtn.enabled = NO;
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

- (IBAction)regist:(id)sender {
    
//    [self clearTextFiled];
//    if (_delegate && [_delegate respondsToSelector:@selector(removeRegistView)]) {
//        [_delegate removeRegistView];
//    }
//    return;
    
    if ([Commonality isEnableWIFI]==0) {
        [Commonality showErrorMsg:self type:0 msg:FAIILURE];
        return;
    }
    
    
    self.httptype=0;
    if ([Commonality isEmpty:_phoneTextField.text]) {
        [Commonality showErrorMsg:self type:0 msg:@"手机号码不能为空哦!"];
        return;
    }
    if ([Commonality determineCellPhoneNumber:_phoneTextField.text]==NO) {
        [Commonality showErrorMsg:self type:0 msg:@"请输入正确的手机格式!"];
        return;
    }
    
    if (_passWordField.text == nil || [_passWordField.text  isEqualToString:@""]) {
        [Commonality showErrorMsg:self type:0 msg:@"密码不能为空哦!"];
        return;
    }
    if (_passWordField.text.length<6) {
        [Commonality showErrorMsg:self type:0 msg:@"密码至少要6位哦!"];
        return;
    }
    
    if ([Commonality isEmpty:_verifyPassWordField.text]) {
        [Commonality showErrorMsg:self type:0 msg:@"确认密码不能为空哦!"];
        return;
    }
    if ([_passWordField.text isEqualToString:_verifyPassWordField.text]==NO){
        [Commonality showErrorMsg:self type:0 msg:@"2次输入密码不一样，请重新输入!"];
        return;
    }
    
    if (_checkCodeField.text == nil || [_checkCodeField.text isEqualToString:@""]) {
        [Commonality showErrorMsg:self type:0 msg:@"验证码不能为空哦!"];
        return;
    }
    if (_checkCodeField.text.length!=6) {
        [Commonality showErrorMsg:self type:0 msg:@"验证码只能6位哦!"];
        return;
    }
    
    
    
    NSMutableString*str=[NSMutableString stringWithString:_passWordField.text];
    
    NSString* passWordText = [NSString stringWithFormat:@"%@$^i@#*Vm!all%@",[Commonality MD5:str],self.phoneTextField.text];
    
    self.md5PassWord= [[Commonality MD5:passWordText]lowercaseString];
    
//    self.md5PassWord= [Commonality MD5:str];
    
    [HttpRequest RegistRequest:_phoneTextField.text password:self.md5PassWord promoCode:_privilegesField.text checkcode:_checkCodeField.text delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}


-(void)dismiss{
    [HttpRequest myCancelAsi];
    _hihel=NO;
    [self removeFromSuperview];
    [_myView removeFromSuperview];
}

#pragma mark asihttprequest
-(void) GetErr:(ASIHTTPRequest *)request{
    _checkCodeBtn.enabled = YES;
    [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
}

-(void)bindingEquipment{
    [HttpRequest BingdingToken:[AppDelegate App].personModel.tokenid delegate:self deviceDRMID:[[AppDelegate App].deviceInfoDic objectForKey:@"deviceDRMId"] DRMType:[[AppDelegate App].deviceInfoDic  objectForKey:@"drmType"] seral:[[AppDelegate App].deviceInfoDic  objectForKey:@"seiralNo"] macAddr:[[AppDelegate App].deviceInfoDic  objectForKey:@"macAddr"] appVersion:[[AppDelegate App].deviceInfoDic  objectForKey:@"appVersion"] osVersion:[[AppDelegate App].deviceInfoDic  objectForKey:@"osVersion"] deviceInfo:nil inishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

-(void) GetResult:(ASIHTTPRequest *)request{


    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    if(dictionary==nil){
        [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
    }else{
        if (request.tag==CHECKMOBILEURL_TYPE) {
            if ([[dictionary objectForKey:@"errorCode"] isEqualToString:@"101"]) {
                [Commonality showErrorMsg:self type:0 msg:@"该用户已注册，请输入新手机号"];
                _checkCodeBtn.enabled = YES;
            }
            else{

//                 [Commonality showErrorMsg:self type:0 msg:@"正在请求验证码中......"];
                _checkCodeBtn.enabled = YES;
                
                [HttpRequest CheckCodeRequest:_phoneTextField.text delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
                
            }
            return;
        }
        if (request.tag==BINDING_TYPE) {
            if ([[dictionary objectForKey:@"errorCode"]intValue]==0) {
//                [[AppDelegate App].userView reloder];
//                [self dismiss];
            }else{
                [Commonality showErrorMsg:self type:[[dictionary objectForKey:@"errorCode"]intValue] msg:nil];
            }
            return;
        }
        
        if (self.httptype==0) {
            RegistModel *lm=[[RegistModel alloc]initWithDictionary:dictionary];
            if (lm.result==0) {
                AppDelegate.App.personModel.mobile=_phoneTextField.text;
                AppDelegate.App.personModel.password=self.md5PassWord;
                AppDelegate.App.personModel.nickname = @"";
                AppDelegate.App.personModel.address = @"";
                AppDelegate.App.personModel.email = @"";
                [Commonality showErrorMsg:self type:0 msg:@"您已注册成功!"];
                [self releaseTImer];
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:@"nickname"];
                [userDefaults setBool:YES forKey:@"registeredOk"];
                [userDefaults setObject:_phoneTextField.text forKey:@"mobile"];
                [userDefaults setObject:self.md5PassWord forKey:@"password"];
                [userDefaults setObject:_passWordField.text forKey:@"password2"];
                [userDefaults synchronize];
                AppDelegate.App.isLogin=YES;
                
                _checkCodeBtn.userInteractionEnabled = YES;
                [_checkCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
                [self releaseTImer];
                
                [self clearTextFiled];
                if (_delegate && [_delegate respondsToSelector:@selector(removeRegistView)]) {
                    [_delegate removeRegistView];
                }
                
                [self bindingEquipment];
                
                [[AppDelegate App].personView redrawUserView];//刷新用户登录状态
            }else{
                [Commonality showErrorMsg:self type:lm.result msg:nil];
            }
        }else if (self.httptype==1) {
            RegistModel *lm=[[RegistModel alloc]initWithDictionary:dictionary];
            if (lm.result==0) {
                [Commonality showErrorMsg:self type:0 msg:@"已请求验证码，请留意短信!"];
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
            }else{
                [Commonality showErrorMsg:self type:lm.result msg:nil];
            }
        }
        
    }
}
#pragma mark -

#pragma mark textfield methods

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _verifyPassWordField||textField == _checkCodeField||textField == _privilegesField)
    {
        [_myScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    if (_hihel == NO) {
        return YES;
    }
    if (textField.tag == 2001) {
        if (textField.text.length > 0 && textField.text.length != 11) {
            
            [Commonality showErrorMsg:self type:0 msg:@"请输入正确的手机格式！"];
            return  YES;
        }
    }
    else if (textField.tag == 2002)
    {
        if (textField.text.length > 0 && textField.text.length < 6) {
            [Commonality showErrorMsg:self type:0 msg:@"密码至少要6位哦"];
            return YES;
        }
    }
    else if (textField.tag == 2003)
    {
        if ([_passWordField.text isEqualToString:_verifyPassWordField.text]==NO && _passWordField.text.length != 0 && _verifyPassWordField.text.length != 0){
            [Commonality showErrorMsg:self type:0 msg:@"2次输入密码不一样，请重新输入!"];
            return YES;
        }
    }
    else if(textField.tag==2004)
    {
        if(textField.text.length > 0 && textField.text.length != 6){
            [Commonality showErrorMsg:self type:0 msg:@"验证码只能6位哦"];
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
    
    if (textField == _verifyPassWordField||textField == _checkCodeField||textField == _privilegesField)
    {
        [_myScrollView setContentOffset:CGPointMake(0, 150) animated:YES];
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
        
        
        if (range.location>10)
        {
            [Commonality showErrorMsg:self type:0 msg:@"手机号码只有11位哦!"];
            return  NO;
        }
        else
        {
            return YES;
        }
    }else if(textField.tag==2002){
        [self boxValueChanged];
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

    [self endEditing:YES];
    [_myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];

    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)boxValueChanged
{
    if (_isPasswordFiledEdting) {
        
        UITextField * textField = (UITextField *)[self viewWithTag:2002];
        int ret=[Commonality judgePasswordStrength:textField.text];
        
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
        if (textField.text.length == 0) {
            self.lowLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
            self.midLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
            self.hightLab.backgroundColor=[Commonality colorFromHexRGB:INDICATOR_COLOR];
        }
    }
    
}


#pragma mark MBProgressHUDDelegate methods

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
