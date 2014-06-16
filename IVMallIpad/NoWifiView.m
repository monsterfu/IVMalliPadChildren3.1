//
//  NoWifiView.m
//  IVMall (Ipad)
//
//  Created by sean on 14-3-4.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "NoWifiView.h"
#import "AppDelegate.h"
#import "Commonality.h"
@implementation NoWifiView

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
//        CGRect rect=[[UIScreen mainScreen]bounds];
//        self.frame=CGRectMake(-100, 100, 400, rect.size.width-200);
        
        UIImageView*backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backImageView.backgroundColor=[UIColor blackColor];
        backImageView.alpha=0;
        [self addSubview:backImageView];
        
        UIImageView*imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NoNetwork.png"]];
        imgView.frame=CGRectMake((self.frame.size.width-250)/2, 90+[AppDelegate App].countIOS7, 250, 200);
        [self addSubview:imgView];
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.origin.x-50, imgView.frame.size.height+imgView.frame.origin.y, imgView.frame.size.width+100, 50)];
        lable.font=[UIFont boldSystemFontOfSize:22];
        lable.textColor=[UIColor whiteColor];
        lable.text=@"糟糕,网络断开.无法观看在线视频";
        lable.textAlignment=NSTextAlignmentCenter;
        lable.alpha=0.45;
        lable.backgroundColor=[UIColor clearColor];
        [self addSubview:lable];
        
        
        UIView*vie=[[UIView alloc]initWithFrame:CGRectMake((imgView.frame.size.width-150)/2+imgView.frame.origin.x, lable.frame.origin.y+80, 150, 30)];
        vie.layer.cornerRadius=4;
        vie.backgroundColor=[UIColor whiteColor];
        vie.alpha=0.1;
        [self addSubview:vie];
        
        UIButton*okButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [okButton setTitle:@"点击刷新" forState:(UIControlStateNormal)];
        okButton.backgroundColor=[UIColor clearColor];
        [okButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        okButton.frame=CGRectMake((imgView.frame.size.width-150)/2+imgView.frame.origin.x, lable.frame.origin.y+80, 150, 30);
        [self addSubview:okButton];
        
      
        
        
        
    }
    return self;
}

-(void)clickButton{
    if ([Commonality isEnableWIFI]==0) {
        return;
    }
    if (self.delegate!=nil) {
        [self.delegate callBackClickrech];
    }
    [self dismiss];
}

-(void) show{
    UIWindow*wind=[UIApplication sharedApplication].keyWindow;
    self.transform = CGAffineTransformMakeRotation(90 * (M_PI / 180.0f));
    
    [wind addSubview:self];
}

-(void) dismiss{
    [self removeFromSuperview];
}


@end
