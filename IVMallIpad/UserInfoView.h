//
//  UserInfoView.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-2-27.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Macro.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "MJRefresh.h"
#import "UpdatePersonInfoModel.h"
#import "QRadioButton.h"

@interface UserInfoView : UIView<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    CGRect rect;
    CGPoint _tableViewPoint;
    CGRect tmpRect;
    
    UIButton * btn1;
    UIButton * btn2;
    UIView * indicateView;//
}

@property(nonatomic,strong)UIView* myView;
@property(nonatomic,strong)NSString * lang;
@property(nonatomic,assign)BOOL hihel;
@property(nonatomic,strong)UITableView *tabelView;
@property(nonatomic,strong)UIButton *saveButton;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UITextField *adressTextField;
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *emalTextField;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *tmpbrithTextField;
@property(nonatomic,strong)QRadioButton *man;
@property(nonatomic,strong)QRadioButton *woman;
@property (assign, nonatomic) int sex;

-(id) initMyWithFrame:(CGRect)newFrame;
-(void) show;
-(void) dismiss;
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;

@end
