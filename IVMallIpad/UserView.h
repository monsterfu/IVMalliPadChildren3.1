//
//  UserView.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "UserLoginModel.h"
#import "JYTextField.h"
#import "UIImageView+WebCache.h"
@protocol TakePhotoDelegate;
@protocol showUserDataDelegate;
@protocol showUserInfoDelegate;



@interface UserView : UIView<UITextFieldDelegate,ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>{
    CGRect rect;
    CGRect tmpRect;
    BOOL isFromHistory;
    UIView * selectedBackView;
    
    UIView* viewBG;
}

@property(nonatomic,strong)UIView*myView;

@property(nonatomic,assign)BOOL hihel;

@property(nonatomic,strong)NSArray*tableArray;
@property(nonatomic,strong)UIImageView* heatImgView;
@property(nonatomic,strong)UIImageView* headBgImgView;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* vipLabel;


@property(nonatomic,strong)JYTextField*phoneTextField;
@property(nonatomic,strong)JYTextField*passWordTextField;

@property(nonatomic,strong)UIButton* logInButton;
@property(nonatomic,strong)UIButton* registerButton;
@property(nonatomic,strong)UIButton* forGetButton;

@property(nonatomic,strong)UITableView* myTableView;
@property(nonatomic,strong)UIButton* logOutButton;
@property(nonatomic,strong)NSString* md5PassWord;
@property(nonatomic,strong)NSMutableArray * imgArr;
@property(nonatomic,strong)UIButton * vipBtn;

@property(nonatomic,strong)UIView* heatView;
@property(nonatomic,strong)UIView * loginHeadView;
@property(nonatomic,assign)BOOL isPlayHidend;
@property(nonatomic,strong)UIButton * infoBtn;

@property(nonatomic,strong)NSString * myCharge;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic,strong)UILabel * dueTimeLab;
@property (nonatomic, assign)id<TakePhotoDelegate>delegate;
@property (nonatomic, assign)id<showUserDataDelegate>userDatadelegate;
@property (nonatomic, assign)id<showUserInfoDelegate>userInfoDelegate;
-(void)showFromPlayHistory;
-(id)initMy;
-(void)show;

-(void)dismiss;

-(void)reloder;
-(void)makeLogInView;
-(void)mackNoLongInView;
-(void)configControl;
-(void)showRegistView;
-(void)clickLogIn;
-(void)showForgetPasswordView;
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;

@end

@protocol TakePhotoDelegate <NSObject>
-(void)takePhoto;
@end

@protocol showUserDataDelegate <NSObject>
-(void)clickTableViewIndex:(int)index;
-(void)showProgramView;
-(void)showLoginView;
-(void)dismissLoginView;
@end

@protocol showUserInfoDelegate <NSObject>
-(void)showUserInfoView;
@end
