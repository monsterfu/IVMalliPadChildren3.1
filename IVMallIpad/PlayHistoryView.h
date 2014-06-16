//
//  PlayHistoryView.h
//  IVMall (Ipad)
//
//  Created by  周传森 on 14-3-13.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Macro.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "MJRefresh.h"
#import "IVMallPlayer.h"

@interface PlayHistoryView : UIView<MJRefreshBaseViewDelegate,MJRefreshShouldshowDelegate,ASIHTTPRequestDelegate,UITableViewDataSource,UIAlertViewDelegate,UITableViewDelegate,iPadPlayerCallBackDelegate>{
    CGRect rect;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    UIButton * check;
    CGRect tmpRect;
    UILabel * totalTimeLab;
    NSString * productID;
    int starTime;
    UIView * delSingelView;
    UIView * delAllView;
    UIView * selectedBackView;
}

@property(nonatomic,strong)UIView*myView;
@property(nonatomic,assign)BOOL hihel;
@property(nonatomic,assign)BOOL isShowing;
@property(nonatomic,strong)UITableView*tabelView;
@property(nonatomic,strong)NSMutableArray*tableArray;
@property(nonatomic,assign)int pageNum;
@property(assign,nonatomic) BOOL isEdit;
@property(nonatomic,strong)UIButton*editButton;
@property(nonatomic,strong)UIButton*backButton;

@property(nonatomic,strong)NSMutableArray *selectArray;

@property (nonatomic, strong) UIButton * delSingleBtn;
@property (nonatomic, strong) UIButton * delAllBtn;
@property (nonatomic, strong) NSString * tmpName;
@property (nonatomic, assign) BOOL isPlayHidend;
@property (nonatomic, strong) UIView * nodataView;
@property (nonatomic, strong) NSString * playUrl;

-(id) initMyWithFrame:(CGRect )newRect;
-(void) show;

-(void) dismiss;

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;

@end
