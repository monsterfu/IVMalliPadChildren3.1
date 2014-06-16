//
//  CollectView.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-25.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Macro.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "MJRefresh.h"
#import "GatherView.h"
#import "IVMallPlayer.h"
@protocol showGatherViewDelegate;
@protocol showProgramViewDelegate;
@interface CollectView : UIView<MJRefreshBaseViewDelegate,MJRefreshShouldshowDelegate,ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,iPadPlayerCallBackDelegate>{
    CGRect rect;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    UIButton * check;
     CGRect tmpRect;
    UIView * lineView;
    NSString * productID;
    UIView * delSingelView;
    UIView * delAllView;
    UIView * selectedBackView;
}
@property(nonatomic,assign)BOOL hihel;
@property(nonatomic,assign)BOOL isShowing;
@property(nonatomic,strong)UITableView*tabelView;
@property(nonatomic,strong)NSMutableArray*tableArray;
@property(nonatomic,assign)int pageNum;
@property (assign, nonatomic) BOOL isEdit;
@property(nonatomic,strong)UIButton*editButton;
@property(nonatomic,strong)UIButton*backButton;

@property(nonatomic,strong)NSMutableArray *selectArray;

@property (nonatomic, strong) UIButton * delSingleBtn;
@property (nonatomic, strong) UIButton * delAllBtn;
@property (nonatomic, strong) NSString * tmpName;
@property (nonatomic, assign) BOOL isPlayHidend;
@property (nonatomic, strong) UIView * nodataView;
@property (nonatomic, strong) NSString * contentType;
@property (nonatomic, strong) GatherView * gat;
@property (nonatomic, strong) NSString * playUrl;
@property (nonatomic, assign) id<showGatherViewDelegate>showGatherDelegate;
@property (nonatomic, assign) id<showProgramViewDelegate>showProgramDelegate;
-(void)reloadContentView;
-(id) initMyWithFrame:(CGRect )newRect;
-(void) show;

-(void) dismiss;

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;


@end
@protocol showGatherViewDelegate <NSObject>
-(void)showGatherView:(NSString * )guid;
@end

@protocol showProgramViewDelegate <NSObject>
-(void)showProgramViewWithProID:(NSString *)productId;
@end
