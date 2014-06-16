//
//  BuyView.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-25.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Commonality.h"
#import "HttpRequest.h"
#import "Macro.h"
#import "MJRefresh.h"
#import "BuyListCell.h"
#import "BuyVipListCell.h"
@interface BuyView : UIView<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>{
    CGRect rect;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    CGRect tmpRect;
    UIButton * vipBtn;
    UIButton * programBtn;
}
@property(nonatomic,assign)BOOL isShowing;
@property(nonatomic,assign)BOOL hihel;

@property(nonatomic,strong)UITableView*tabelView;
@property(nonatomic,strong)NSMutableArray*tableArray;

@property(nonatomic,assign)int pageNum;

@property(nonatomic,assign)int vipPageNum;
@property(nonatomic,assign)BOOL isVipType;
@property(nonatomic,strong)NSMutableArray * vipTableArray;
//@property(nonatomic,strong)UILabel * indicatorLab1;
//@property(nonatomic,strong)UILabel * indicatorLab2;
@property(nonatomic, strong) UIView * nodataView;

-(id)initMyWithFrame:(CGRect )newRect;
-(void) show;

-(void) dismiss;

-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;

@end
