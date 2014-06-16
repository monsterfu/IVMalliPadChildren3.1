//
//  MainViewController.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-26.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupGatherViewDelegate.h"
#import "NoWifiView.h"
#import "ProductPlayModel.h"
#import "EScrollerView.h"
#import "GatherView.h"
#import "PersonnalCenter.h"
#import "AdListModel.h"
@interface MainViewController : UIViewController<UIScrollViewDelegate,NoWifiViewDelegate,UIAlertViewDelegate,EScrollerViewDelegate,iPadPlayerCallBackDelegate>{
    CGRect rect;
    UIView*tapView;
    UIButton*userButton;
    NoWifiView*now;
    
    UIActivityIndicatorView*activit;
    NSString * productID;
    EScrollerView * adscrollerView;
//    GatherView * gather;
    NSMutableArray * _imgArr;
    NSMutableArray * _titleArr;
    NSString * episodeGuid;
    int playTime;
    UIImageView * adBackgroundView;
    int loaded;
}
@property(nonatomic,strong)NSMutableArray*myArray;
@property(nonatomic, strong) NSMutableArray * adArr;
@property(nonatomic, strong) NSMutableArray * childrenArr;
@property(nonatomic,strong)UIScrollView*myScrollView;
@property (nonatomic,assign) BOOL wrap;
@property(nonatomic,assign) BOOL isShowingAlartView;
@property(nonatomic,assign) BOOL overTap;
@property(nonatomic,assign) BOOL isPlayBack;
@property(nonatomic,strong)GatherView * gather;
-(void)markHomeRequest;
-(void)clickUserButton:(UIButton*)sender;

    
@end
