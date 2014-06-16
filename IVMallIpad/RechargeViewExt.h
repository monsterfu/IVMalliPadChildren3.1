//
//  RechargeView.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-6.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Macro.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "JYTextField.h"
#import "AppPointsModel.h"
#import "AlipayPrepareSecurePayModel.h"

@protocol rechargeViewReloadDataDelegate <NSObject>
-(void) reloadBalance:(NSDictionary *)DataDic;
@end
@interface RechargeView : UIView<ASIHTTPRequestDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,rechargeViewReloadDataDelegate>
{
    CGRect rect;
    CGRect tmpRect;
    UIView * paySucceedView;
    UILabel * titleLabe;
    UILabel * pointsLab;
    UIButton * backBtn;
    UIButton * dismissBtn;
    UIButton * buyBtn;
    UIView * alipayView;
    UITableView * myTableView;
    AppPointsModel * pointsModel;
    AlipayPrepareSecurePayModel* myAlipay;
    UILabel * pointLab;
    UIButton * lastCLickBtn;
    UIButton * cardBtn;
    UIButton * alipayBtn;
    UIView * paySucceedBagegroundView;
    UIImageView * backgroundImageView;
}
@property (nonatomic, strong) UIViewController * ViewCtl;
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, assign) BOOL hihel;
@property (nonatomic, assign) BOOL isCardRecharge;
@property (nonatomic, assign) BOOL isFromMainShowing;
@property (nonatomic, assign) BOOL isFromMainShowingExt;
@property (nonatomic, strong) UIView * indicator;
-(id) initMy;
-(id) initMyWithFrame:(CGRect )newRect;
-(void) show;

-(void) dismiss;

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
-(void) reloadUI:(NSDictionary *)dictionary;
-(void) reloadBalance:(NSDictionary *)DataDic;
@end
