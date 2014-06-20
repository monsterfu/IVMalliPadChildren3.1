//
//  ChildrenViewController.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserView.h"
#import "PopupGatherViewDelegate.h"
#import "Recommend8View.h"
#import "NoWifiView.h"
#import "GatherView.h"
#import "ProductPlayModel.h"
#import "BackView.h"
#import "ChannelCategoryListModel.h"
#import "ProgramPackage.h"
#import "PersonnalCenter.h"

@interface ChildrenViewController : UIViewController<PopupGatherViewDelegate,UIScrollViewDelegate,NoWifiViewDelegate,GatherViewDelegate,UIAlertViewDelegate>{
    NoWifiView*now;
    CGRect rect;
    NSDictionary*cacheDic;
    GatherView*gatherView;
    BackView*scroBackView;
    UIView*linView;
    NSString * productID;
    BOOL isLoadNextPage;
    int lastPage;
    BOOL isPlayBack;
    UIView* lodingBgView;
}

@property(nonatomic,assign)int index;
@property(nonatomic,strong)UIScrollView*myScrollView;

@property(nonatomic,strong)UIScrollView*scrollView2;

@property(nonatomic,strong)UIPageControl*pageCont;
@property(nonatomic,strong)NSMutableDictionary*allMutableDictionary;
@property(nonatomic,weak)UIButton*selectBut;
@property(nonatomic,strong)GatherView*gatherView;;

@property(nonatomic,strong)NSString*tmpCategoryId;

@property(nonatomic,assign)BOOL showSate;
@property(nonatomic,strong)Recommend8View*recomm;
@property(nonatomic,assign) int recTag;
@property(nonatomic,assign)BOOL isShowingAlartView;
@property(nonatomic,assign)BOOL isWifiResume;
@property(nonatomic,strong)ASIHTTPRequest * request;
-(void)clickClassButton:(int)sender;
    
@end
