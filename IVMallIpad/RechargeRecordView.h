//
//  RechargeRecordView.h
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
#import "MJRefresh.h"


@interface RechargeRecordView : UIView<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    CGRect rect;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    CGRect tmpRect;
    UILabel * _typeLab;
    UILabel * _pointLab;
    UILabel * _timeLab;
}
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, assign)BOOL hihel;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * tableArr;
@property (nonatomic, assign) int pageNum;
@property(nonatomic,assign)BOOL isShowing;
@property (nonatomic, strong) UIView * nodataView;
-(id) initMyWithFram:(CGRect)NewRect;
-(void) show;

-(void) dismiss;

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;

@end
