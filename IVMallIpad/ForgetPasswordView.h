//
//  ForgetPasswordView.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-3.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Macro.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "JYTextField.h"
#import "RegistModel.h"

@interface ForgetPasswordView : UIView<ASIHTTPRequestDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    CGRect rect;
    int second;
    CGRect tmpRect;
    BOOL isNoticed;
}
@property(nonatomic,assign)BOOL isShowing;
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, assign) BOOL hihel;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passWordField;
@property (nonatomic,strong) UITextField *verifyPassWordField;
@property (strong, nonatomic) UILabel *lowLab;
@property (strong, nonatomic) UILabel *midLab;
@property (strong, nonatomic) UILabel *hightLab;
@property (strong, nonatomic) UITextField *checkCodeField;
@property (strong, nonatomic) UIButton *checkCodeBtn;
@property (strong, nonatomic) UIButton *registBtn;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int httptype;
@property (strong, nonatomic) NSString *md5PassWord;
@property (assign, nonatomic) BOOL isPasswordFiledEdting;
@property (assign, nonatomic) BOOL isForgetType;//
@property (strong, nonatomic) UILabel *titleLabe;//
@property (strong, nonatomic) UIView * btnBackView;
@property (strong, nonatomic) UIView * checkCodeBtnBackView;


-(id) initMyWithRect:(CGRect)newRect;
-(void) show;
-(void) dismiss;
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
-(void)resetCheckCodeBtn;
@end

