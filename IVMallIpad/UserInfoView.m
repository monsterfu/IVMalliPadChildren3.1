//
//  UserInfoView.m
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-2-27.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "UserInfoView.h"
#import "AppDelegate.h"


@implementation UserInfoView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

-(id) initMyWithFrame:(CGRect)newFrame{
    if (self=[super init]) {

        
        rect=[[UIScreen mainScreen] bounds];
        
        UIViewController * main = [AppDelegate App].tabBarController;
        _myView = [[UIView alloc] init];
        _myView.frame = CGRectMake(main.view.frame.origin.x, main.view.frame.origin.y + 64, 400, main.view.frame.size.height);
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myEndEditing)];
        tap.numberOfTapsRequired=1;
        [_myView addGestureRecognizer:tap];
        self.frame=newFrame;
        tmpRect=self.frame;

    //
//        self.frame=CGRectMake(102 , 303 - 20, rect.size.height - 500, rect.size.width- 450);
        
        tmpRect=self.frame;
        
        self.backgroundColor=color_21;
        
        UIView*heatView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, rect.size.height - 320, 80)];
        heatView.backgroundColor=[UIColor clearColor];
        
        UIButton * btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setImage:[UIImage imageNamed:@"gou.png"] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [btn addTarget:self  action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor clearColor];
        btn.frame=CGRectMake(rect.size.height - 380, 30, 30, 30);
        [heatView addSubview:btn];
        
        UIButton * btn3=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn3 setImage:[UIImage imageNamed:@"X.png"] forState:UIControlStateNormal];
        btn3.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [btn3 addTarget:self  action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        btn3.backgroundColor=[UIColor clearColor];
        btn3.frame=CGRectMake(25, 30, 30, 30);
//        [heatView addSubview:btn3];
        
        
//        CGRect rect1 = heatView.frame;
        
//        UILabel * titleLabe=[[UILabel alloc]initWithFrame:CGRectMake(rect1.origin.x, rect1.origin.y+10, rect1.size.width, rect1.size.height- 10)];
//        titleLabe.textColor=[UIColor blackColor];
//        titleLabe.text=@"个人资料";
//        titleLabe.font=[UIFont boldSystemFontOfSize:HEADVIEW_TITLESIZE];
//        titleLabe.alpha = HEADVIEW_TITLE_ALPHA;
//        titleLabe.textAlignment=NSTextAlignmentCenter;
//        titleLabe.backgroundColor=[UIColor clearColor];
//        [heatView addSubview:titleLabe];
        
        UIButton *  backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(30, 30, 30, 30);
        [backBtn setImage:[UIImage imageNamed:@"返回2.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [heatView addSubview:backBtn];
        backBtn.hidden = YES;
        //
        
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 80, newFrame.size.width, rect.size.width-44-[AppDelegate App].countIOS7-50 + 55)];
        _tabelView.backgroundColor=color_21;
        _tabelView.separatorStyle=NO;
        _tabelView.dataSource=self;
        _tabelView.delegate=self;
        _tabelView.scrollEnabled = NO;
        
        [self addSubview:_tabelView];
        _tableViewPoint = _tabelView.center;
        [self addSubview:heatView];
    }
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 10;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    [self addGestureRecognizer:singleTapGR];
    return self;
}



-(void)myEndEditing
{
    self.frame = CGRectMake(rect.size.height/2 - (rect.size.height - 500)/2 , rect.size.width/2 - (rect.size.width- 450+ 55)/2, rect.size.height - 500, rect.size.width- 450+ 55);
    [self endEditing:YES];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    _tabelView.center = _tableViewPoint;
    [self endEditing:YES];
}

-(void)show{
    _hihel=YES;
//    UIViewController * main = [AppDelegate App].tabBarController;
//    self.center=CGPointMake(tmpRect.origin.x+tmpRect.size.width/2, tmpRect.origin.y+tmpRect.size.height);
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         self.frame = CGRectMake(rect.size.height/2 - (rect.size.height - 500)/2 , rect.size.width/2 - (rect.size.width- 450+ 55)/2, rect.size.height - 500, rect.size.width- 450+ 55);
//                         _myView.frame = CGRectMake(main.view.frame.origin.x, main.view.frame.origin.y, main.view.frame.size.height, main.view.frame.size.width);
//                         _myView.alpha = 0.5;
//                     }];
//    [main.view addSubview:_myView];
//    [main.view addSubview:self];
    
    if ([[AppDelegate App].personModel.sex isEqualToString:@"male"]) {
        if (btn1) {
            [self djSex1:btn1];
        }
    }
    else
    {
        if (btn2) {
            [self djSex2:btn2];
        }
    }
    
    [self.tabelView reloadData];
    _tmpbrithTextField.text = [AppDelegate App].personModel.birthYear;
    [HttpRequest UserInfoRequest:[AppDelegate App].personModel.tokenid delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
}

-(void)dismiss{

//    [UIView animateWithDuration:1.0
//                     animations:^{
//                         CGAffineTransform transform = CGAffineTransformScale(self.transform,0,0);
//                         [self setTransform:transform];
//                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:self cache:YES];
//                     } completion:^(BOOL finished) {
//                         _hihel=NO;
//                         _tabelView.center = _tableViewPoint;
//                         [self removeFromSuperview];
//                         [_myView removeFromSuperview];
//                         self.transform = CGAffineTransformIdentity;
//                         
//                     }];
    [self removeFromSuperview];
}


-(void)saveInfo
{
    [self endEditing:YES];
    if ([Commonality isEnableWIFI]==0) {
        [Commonality showErrorMsg:self type:0 msg:FAIILURE];
        return;
    }
    

    
    {
        if (![self isValidateEmail:_emalTextField.text] && !_emalTextField.text.length == 0) {
            [Commonality showErrorMsg:self type:0 msg:@"邮箱格式不对哦"];
            return;
        }
    }
    
    self.userInteractionEnabled = NO;
    if(self.sex==0){
        AppDelegate.App.personModel.sex=@"male";
    }else{
        AppDelegate.App.personModel.sex=@"female";
    }
    [HttpRequest UpdatePersonInfoRequest:AppDelegate.App.personModel.tokenid nickname:self.nameTextField.text email:self.emalTextField.text lang:@"zh-cn" birthYear:_tmpbrithTextField.text gender:[AppDelegate App].personModel.sex address:self.adressTextField.text delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}

-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *cellIdentifier = @"MainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"MainCell_%d",indexPath.row]];
    
    if (1){//cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"MainCell_%d",indexPath.row]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    }
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 3, tableView.frame.size.width-10, 34)];
        view.backgroundColor = color_21;
        switch (indexPath.row) {
            case 4:
            {
                view.frame=CGRectMake(5, 3, tableView.frame.size.width-10, 50);
                
                if (1){//_adressTextField == nil) {
                    _adressTextField = [[UITextField alloc]initWithFrame:CGRectMake(140, 0, tableView.frame.size.width- 185, 53)];
                    _adressTextField.textAlignment = NSTextAlignmentRight;
                    _adressTextField.tag=1158;
                    _adressTextField.alpha = 0.6;
                    _adressTextField.backgroundColor =[UIColor clearColor];
                    _adressTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
                    _adressTextField.autocorrectionType = UITextAutocorrectionTypeNo;
//                    _adressTextField.textAlignment = UITextAlignmentLeft;
                    _adressTextField.keyboardType = UIKeyboardTypeDefault;
                    _adressTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    _adressTextField.returnKeyType =UIReturnKeyDone;
                    _adressTextField.delegate=self;
                    _adressTextField.placeholder = @"请填写地址";
                    _adressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    [view addSubview:_adressTextField];
                    
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 17, 0, 0)];
                    label.text = @"地址:";
                    label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
                    label.backgroundColor = [UIColor clearColor];
                    [label sizeToFit];
                    [view addSubview:label];
                    
                    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(30, 12, 30, 30)];
                    image.image = [UIImage imageNamed:@"地址.png"];
                    image.backgroundColor = [UIColor clearColor];
                    [view addSubview:image];
                }
                
                _adressTextField.text=AppDelegate.App.personModel.address;
                
            }
                break;

            case 1:
            {
                _emalTextField= [[UITextField alloc]initWithFrame:CGRectMake(140, 3, tableView.frame.size.width- 185, 40)];
                _emalTextField.borderStyle = UITextBorderStyleNone;
                _emalTextField.textAlignment = NSTextAlignmentRight;
                [_emalTextField setTag:2001];
                _emalTextField.alpha = 0.6;
                _emalTextField.placeholder = @"请填写邮箱";
                if ([[AppDelegate App].personModel.email isEqualToString:@"未绑定"] || [[AppDelegate App].personModel.email isEqualToString:@"(null)"]||[[AppDelegate App].personModel.email isEqualToString:@""]) {
                    _emalTextField.text = @"";
                }else{
                    _emalTextField.text=[AppDelegate App].personModel.email;
                }
            
                _emalTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
                _emalTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
                _emalTextField.autocorrectionType = UITextAutocorrectionTypeNo;
//                _emalTextField.textAlignment = UITextAlignmentLeft;
                _emalTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                _emalTextField.keyboardType = UIKeyboardTypeEmailAddress;
                _emalTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                _emalTextField.returnKeyType =UIReturnKeyDone;
                _emalTextField.delegate = self;
                [view addSubview:_emalTextField];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 0, 0)];
                label.text = @"邮箱:";
                label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
                label.backgroundColor = [UIColor clearColor];
                [label sizeToFit];
                [view addSubview:label];
                
                UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 30, 30)];
                image.image = [UIImage imageNamed:@"邮箱.png"];
                image.backgroundColor = [UIColor clearColor];
                [view addSubview:image];
            }
                break;
            case 0:
            {
                _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(140, 3, tableView.frame.size.width- 185, 40)];
                _nameTextField.borderStyle = UITextBorderStyleNone;
                [_nameTextField setTag:2002];
                _nameTextField.placeholder = @"请填写昵称";
                _nameTextField.textAlignment = NSTextAlignmentRight;
                _nameTextField.alpha = 0.6;
                _nameTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
                _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
                _nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
                _nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                _nameTextField.keyboardType = UIKeyboardTypeDefault;
                _nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                _nameTextField.returnKeyType =UIReturnKeyDone;
                _nameTextField.delegate = self;
                if ([AppDelegate App].personModel.nickname) {
                    _nameTextField.text = [AppDelegate App].personModel.nickname;
                }else{
                    _nameTextField.text = [AppDelegate App].personModel.mobile;
                }
                
                [view addSubview:_nameTextField];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 0, 0)];
                label.text = @"昵称:";
                label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
                label.backgroundColor = [UIColor clearColor];
                [label sizeToFit];
                [view addSubview:label];
                
                UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 30, 30)];
                image.image = [UIImage imageNamed:@"昵称.png"];
                image.backgroundColor = [UIColor clearColor];
                [view addSubview:image];
    
            }
                break;
            case 2:
            {
                
                UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(_tabelView.frame.size.width - 170, 1, 120, 45)];
                view1.backgroundColor = [Commonality colorFromHexRGB:@"1a8cea"];
                view1.layer.cornerRadius = 5;
                [view addSubview:view1];
                
                indicateView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 50, 35)];
                indicateView.backgroundColor = [UIColor whiteColor];
                indicateView.layer.cornerRadius = 5;
                [view1 addSubview:indicateView];
                
                btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn1.frame = CGRectMake(5, 5, 50, 35);
                [btn1 setTitle:@"男" forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(djSex1:) forControlEvents:UIControlEventTouchUpInside];
                [view1 addSubview:btn1];
                
                btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn2.frame = CGRectMake(65, 5, 50, 35);
                [btn2 setTitle:@"女" forState:UIControlStateNormal];
                [btn2 addTarget:self action:@selector(djSex2:) forControlEvents:UIControlEventTouchUpInside];
                [view1 addSubview:btn2];

                if ([[AppDelegate App].personModel.sex isEqualToString:@"male"]) {
                    [self djSex1:btn1];
                }
                else
                {
                    [self djSex2:btn2];
                }
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 0, 0)];
                label.text = @"性别:";
                label.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
                label.backgroundColor = [UIColor clearColor];
                [label sizeToFit];
                [view addSubview:label];
                
                UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(30, 7, 30, 30)];
                image.image = [UIImage imageNamed:@"性别.png"];
                image.backgroundColor = [UIColor clearColor];
                [view addSubview:image];
                
            }
                break;
            case 3:
            {
                UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 30, 30)];
                image.image = [UIImage imageNamed:@"cake.png"];
                image.backgroundColor = [UIColor clearColor];
                [view addSubview:image];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 0, 0)];
                label.text = @"生日:";
                label.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
                label.backgroundColor = [UIColor clearColor];
                [label sizeToFit];
                [view addSubview:label];
                
                _tmpbrithTextField=[[JYTextField alloc]initWithFrame:CGRectMake(140, 3, tableView.frame.size.width- 185, 40)];
                _tmpbrithTextField.placeholder = @"请填写生日";
                _tmpbrithTextField.textAlignment = NSTextAlignmentRight;
                _tmpbrithTextField.alpha = 0.6;
                _tmpbrithTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
//                _tmpbrithTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
                _tmpbrithTextField.autocorrectionType = UITextAutocorrectionTypeNo;
                _tmpbrithTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                _tmpbrithTextField.keyboardType = UIKeyboardTypeDefault;
                _tmpbrithTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                _tmpbrithTextField.returnKeyType =UIReturnKeyDone;
                _tmpbrithTextField.delegate = self;
                _tmpbrithTextField.text=[AppDelegate App].personModel.birthYear;
                [view addSubview:_tmpbrithTextField];
            }
            default:
                break;
        }
        if (indexPath.row < 4) {
            UIView *lineview = [[UIView alloc] initWithFrame:CGRectNull];
            lineview.frame = CGRectMake(40, 54,tableView.frame.size.width- 80,0.5);
            lineview.backgroundColor = [UIColor lightGrayColor];
            lineview.alpha = 0.2;
            [cell addSubview:lineview];
        }
        
        
        [cell addSubview:view];
    }
    
    cell.contentView.backgroundColor = color_21;
    return cell;
}

-(void)djSex2:(UIButton *)sender{
    [sender setTitleColor:[Commonality colorFromHexRGB:@"1a8cea"] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.2];
    indicateView.frame = CGRectMake(65, 5, 50, 35);
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UIView commitAnimations];
//    [AppDelegate App].personModel.sex=@"female";
    self.sex = 1;

    
}

-(void)djSex1:(UIButton *)sender{
    [sender setTitleColor:[Commonality colorFromHexRGB:@"1a8cea"] forState:UIControlStateNormal];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.2];
    indicateView.frame = CGRectMake(5, 5, 50, 35);
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UIView commitAnimations];
//    [AppDelegate App].personModel.sex=@"male";
    self.sex = 0;
}

-(void) GetErr:(ASIHTTPRequest *)request{
    self.userInteractionEnabled = YES;
}

-(void) GetResult:(ASIHTTPRequest *)request{
    self.userInteractionEnabled = YES;
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if(dictionary==nil){
        [Commonality showErrorMsg:self type:0 msg:@"网络连接异常，请重试"];
        
    }else{
        if (request.tag == USERINFOURL_TYPE){
            
            AppDelegate.App.personModel.address = [[dictionary objectForKey:@"data"] objectForKey:@"address"];
            AppDelegate.App.personModel.balance = [[dictionary objectForKey:@"data"] objectForKey:@"balance"];
            AppDelegate.App.personModel.birthYear = [[dictionary objectForKey:@"data"] objectForKey:@"birthday"];
            AppDelegate.App.personModel.email = [[dictionary objectForKey:@"data"] objectForKey:@"email"];
            AppDelegate.App.personModel.sex = [[dictionary objectForKey:@"data"] objectForKey:@"gender"];
            AppDelegate.App.personModel.lang =[[dictionary objectForKey:@"data"] objectForKey:@"lang"];
            AppDelegate.App.personModel.nickname = [[dictionary objectForKey:@"data"] objectForKey:@"nickname"];
            
            AppDelegate.App.personModel.vipExpiryTime = [[dictionary objectForKey:@"data"] objectForKey:@"vipExpiryTime"];
            [self.tabelView reloadData];
        }
        
        else
        {
            UpdatePersonInfoModel *um=[[UpdatePersonInfoModel alloc]initWithDictionary:dictionary];
            if (um.result==0) {
                AppDelegate.App.personModel.nickname=self.nameTextField.text;
                AppDelegate.App.personModel.email=self.emalTextField.text;
                AppDelegate.App.personModel.birthYear=self.tmpbrithTextField.text;
                if(self.sex==0){
                    AppDelegate.App.personModel.sex=@"male";
                }else{
                    AppDelegate.App.personModel.sex=@"female";
                }
                [AppDelegate App].personModel.address=self.adressTextField.text;
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.nameTextField.text forKey:@"nickname"];
                [userDefaults setObject:self.emalTextField.text forKey:@"email"];
                [userDefaults setObject:AppDelegate.App.personModel.sex forKey:@"sex"];
                [userDefaults setObject:self.tmpbrithTextField.text forKey:@"birthday"];
                [userDefaults setObject:self.adressTextField.text forKey:@"address"];
                [userDefaults synchronize];
                
                [[[AppDelegate App] personView].userView  reloder];
                [Commonality showErrorMsg:self type:0 msg:@"您更新成功!"];
                //[self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5];
            }else{
                [Commonality showErrorMsg:self type:um.result msg:nil];
            }
        }
        
        

    }
}

#pragma mark - QRadioButtonDelegate
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    self.sex=radio.tag;
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _adressTextField){
        [textField resignFirstResponder];
        return YES;
    }
    _tabelView.center = _tableViewPoint;
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _adressTextField){
        _tabelView.center = _tableViewPoint;
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==2001){
        if (range.location>40)
        {
            return  NO;
        }
        else
        {
            return YES;
        }
    }else if(textField.tag==2002){
        if (string.length>=1) {
            unichar temp = [string characterAtIndex:0];
            NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
            if([doNotWant characterIsMember:temp])
            {
                [Commonality showErrorMsg:self type:0 msg:@"禁用非法字符！"];
                return NO;
            }
        }
        
        if (range.location>14 && ![string isEqualToString:@""]) {
//            [IVMallTools showErrorMsg:self.view type:0 msg:@"昵称不能超过15位！"];
             [Commonality showErrorMsg:self type:0 msg:@"昵称不能超过15位！"];
            return NO;
        }else{
            return YES;
        }

    }else if(textField.tag==2003){
        if(range.location>10){
            return NO;
        }else{
            return YES;
        }
    }
    else if (textField.tag == 1158)
    {
        if (range.location>119) {
//            [IVMallTools showErrorMsg:self.view type:0 msg:@"地址不能超过120位！"];
            [Commonality showErrorMsg:self type:0 msg:@"地址不能超过120位！"];
            return NO;
        }else{
            return YES;
        }
    }
    
    
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.tag==1158) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
        }
        if (range.location>119) {
            [Commonality showErrorMsg:self type:0 msg:@"地址不能超过120位！"];
    
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField == _adressTextField) {
        _tabelView.frame = CGRectMake(_tabelView.frame.origin.x, _tabelView.frame.origin.y - 50, _tabelView.frame.size.width, _tabelView.frame.size.height);
    }
//    if (textField == _emalTextField) {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDelay:0.2];
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 55 , self.frame.size.width, self.frame.size.height);
//        [UIView commitAnimations];
//    }
    if (textField == _tmpbrithTextField) {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDelay:0.2];
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 20 , self.frame.size.width, self.frame.size.height);
//        [UIView commitAnimations];
        
        UIDatePicker*datepic=[[UIDatePicker alloc]init];
        datepic.datePickerMode=UIDatePickerModeDate;
        datepic.maximumDate=[NSDate date];
        datepic.date=[NSDate date];
        [datepic addTarget:self action:@selector(setTime:) forControlEvents:UIControlEventValueChanged];
        textField.inputView=datepic;
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(void)setTime:(UIDatePicker*)sender{
    NSDateFormatter*date=[[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd"];
    self.tmpbrithTextField.text=[date stringFromDate:sender.date];
    date = nil;
}



@end
