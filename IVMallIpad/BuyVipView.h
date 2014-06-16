//
//  BuyVipView.h
//  IVMall HD
//
//  Created by  周传森 on 14-3-20.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Macro.h"
#import "Commonality.h"
#import "HttpRequest.h"

@protocol showProgramPackageDelegate <NSObject>
-(void)showProgramPackage;
@end

@protocol buyVipDelegate <NSObject>
-(void)buyVipViewWillShowWithTitle:(NSString *)title andPoints:(NSString *)points andVipID:(NSString *)vipID;
-(void)buyVipViewWillDismiss;
-(void)showRecharView;
@end

@interface BuyVipView : UIView<UIAlertViewDelegate>
{
    CGRect rect;
    CGRect tmpRect;
    UILabel * titleLabe;
    UIButton * buyBtn;
    
}
@property (nonatomic, strong) UIImageView * backgroundView;
@property (nonatomic, strong) UILabel * pointsLab;
@property (nonatomic, strong) UILabel * accountLab;
@property (nonatomic, strong) UILabel * vipTitleLab;
@property (nonatomic, strong) UILabel * balanceLab;
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, assign) BOOL hihel;
@property (nonatomic, strong) NSString * vipTitle;
@property (nonatomic, strong) NSString * points;
@property (nonatomic, strong) NSString * vipID;
@property (nonatomic, assign) BOOL isFromMainShowing;
@property (nonatomic, assign) id<showProgramPackageDelegate>delegate;
@property (nonatomic, assign) id<buyVipDelegate>buyVipDelegate;
-(id) initMy;
-(void) show;

-(void) dismiss;

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;

@end
