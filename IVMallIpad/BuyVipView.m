//
//  BuyVipView.m
//  IVMall HD
//
//  Created by  周传森 on 14-3-20.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "BuyVipView.h"
#import "UIButton+Bootstrap.h"
#import "AppDelegate.h"
#import "BuyVipModel.h"
#import "RechargeView.h"

@implementation BuyVipView

-(id)initMy{
    if (self=[super init]) {
        
        _isFromMainShowing = YES;
        rect=[[UIScreen mainScreen] bounds];
        
        UIViewController * main = [AppDelegate App].tabBarController;
        _myView = [[UIView alloc] init];
        _myView.frame = main.view.frame;
        _myView.backgroundColor=[UIColor blackColor];
        _myView.alpha=0;
        _myView.userInteractionEnabled=YES;
//        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//        tap.numberOfTapsRequired=1;
//        [_myView addGestureRecognizer:tap];
        
        self.frame=CGRectMake(72 , 303, rect.size.height - 400, rect.size.width- 350);
        tmpRect=self.frame;
        
        _backgroundView =[[UIImageView alloc] init];
        _backgroundView.image = [UIImage imageNamed:@"ConfirmationBuy.png"];
        [self addSubview:_backgroundView];
        
        self.backgroundColor=[UIColor whiteColor];
        
        UIView*heatView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, rect.size.height - 420, 80)];
        heatView.backgroundColor=[UIColor clearColor];
        
        UIButton * btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setImage:[UIImage imageNamed:@"返回2.png"] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [btn addTarget:self  action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor clearColor];
        btn.frame=CGRectMake(30, 30, 30, 30);
        [heatView addSubview:btn];
        
        
        CGRect rect1 = heatView.frame;
        titleLabe=[[UILabel alloc]initWithFrame:rect1];
        titleLabe.textColor=[UIColor blackColor];
        titleLabe.text=@"确认购买";
        titleLabe.font=[UIFont boldSystemFontOfSize:HEADVIEW_TITLESIZE];
        titleLabe.alpha = HEADVIEW_TITLE_ALPHA;
        titleLabe.textAlignment=NSTextAlignmentCenter;
        titleLabe.backgroundColor=[UIColor clearColor];
        [heatView addSubview:titleLabe];
        
        UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 5, 20)];
        view1.backgroundColor = [Commonality colorFromHexRGB:@"ef3363"];
        [self addSubview:view1];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 150, 20)];
        lab.textColor = [Commonality colorFromHexRGB:@"ef3363"];
        lab.text = @"开通会员";
        lab.font = [UIFont boldSystemFontOfSize:17];
        lab.backgroundColor = [UIColor clearColor];
        [self addSubview:lab];
        
        UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(115, 110, rect.size.height - 400 -140, 1)];
        view2.backgroundColor = [UIColor blackColor];
        view2.alpha = 0.2;
        [self addSubview:view2];
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake((rect.size.height - 400)/2-175, 172, 30, 30)];
        image.backgroundColor = [UIColor clearColor];
        image.image = [UIImage imageNamed:@"5 (1).png"];
        [self addSubview:image];
        
        _vipTitleLab = [[UILabel alloc] initWithFrame:CGRectMake((rect.size.height - 400)/2-125, 172, 200, 30)];
        _vipTitleLab.textAlignment = NSTextAlignmentLeft;
        _vipTitleLab.backgroundColor = [UIColor clearColor];
        _vipTitleLab.font = [UIFont boldSystemFontOfSize:15];
        _vipTitleLab.textColor = [UIColor blackColor];
        _vipTitleLab.alpha = 0.8;
        [self addSubview:_vipTitleLab];
        
        _accountLab = [[UILabel alloc] initWithFrame:CGRectMake((rect.size.height - 400)/2-125, 212, 200, 30)];
        _accountLab.textAlignment = NSTextAlignmentLeft;
        _accountLab.backgroundColor = [UIColor clearColor];
        _accountLab.font = [UIFont boldSystemFontOfSize:13];
        _accountLab.textColor = [UIColor blackColor];
        _accountLab.alpha = 0.4;
        [self addSubview:_accountLab];
        
        _balanceLab = [[UILabel alloc] initWithFrame:CGRectMake((rect.size.height - 400)/2-125, 242, 200, 30)];
        _balanceLab.textAlignment = NSTextAlignmentLeft;
        _balanceLab.backgroundColor = [UIColor clearColor];
        _balanceLab.font = [UIFont boldSystemFontOfSize:13];
        _balanceLab.textColor = [UIColor blackColor];
        _balanceLab.alpha = 0.4;
        [self addSubview:_balanceLab];
        
        buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake(rect.size.height - 400 - 150, rect.size.width- 350 - 80, 120, 51);
        [buyBtn setTitle:@"付款" forState:UIControlStateNormal];
        [buyBtn addTarget:self action:@selector(buyVip) forControlEvents:UIControlEventTouchUpInside];
//        [buyBtn redStyle];
        buyBtn.backgroundColor = color_4;
        [buyBtn childrenBtnStyleForBtn:buyBtn];
        UIView * view3 = [Commonality makeButtonShadowViewWhitbtn:buyBtn];
        
        [self addSubview:view3];
        [self addSubview:_myView];
        [self addSubview:heatView];
        
        [Commonality setImgViewStyle:self];
        self.layer.cornerRadius = 5;
        
//        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.height - 400 - 360, rect.size.width- 350 - 80, 60, 40)];
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(30, rect.size.width- 350 - 80, 60, 40)];
        lab1.backgroundColor = [UIColor clearColor];
        lab1.textColor = [UIColor blackColor];
        lab1.font = [UIFont boldSystemFontOfSize:15];
        lab1.text = @"总价：";
        lab1.alpha = 0.6;
        [self addSubview:lab1];
        
        _pointsLab = [[UILabel alloc] initWithFrame:CGRectMake(90, rect.size.width- 350 - 80, 120, 40)];
        _pointsLab.textColor = [Commonality colorFromHexRGB:@"ef3363"];
        _pointsLab.textAlignment = NSTextAlignmentLeft;
        _pointsLab.font = [UIFont boldSystemFontOfSize:22];
        _pointsLab.text = @"wat5etyet";
        _pointsLab.alpha = 0.8;
        [self addSubview:_pointsLab];
        
        
    }
    return self;
}

-(void)buyVip
{
    
    
//    UIAlertView *alvIew = [[UIAlertView alloc] initWithTitle:nil message:@"购买成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    alvIew.tag = 500;
//    [alvIew show];
////    [self dismiss];
////    if (_delegate && [_delegate respondsToSelector:@selector(showProgramPackage)]) {
////        [_delegate showProgramPackage];
////    }
//    return;
    
    
    //if ([[AppDelegate App].personModel.balance floatValue] > [_points floatValue]) {
    self.userInteractionEnabled = NO;
    buyBtn.userInteractionEnabled = NO;
        [HttpRequest BuyVipRequest:[AppDelegate App].personModel.tokenid vipGuid:_vipID points:_points delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
//    }
//    else
//    {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"余额不足" message:@"您的余额不足，现在去充值？" delegate:self cancelButtonTitle:@"稍后再充" otherButtonTitles:@"现在就去", nil];
//        alert.tag = 501;
//        [alert show];
//    }
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == 501) {
            //[self performSelector:@selector(showRechargeView) withObject:nil afterDelay:0.1];
            [self showRechargeView];
        }
    }
    
    else
    {
        
        if (alertView.tag == 501) {
            [self releaseRserInteractionEnabled];
            return;
        }
        
        [self dismiss];
        if (_delegate && [_delegate respondsToSelector:@selector(showProgramPackage)]) {
            self.userInteractionEnabled = YES;
            buyBtn.userInteractionEnabled = YES;
            [_delegate showProgramPackage];
        }
    }
}

-(void)showRechargeView
{
//    if (_isFromMainShowing == NO) {
//        if (_buyVipDelegate && [_buyVipDelegate respondsToSelector:@selector(showRecharView)]) {
//            [_buyVipDelegate showRecharView];
//        }
//    }
//    else
//    {
////        if ([AppDelegate App].rechargeView==nil) {
////            [AppDelegate App].rechargeView=[[RechargeView alloc]initMy];
////        }
////        
////        [Commonality anmou1View:[AppDelegate App].rechargeView delegate:[AppDelegate App].tabBarController];
////        [AppDelegate App].rechargeView.isFromMainShowing = _isFromMainShowing;
////        [[AppDelegate App].rechargeView show];
//        RechargeView * rechargeView = [[RechargeView alloc] initMy];
//        [Commonality anmou1View:rechargeView delegate:[AppDelegate App].tabBarController];
//        rechargeView.isFromMainShowing = _isFromMainShowing;
//        [rechargeView show];
//    }
    RechargeView * rechargeView = [[RechargeView alloc] initMy];
    [Commonality anmou1View:rechargeView delegate:[AppDelegate App].tabBarController];
    rechargeView.isFromMainShowing = _isFromMainShowing;
    [rechargeView show];
    [self performSelector:@selector(releaseRserInteractionEnabled) withObject:nil afterDelay:1];
}

-(void)releaseRserInteractionEnabled
{
    self.userInteractionEnabled = YES;
    buyBtn.userInteractionEnabled = YES;
}

-(void)show{
    UIViewController * main;
    _hihel=YES;
    
    _vipTitleLab.text = _vipTitle;
    _accountLab.text = [NSString stringWithFormat:@"爱V猫帐号：%@",[AppDelegate App].personModel.mobile];
    _balanceLab.text = [NSString stringWithFormat:@"帐号余额：%@猫币",[AppDelegate App].personModel.balance];
    _pointsLab.text = [NSString stringWithFormat:@"%@猫币",_points];
    
    //        self.center=CGPointMake(tmpRect.origin.x+tmpRect.size.width/2, tmpRect.origin.y+tmpRect.size.height);
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = CGPointMake(tmpRect.origin.x+tmpRect.size.width/2, tmpRect.origin.y+tmpRect.size.height/2);
                     }];
    if (_isFromMainShowing == NO) {
        main = [AppDelegate App].personView;
    }else{
        main = [AppDelegate App].tabBarController;
    }
    
    UIView * view1 = [main.view.subviews lastObject];
    UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
    view1.hidden = YES;
    view2.hidden = YES;
    
    _myView.frame = CGRectMake(0, 0, main.view.frame.size.width, main.view.frame.size.height);
    _myView.alpha = 0.5;
    [main.view addSubview:_myView];
    self.frame = CGRectMake(main.view.frame.size.width/2 - 312, main.view.frame.size.height/2 - 209, 624, 418);
    _backgroundView.frame = CGRectMake(-10, -10, self.frame.size.width + 20, self.frame.size.height + 30);
    [main.view addSubview:self];
}

-(void)dismiss{
    UIViewController * main;
    if (_isFromMainShowing == NO) {
//        if (_buyVipDelegate && [_buyVipDelegate respondsToSelector:@selector(buyVipViewWillDismiss)]) {
//            [_buyVipDelegate buyVipViewWillDismiss];
//        }
        main = [AppDelegate App].personView;
    }
    else
    {
        main = [AppDelegate App].tabBarController;
    }
    
        [UIView animateWithDuration:1.0
                         animations:^{
                             CGAffineTransform transform = CGAffineTransformScale(self.transform,0,0);
                             [self setTransform:transform];
                             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:self cache:YES];
                         } completion:^(BOOL finished) {
                             _hihel=YES;
                             [self removeFromSuperview];
                             [_myView removeFromSuperview];
                             
                             UIView * view1 = [main.view.subviews lastObject];
                             UIView * view2 = [main.view.subviews objectAtIndex:main.view.subviews.count - 2];
                             view1.hidden = NO;
                             view2.hidden = NO;
                             
                             self.transform = CGAffineTransformIdentity;
                         }];

    
}


-(void) GetErr:(ASIHTTPRequest *)request
{
    self.userInteractionEnabled = YES;
    buyBtn.userInteractionEnabled = YES;
    [Commonality showErrorMsg:self type:0 msg:LINGKERROR];
}
-(void) GetResult:(ASIHTTPRequest *)request
{
    
    NSData *responseData = [request responseData];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (dictionary==nil) {
        self.userInteractionEnabled = YES;
        buyBtn.userInteractionEnabled = YES;
        [Commonality showErrorMsg:self type:0 msg:@"网络连接异常，请重试"];
    }else{
        
        BuyVipModel * buyVip =[[BuyVipModel alloc] initWithDictionary:dictionary];
        if (buyVip.result == 0) {
            [AppDelegate App].personModel.balance = [NSString stringWithFormat:@"%0.2f",buyVip.balance];
            UIAlertView *alvIew = [[UIAlertView alloc] initWithTitle:nil message:@"购买成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alvIew.tag = 500;
            [alvIew show];
            return;
        }else if(buyVip.result == 107){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"余额不足" message:@"您的余额不足，现在去充值？" delegate:self cancelButtonTitle:@"稍后再充" otherButtonTitles:@"现在就去", nil];
            alert.tag = 501;
            [alert show];
            return;
        }
        else
        {
            self.userInteractionEnabled = YES;
            buyBtn.userInteractionEnabled = YES;
            [Commonality showErrorMsg:self type:buyVip.result msg:@"网络连接异常，请重试"];
            return;
        }
    }
    
    
//    [self dismiss];
    
}
@end
