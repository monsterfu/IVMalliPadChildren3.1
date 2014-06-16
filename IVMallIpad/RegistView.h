//
//  RegistView.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-2-28.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Macro.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "JYTextField.h"
#import "RegistModel.h"

@protocol registViewDelegate <NSObject>
-(void)removeRegistView;
@end
@interface RegistView : UIView<ASIHTTPRequestDelegate,UITextFieldDelegate>
{
    CGRect rect;
    int second;
     CGRect tmpRect;
}
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
@property (strong, nonatomic) JYTextField * privilegesField;
@property (nonatomic,assign)BOOL isShowing;
@property (nonatomic, weak) id<registViewDelegate>delegate;

-(id) initMyWithFrame:(CGRect )newRect;
-(void) show;
-(void) dismiss;
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
-(void)resetCheckCodeBtn;
@end
